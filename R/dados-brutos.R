pcks <- c("terra", "tidyverse", "here", "checkmate", "metR", "fs", "glue")
easypackages::libraries(pcks)

##### BASE DE DADOS - PREVISÃO RESTROSPECTIVA NNME - CanCM4i #####

# se você trabalha com Projeto do RStudio ele já abre diretamente
# no dir do projeto (clicando 2x no .Rproj).
# Evite usar setwd() ao trabalhar com projetos.
# setwd('~/github/download-hindcast-NMME/output/prec/CanCM4i/')
# trabalhe especificando caminhos a partir do caminho do projeto com o pacote
# here

here()
# "~/Dropbox/github/my_reps/lhmet/download-hindcast-NMME"




#--------------------------------------------------------------------------
nc_dir <- here("output", "prec")
count_ncs <- fs::dir_ls(nc_dir) %>%
  fs::path_ext() %>%
  table()
# total de arquivos nc
count_ncs
# 271

## listar todos os arquivos das previsões retrospectivas da precipitação CanCM4i
nc_files <- fs::dir_ls(path = nc_dir, glob = "*.nc")
path_file(nc_files)

# como o nome dos arquivos especifica o nome dos modelos
model_nm <- "CanCM4i"
model_files <- nc_files[grep(model_nm, nc_files)]

# variaveis e dimensoes com funcao do pacote metR
GlanceNetCDF(model_files[1])


#' Extrai o nome do modelo NMME a partir do nome do arquivo nc
#' @note Não testada para outros nomes de variáveis
#' @examples 
#' sample_files <- nc_files[sample(1:length(nc_files), 10)]
#' model_name(sample_files, "prec")
model_name <- function(nc_files, vname){
  path_file(nc_files) %>%
    str_replace_all(pattern = glue("nmme_{vname}_"), "") %>%
    str_replace_all(pattern = "_[0-9]{4}\\.nc", "")
}

#' Importa os dados de um arquivo netCDF e filtra para o lead time
#'
#' @param nc_file character escalar com caminho do arquivo netCDF
#' @param lead.time escalar numérico, 
filter_lead_time <- function(nc_file, lead_time = 0.5, var_name = "prec"){
  # nc_file <- model_files[1]; lead_time = 0.5; var_name = "prec"
  
  # dados em formato tidy
  prec_year_mod <- ReadNetCDF(nc_file)
  prec_year_mod <- prec_year_mod[L == lead_time]
  prec_year_mod <- prec_year_mod[, model := unique(model_name(nc_file, var_name))]
  
  prec_year_mod
}
#data_nc  <- filter_lead_time(model_files[1], lead_time = 0.5, var_name = "prec")


# Estou usando funções do pacote data.table
# não foi ensinado no curso de adar, é um pacote para manipulação
# mais eficiente e rápida de big data no R.
# Para entender as funções consulte o cartão 
# https://trello.com/c/DWnuJWnT


#' Extrai os dados  de um modelo para os arquivos de entrada fornecidos , para 1 lead time
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
    dt_file <- glue("nmme_{var_name}_{model_id}_lt{lead_time}.RDS")
    dt_file <- fs::path(dest_dir, dt_file)
    readr::write_rds(DT, dt_file)
    checkmate::check_file_exists(dt_file)
    message("data were save at ", "\n", dt_file)
  }
  DT
}




# Próximo passo: fazer looping para escrever arquivos RDS para todos lead times.
data_for_lt <- lapply(x : y, # 0.5 : 11.5
                      function(lt)
                        data_model_lt(
                          lead_time = lt,
                          nc_model_files = model_files,
                          var_name = "prec"
                        )
)

