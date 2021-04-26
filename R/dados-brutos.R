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


## util somente no caso de obter os dados do google drive ----------------------
# source(here("R", "unzip-nc.R"))
# unzip_ncs()

## Funções para processamento dos dados netcdf----------------------------------
source(here("R", "data-proc-nc.R"))

#-------------------------------------------------------------------------------
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
nc_info <- GlanceNetCDF(model_files[1])
nc_info
# nc_info é uma lista
#str(info)
# lead time pode ser obtido dela
str(nc_info$dims$L)
(lt <- nc_info$dims$L$vals)


# Processamento dos dados de um modelo, para cada lead time,
# agregando os dados de todos os anos.
rds_files_by_lt <- lapply(lt,
                      function(i_lt){
                        cat(i_lt, "\n")
                        data_model_lt(
                          lead_time = i_lt,
                          nc_model_files = model_files,
                          var_name = "prec"
                        )
                      }
) 

rds_files_by_lt <- unlist(rds_files_by_lt)
rds_files_by_lt


# Próximo passo aplicar aos demais modelos 
# looping em 'model_nm' 
# escrever função que a partir de model_nm retorne lista de arquivos rds
# como a acima

