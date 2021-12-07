
# estimativa da resolução-------------------------------------------------------
res_estim <- function(grid){
  xy <- dplyr::distinct(grid, X, Y)
  dx <- unique(diff(unique(sort(xy$X))))
  dy <- unique(diff(unique(sort(xy$Y))))  
  c(dx, dy)
}

# build raster from dataframe with xyz -----------------------------------------
raster_from_points <- function(datagrid, prj = "+proj=longlat +datum=WGS84"){
  # datagrid = ens_data[["data"]][[1]]
  mat <- datagrid %>%
    dplyr::select(X, Y, prec_ensmean) %>%
    as.matrix()
  
  #tic()
  r <- terra::rast(mat, type = "xyz")
  terra::crs(r) <- prj 
  #toc()
  # tic()
  # r <- raster::rasterFromXYZ(mat, res = res_estim(datagrid))
  # toc()
  # assumindo sem confirmar
  
  r
}

# basin averages over pols -----------------------------------------------------
basin_average <- function(datagrid, pols = pols_inc_sp, raster = FALSE){
  # datagrid = ens_data[["data"]][[1]]
  
  r <- raster_from_points(datagrid)
  
  if(raster){
    # demora demaiiiiisssssssssss!
    #tic()
    avg_basin <- c(t(raster::extract(
      raster(r),
      pols,
      weights = TRUE,
      normalizeWeights = TRUE,
      fun = mean
    )))
    #toc()
    # 5s
  } else {
    #tic()
    avg_basin <- terra::extract(
      r,
      terra::vect(pols),
      fun = mean,
      touches = TRUE,
      method = "bilinear"
    )[, "prec_ensmean"]
    #toc()
    # 0.4 s
    
  }
  
  tibble(codONS = pols$codONS, prec = avg_basin)
}


# Nome para os arquivos das medias nas bacias por S e L-------------------------
basin_avg_file_name <- function(slm, weight_mean = FALSE) {
  # slm <- iSLM
  
  fname <- paste0(
    c("", "S", "L"),
    c(slm$model, format(slm$S, "%Y%m%d"), slm$L)
  ) %>%
    paste(collapse = "_") 
  
  if(weight_mean) return(paste0(fname, "_basin-weigthed_avg.RDS"))
  
  paste0(fname, "_basin-avg.RDS")
  
}



## definicao/criacao do dir de saida das medias espaciais ---------------------
output_path_basin_avgs <- function(file, w_mean, out_path){
  imodel <- fs::path_file(file) %>%
    stringr::str_replace("ensemble-", "") %>%
    stringr::str_replace("\\.RDS", "")
  
  out_path <- ifelse(w_mean, 
                      here(out_path, "weighted", imodel), 
                      here(out_path, "arithmetic", imodel)
  )
  
  if(!fs::dir_exists(out_path)) fs::dir_create(out_path)
  out_path
}



## medias espaciais ------------------------------------------------------------
basin_avg_model <- function(file_model, 
                            pols_sp = pols_inc_sp, 
                            weighted_mean = FALSE,
                            dest_path = here("output/rds/basin-avgs")
                            ) {
  # file_model <- ens_files[1]; pols_sp = pols_inc_sp; weighted_mean = TRUE;dest_path = here("output/rds/basin-avgs") 
  tic()
  ens_data <- readr::read_rds(file_model)
  toc()
  # 7.127 sec elapsed

  ## definicao/criacao do dir de saida das medias espaciais
  dest_path <- output_path_basin_avgs(file_model, weighted_mean, dest_path)
    
  ## caso incompleto de NCEP-CFSv2, CMC2-CanCM4
  # ens_data <- ens_data %>%
  #   dplyr::filter(S >= lubridate::as_date("1997-07-01"))
  #   dplyr::filter(S >= lubridate::as_date("1994-07-01"))
  #  dplyr::filter(S >= lubridate::as_date("2005-03-01"))
    
    
  ens_data <- ens_data %>%
    dplyr::mutate(S = lubridate::as_date(S)) %>%
    dplyr::group_by(model, S, L) %>%
    tidyr::nest() %>%
    ungroup()

  
  
  # tic()
  # basin_average(datagrid = ens_data[["data"]][[1]])
  # diff(unique(ens_data$S)) # 30 dias entre as inicializações
  # length(unique(ens_data$S))/12 # 30 anos

  # toc()
  # 5.526 sec elapsed
  # length(ens_data[["data"]]) * 5/3600
  # [1] 6.6 horas

  tic()
  #plan(multisession, workers = 6)
  # samp <- ens_data[1:8,"data"]
  # bas_avg_model <- furrr::future_map(samp[["data"]], ~basin_average(.x))
  # bas_avg_model <- map(samp[["data"]], ~basin_average(.x))
  # bas_avg_model <- furrr::future_map(ens_data[["data"]] , ~basin_average(.x))
  #model_basin_avg_files <- furrr::future_map(
  model_basin_avg_files <- purrr::map(
    1:nrow(ens_data),
    #1:12,
    function(isl) {
      # isl = 1
      
      iSLM <- select(ens_data, S:model)[isl, ]
      basin_file <- basin_avg_file_name(slm = iSLM, weight_mean = weighted_mean)
      basin_file_path <- here(dest_path, basin_file)
      
      if(fs::file_exists(basin_file_path)) return(basin_file_path)
      
      bas_avg <- basin_average(
        datagrid = ens_data[["data"]][[isl]], 
        pols = pols_sp, 
        raster = weighted_mean
        #raster = FALSE
      )
      
      basin_data <- dplyr::bind_cols(iSLM, bas_avg)
      readr::write_rds(basin_data, basin_file_path)
      gc()
      
      cat(path_file(basin_file_path), "\n")
      
      basin_file_path
    }
  )

  toc()
  # 35 s com raster
  # 21 s com terra e furrr
  # 2.7 sec com terra e map
  gc()
  model_basin_avg_files
}


# dates from rds files with basin averages ------------------------------------
dates_from_model_rds_files <- function(dir_model_rds){
  x <- fs::dir_ls(dir_model_rds) %>%
    fs::path_file() %>%
    str_extract_all("S[0-9]{8}", simplify = TRUE) %>%
    as.Date("S%Y%m%d")  
  x
}
# imodel <- "CanCM4i"
# rds_dts <- dates_from_model_rds_files(here("output/rds/basin-avgs", imodel))
# range(rds_dts)



# agrupando dados por mes de inicialização(S) e leadtime (L)
# resulta na coluna 'data' com os pontos de grade do domínio
# cada linha corresponde a previsão de um membro para um mês de inicialização
# 456 (varia por modelo) meses x 456 linhas
# dimensions : 76, 56, 4256, 1  (nrow, ncol, ncell, nlayers)

# ATENCAO: NAO HÀ PREVISOES INICIADAS EM FEVEREIRO???
# if(check_ref_months){
#
#   out <- ens_data %>%
#     dplyr::mutate(#S = lubridate::as_date(S),
#       year = lubridate::year(S)
#       #month = lubridate::month(S)
#       ) %>%
#     select(-data) %>%
#     group_by(S) %>%
#     #summarise(nL = length(L)) %>% View()
#     mutate(model = imodel)
#
#     return(out)
# }


# -----------------------------------------------------------------------------
# Media espacial na area das bacias ONS para os dados de prec do CRU
basin_average_cru <- function(ncfile_obs = obs_nc_file,
                              vname = "pre",
                              prj = "+proj=longlat +datum=WGS84",
                              pols = pols_inc_sp, 
                              raster = FALSE) {
  cru_prec <- raster::brick(obs_nc_file, varname = vname)
  # recorte da AS para regiao dos poligonos das bacias
  cru_prec_basins <- raster::crop(cru_prec, pols)
  rm(cru_prec); gc()
  # define nome das datas
  cru_prec_basins <- raster::setZ(cru_prec_basins,
                                  z = getZ(cru_prec_basins),
                                  name = "Date"
  )
  
  # raster::writeRaster(cru_prec_basins, 
  #                     filename = "input/cru_ts4.04.1901.2019.bacias.nc", 
  #                     overwrite = TRUE)
  
  #plot(cru_prec_basins)
  
  if(raster){
    # demora mais!
    tic()
    avg_basin <- raster::extract(
      cru_prec_basins,
      pols,
      weights = TRUE,
      normalizeWeights = TRUE,
      fun = mean,
      df = TRUE
    )
    toc()
    # 5s
  } else {
    tic()
    avg_basin <- terra::extract(
      terra::rast(cru_prec_basins),
      terra::vect(pols),
      #weights = TRUE,
      #normalizeWeights = TRUE,
      fun = mean,
      touches = TRUE,
      method = "bilinear"
    )
    toc()
     
  }
  
  prec_cru_avg_basin <- avg_basin %>%
    as.data.frame() %>%
    as_tibble() %>%
    pivot_longer(cols = contains("X"), names_to = "date", values_to = "prec") %>%
    mutate(
      date = as_date(date, format = "X%Y.%m.%d"),
      codONS = pols$codONS[ID]
    ) %>%
    relocate(codONS, ID, date, prec) %>% 
    rename(prec_obs = prec)
  
  
  #tail(prec_cru_avg_basin)
  prec_cru_avg_basin
  
}