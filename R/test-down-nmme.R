
# teste de download NMME
pcks <- c("terra", "tidync", "tidyverse", "fs", "tictoc", "data.table")
easypackages::libraries(pcks)
options(timeout=150)


#' Baixa o arquivo anual da previsao retrospectiva do NMME para a AS
#' Download da previsao retrospectiva do Sistema NMME recortado para 
#' a America do Sul, incluindo os 12 tempos de antecedencia e os 10
#' tempos de inicio da previsao.  
#'
#' @param ano 
#' @param modelo 
#' @param variavel 
#'
#' @return
#' @export
#'
#' @examples
down_nmme <- function(ano = 1981, modelo = "CanCM4i", variavel = "prec"){
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

source(here("R", "models-nmme.R"))

start_y <- 1980
end_y <- 2018
modelos = tabela1$modelo

# baixados_prec_CanCM4i <- lapply(start_y : end_y,
#                                 function(iano) down_nmme(ano = iano)
#                                 )
baixados_prec <- lapply(start_y : end_y,
                        function(iano) down_nmme(modelo = modelos, ano = iano)
)
baixados_temp <- lapply(start_y : end_y,
                        function(iano) down_nmme(modelo = modelos, variavel = temp, ano = iano)
)
# baixados_dados <- lapply(start_y : end_y,
#                         function(iano) down_nmme(modelo = modelos, variavel = variaveis, ano = iano)
# )

toc()