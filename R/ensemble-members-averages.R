

pcks <- c("raster", "terra", "tidyverse", "here", 
          "checkmate", "metR", "fs", "lubridate",
          "tictoc")
easypackages::libraries(pcks)


source(here("R", "data-proc-rds.R"))

##------------------------------------------------------------------------------


path_rds <- here("output", "rds")
model_counts <- readr::read_rds(here(path_rds, "model_counts.RDS"))
models <- model_counts$modelo
#files_rds <- dir_ls(path_rds, pattern = "CanCM4i")



# Para os arquivos RDS de um modelo, separados por lead time
# media das previsoes dos 10 membros nos pontos de grade,
# para cada mes de inicializ., lead time

ensemble_model_refrcst <- function(imodel, var_name = "prec", stat = "median"){
  # imodel = model_counts$modelo[2]  
  #model_name_rds(model_files_rds, vname = "prec")  
  cat(imodel, "\n")
  model_files_rds <- dir_ls(path_rds, regexp = imodel)
  ens_model_refcst <- ensemble_refcst_files(refcst_rds = model_files_rds, 
                                            variable = var_name, 
                                            statistic = stat
                                            )
  out_rds <- here(path_rds,
                  paste0("ensemble-", 
                         imodel, 
                         "-", 
                         stat,
                         ".RDS"
                         )
  )
  saveRDS(ens_model_refcst, file = out_rds)
  out_rds
}

# looping nos modelos
tic()
map(models, ensemble_model_refrcst)
toc()




# check dates of S ------------------------------------------------------------
here("output", "prec", "nmme_prec_CMC1-CanCM3_1981.nc") %>%
  metR::ReadNetCDF(., "prec") %>%
  group_by(S,L, Y, X) %>%
  summarise(prec = mean(prec)) %>%
  arrange(desc(X))


#readRDS(here("output", "rds", "nmme_prec_CMC1-CanCM3_lt0.5.RDS"))
ens_data %>% filter(L == 0.5, model == "CMC1-CanCM3")
