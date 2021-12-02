pcks <- c("terra", "tidyverse", "here", "checkmate", "metR", "fs", "glue")
easypackages::libraries(pcks)

## Funções para processamento dos dados netcdf------------------------------
source(here("R", "data-proc-nc.R"))

## util somente no caso de obter os dados do google drive ----------------------
# source(here("R", "unzip-nc.R"))
# unzip_ncs()

## listar todos os arquivos das previsões retrospectivas da precipitação CanCM4i
nc_dir <- here("output", "prec")

# count_ncs <- fs::dir_ls(nc_dir) %>%
#   fs::path_ext() %>%
#   table()
## total de arquivos nc
# count_ncs
#  271

nc_files <- fs::dir_ls(path = nc_dir, glob = "*.nc")

model_counts <- nc_files_by_model_year(nc_files)
# modelo       start   end  freq check_span
# <chr>        <int> <int> <int>      <dbl>
# 1 CanCM4i       1981  2018    38         38
# 2 CanSIPSv2     1981  2018    38         38
# 3 CMC1-CanCM3   1981  2010    30         30
# 4 CMC2-CanCM4   1981  2010    30         30
# 5 GEM-NEMO      1981  2018    38         38
# 6 NASA-GEOSS2S  1981  2017    37         37
# 7 NCAR-CESM1    1980  2010    31         31
# 8 NCEP-CFSv2    1982  2010    29         29


# como o nome dos arquivos especifica o nome dos modelos
#model_nm <- "CanCM4i"
(model_nms <- model_counts$modelo)
#files_model <- nc_files[grep(model_nms, nc_files)]


# # para obter informacao do leat time
# model_nm <- "CanCM4i"
# model_files <- nc_files[grep(model_nm, nc_files)]
# # variaveis e dimensoes com funcao do pacote metR
# nc_info <- GlanceNetCDF(model_files[1])
# nc_info
# # nc_info é uma lista
# #str(info)
# # lead time pode ser obtido dela
# str(nc_info$dims$L)
# (lt <- nc_info$dims$L$vals)


# looping para processar dados (excluindo os modelos já processados)
map(model_nms,
    function(imodel){
      # imodel = model_nms[1]
      cat(imodel, "-------\n", "\n")
      gc()
      proc_ncs_by_lt(model = imodel, ncfiles_d = nc_dir)
    })


