## Funções para o processamento dos arquivos NetCDF
## 

#----------------------------------------------------------------------------
# Pré-processamento adicional. Os dados que baixei do gdrive são zipados.
# foram salvos no output.

extract_zip <- function(ifile, ex_dir) {
  # ifile = zips[1]
  cat(ifile, "\n", dest_dir, "\n")
  unzip(ifile, exdir = dest_dir, jun) #%>% select(Name) %>% pull()
}

unzip_ncs <- function(vname = "prec", ex_dir = "output"){
  zips <- fs::dir_ls(ex_dir, 
                     regexp = stringr::str_replace("vname.*zip$", "vname", vname)
  )  
  
  dest_dir <- fs::dir_create(here(ex_dir, vname))
  
  # a função map é para fazer looping, descompactando cada zip
  #purrr::map(zips, extract_zip)
  purrr::walk(zips, extract_zip) 
  
}



#' Extrai o nome do modelo NMME a partir do nome do arquivo nc
#' @note Não testada para outros nomes de variáveis
#' @examples 
#' sample_files <- nc_files[sample(1:length(nc_files), 10)]
#' model_name(sample_files, "prec")
model_name <- function(nc_files, vname){
  fs::path_file(nc_files) %>%
    stringr::str_replace_all(pattern = glue::glue("nmme_{vname}_"), "") %>%
    stringr::str_replace_all(pattern = "_[0-9]{4}\\.nc", "")
}

# Obtem ano do arquivo nc a partir do nome do arquivo
year_from_ncfile <- function(nc_files){
  fs::path_file(nc_files) %>%
    str_extract_all("[0-9]{4}") %>%
    unlist() %>%
    as.integer()
}


# Contagem de arquivos por modelo e ano
nc_files_by_model_year <- function(nc_files){
  # verificação do numero de arquivos com periodos
  model_counts <- tibble(file = nc_files, 
                         modelo = model_name(nc_files, vname = "prec"),
                         ano = year_from_ncfile(nc_files)
  ) %>%
    group_by(modelo) %>%
    summarise(start = min(ano), end = max(ano), freq = n()) %>%
    mutate(check_span = end-start+1)
  
  saveRDS(model_counts, file = here("output", "rds", "model_counts.RDS"))
  model_counts
}






#' Importa os dados de um arquivo netCDF e filtra para o lead time
#'
#' @param nc_file character escalar com caminho do arquivo netCDF
#' @param lead.time escalar numérico 
filter_lead_time <- function(nc_file, lead_time = 0.5, var_name = "prec"){
  # nc_file <- nc_files[1]; lead_time = 0.5; var_name = "prec"
  
  # dados em formato tidy
  prec_year_mod <- ReadNetCDF(nc_file)
  prec_year_mod <- prec_year_mod[L == lead_time]
  prec_year_mod <- prec_year_mod[, model := unique(model_name(nc_file, var_name))]
  prec_year_mod <- prec_year_mod[, year := year_from_ncfile(nc_file)]
  
  
  prec_year_mod
}
#data_nc  <- filter_lead_time(model_files[1], lead_time = 0.5, var_name = "prec")


# Estou usando funções do pacote data.table
# não foi ensinado no curso de adar, é um pacote para manipulação
# mais eficiente e rápida de big data no R.
# Para entender as funções consulte o cartão 
# https://trello.com/c/DWnuJWnT


#' Extrai os dados de todos arquivos netcdf de um modelo, para 1 lead time.
#'
#' @param nc_model_files vetor do tipo character com nomes dos arquivos netCDF.
#' @param var_name nome da variável ("prec", "tmax", "tmin").
#' @param lead_time tempo de antecedência de interesse (de 0.5 a 11.5)
#' @param dest_dir diretório de destino para o arquivo RDS. Pré definido como
#' `output/rds`. Se for NULL os dados não são exportados para um arquivo RDS.
#' @return data.table
#' @details 
#' @export
#'
#' @examples
#' # lê e salva os dados em um RDS
#' model_data_lt15 <- data_model_lt(
#'   model_files, lead_time = 11.5, var_name = "prec"
#' )
#' # apenas lê os dados
#' model_data_lt05 <- data_model_lt(
#'      model_files, lead_time = 0.5, var_name = "prec", dest_dir = NULL
#' )
#' 
data_model_lt <- function(
  nc_model_files,
  lead_time, 
  var_name, 
  dest_dir = here("output", "rds")
) {
  DT <- data.table::rbindlist(
    lapply(
      nc_model_files,
      function(file_nc) {
        cat(file_nc, "\n")
        filter_lead_time(file_nc, lead_time, var_name)
      }
    )
  )
  if(!is.null(dest_dir)){
    if(!dir_exists(dest_dir)) fs::dir_create(dest_dir)
    model_id <- DT[["model"]][1]
    dt_file <- glue::glue("nmme_{var_name}_{model_id}_lt{lead_time}.RDS")
    dt_file <- fs::path(dest_dir, dt_file)
    readr::write_rds(DT, dt_file)
    checkmate::check_file_exists(dt_file)
    message("data were save at ", "\n", dt_file)
    return(dt_file)
  }
  DT
}



#Processa ncs de um modelo para todos lead times--------------------------------
proc_ncs_by_lt <- function(model = model_nms[3], 
                           lead_time = seq(0.5, 11.5, by = 1), 
                           ncfiles_d = here("output", "prec")){
  
  nc_files <- fs::dir_ls(path = ncfiles_d, 
                         regexp = paste0(model, ".*\\.nc"),
  )
  
  map_chr(lead_time, 
          ~.x %>% 
            data_model_lt(nc_files, 
                          lead_time = ., 
                          var_name = "prec"
            )
  )
}





