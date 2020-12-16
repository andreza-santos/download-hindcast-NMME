
# teste de download NMME
pcks <- c("terra", "tidync", "tidyverse", "fs", "tictoc", "data.table")
easypackages::libraries(pcks)



#' Baixa o arquivo anual da previsao retrospectiva do NMME para a AS
#' Download da previsao retrospectiva do Sistema NMME recortado para 
#' a America do Sul, incluindo os 12 tempos de antecedencia e os 10
#' tempos de inicio da precisao.  
#'
#' @param ano 
#' @param modelo 
#' @param variavel 
#'
#' @return
#' @export
#'
#' @examples
down_nmme <- function(ano = 1981, modelo = "CanSIPSv2", variavel = "prec"){
  # ano <- as.character(1981);  modelo <- "CanCM4i";variavel <- "prec"
  
  ano <- as.character(ano)
  
  
  data_link <- paste0(
    "http://iridl.ldeo.columbia.edu/SOURCES/.Models/.NMME/",
    # modelo
    ".modelo/.HINDCAST/.MONTHLY/",
    # variavel
    ".variavel/",
    # Forecast Start Time (forecast_reference_time)
    "S/%280000%201%20Jan%20YYYY%29%280000%2030%20Dec%20YYYY",
    # sub dominio
    "%29RANGEEDGES/X/%2830W%29%2885W%29RANGEEDGES/Y/%2860S%29%2815N%29RANGEEDGES/",
    # nome dop arq default
    "data.nc"
  )
  
  prefix <- paste0("nmme_", variavel, "_", modelo, "_", ano) 
  dest_file <- path("/home/andreza/Desktop/test-down-NMME/output", 
                    str_replace(path_file(data_link), "data", prefix)
  )
  
  Sys.sleep(1)
  
  data_link_ano <- str_replace_all(data_link, "variavel", variavel)
  data_link_ano <- str_replace_all(data_link_ano, "modelo", modelo)
  data_link_ano <- str_replace_all(data_link_ano, "YYYY", ano)
  
  #path_file(data_link_ano)
  message("Baixando arquivo: ", dest_file)
  
  download.file(data_link_ano, destfile = dest_file, mode = "wb")
  
  if(file.exists(dest_file)){
    return(dest_file)
  }
  
  return(paste0("Nao foi possivel baixar o arquivo: ", dest_file))  
}

tic()

start_y <- 1981
end_y <- 2018

# baixados_prec_CanCM4i <- lapply(start_y : end_y, 
#                                 function(iano) down_nmme(ano = iano)
#                                 )
baixados_prec <- lapply(start_y : end_y, 
                                function(iano) down_nmme(ano = iano)
)
toc()

## aperfeicoamentos futuros
#anos <- 1981:2018
#modelos <- c("CanCM4i",
#              "CanSIPSv2",
#              "CMC1-CanCM3",
#              "CMC2-CanCM4",
#              "GEM-NEMO",
#              "NASA-GEOSS2S",
#              "NCAR-CESM1",
#              "NCEP-CFSv2")
#variaveis <- c("prec", "sst")

#tabela_control <- expand.grid(variaveis, modelos, anos) %>%
#  as.data.frame() %>%
#  setNames(c("var", "modelo", "ano")) %>%
#  as_tibble() %>%
#  mutate_all(.funs = as.character) %>%
#  arrange(modelo, var)

# montar tabela de ano inicial e final de cada modelo
models <- data.table(modelos = c("CanCM4i", "CanSIPSv2", "CMC1-CanCM3",
                                 "CMC2-CanCM4", "GEM-NEMO", "NASA-GEOSS2S",
                                 "NCAR-CESM1", "NCEP-CFSv2"),  
                     ano_i = c("1981", "1981", "1981",  
                               "1981", "1981", "1981",   
                               "1980", "1982"),  
                     ano_f = c("2018", "2018", "2010",
                               "2010", "2018", "2017", 
                               "2010", "2010"),
                     n_membros = c(10, 20, 10,
                                  10, 10, 4,
                                  10, 24),
                     lead = c("0.5-11.5", "0.5-11.5", "0.5-11.5",
                              "0.5-11.5", "0.5-11.5", "0.5-8.5",
                              "0.5-11.5", "0.5-9.5")
)

# ver nomes das variaveis
# Total Precipitation (mm/day): prec

# CanCM4i, CanSIPSv2, CMC1-CanCM3, CMC2-CanCM4 e GEM-NEMO: "tmax" e "tmin"
# NASA-GEOSS2S: "t2mmax" e "t2mmin"
# NCAR-CESM1: Daily minimum of average 2-m temperature ("tsmn")
#             Daily maximum of average 2-m temperature ("tsmx")
# NCEP-CFSv2: Reference Temperature ("tref")


# verificacao
#files_nc <- dir_ls("../output", glob = "*.nc")
#range(rast(files_nc[1])[])
#range(rast(files_nc[2])[])
#tidync::hyper_tibble(files_nc[1])
#tidync::hyper_tibble(files_nc[2])
#summary(tidync::hyper_tibble(files_nc[2]))

