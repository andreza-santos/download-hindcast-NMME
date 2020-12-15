
# teste de download NMME
pcks <- c("terra", "tidync", "tidyverse", "fs")
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
  dest_file <- path("../output", 
                    str_replace(path_file(data_link), "data", prefix)
  )
  
  Sys.sleep(1)
  
  data_link_ano <- str_replace_all(data_link, "variavel", variavel)
  data_link_ano <- str_replace_all(data_link_ano, "modelo", modelo)
  data_link_ano <- str_replace_all(data_link_ano, "YYYY", ano)
  
  #path_file(data_link_ano)
  
  download.file(data_link_ano, destfile = dest_file, mode = "wb")
  
  if(file.exists(dest_file)){
    return(dest_file)
  }
  
  return(paste0("Nao foi possivel baixar o arquivo: ", dest_file))  
}

start_y <- 1983
end_y <- 2018 

baixados_prec_CanCM4i <- lapply(start_y : end_y, 
                                function(iano) down_nmme(ano = iano)
                                )


anos <- 1981:2018
modelos <- c("CanCM4i", "CanSIPSv2", "CMC1-CanCM3")
variaveis <- c("prec", "temp")

tabela_control <- expand.grid(variaveis, modelos, anos) %>%
  as.data.frame() %>%
  setNames(c("var", "modelo", "ano")) %>%
  as_tibble() %>%
  mutate_all(.funs = as.character) %>%
  arrange(modelo, var)

# montar tabela de ano inicial e final de cada modelo
# ver nomes das variaveis

  






# verificacao
files_nc <- dir_ls("../output", glob = "*.nc")

range(rast(files_nc[1])[])
range(rast(files_nc[2])[])

tidync::hyper_tibble(files_nc[1])
tidync::hyper_tibble(files_nc[2])

summary(tidync::hyper_tibble(files_nc[2]))

