# Funções para processamento dos dados
# de reforecast dos modelos nmme pre-processados (convertidos de nc para rds)

##------------------------------------------------------------------------------
# Funcao par extrai nome do modelo a partir do arquivo rds
model_name_rds <- function(file_rds, vname = "prec"){
  
  #file_rds = files_rds; vname = "prec"
  #file_rds
  nm <- fs::path_file(file_rds) %>%
    stringr::str_replace_all(pattern = glue::glue("nmme_{vname}_"), "") %>%
    stringr::str_replace_all(pattern = "_lt[0-9]{1,2}\\.[0-9]{1}\\.RDS", "") %>%
    unique()
  
  assert_true(length(nm) == 1)
  nm
  
}


# Média e desvio padrao dos membros de prec (ensemble) para cada ponto----------
ensemble_refcst <- function(refcst_rds, var_name = "prec", stat = "median") {
  # refcst_rds <- model_files_rds[2];var_name = "prec"; stat = "median"
  refcst <- readr::read_rds(refcst_rds)
  
  if(stat == "median"){
    refcst <- refcst[,
                     .(# mediana e mad (medidas stats + robustas)
                       prec_ensmed = median(prec),
                       prec_ensmad = mad(prec)
                     ),
                     #keyby = .(S, L)
                     by = c("S", "L", "X", "Y")
    ]  
    refcst[, model := model_name_rds(refcst_rds, var_name)]
    return(refcst)
  }
  
  refcst <- refcst[,
                   .(prec_ensmean = mean(prec),
                     prec_enssd = sd(prec)#,
                     # mediana e mad (medidas stats + robustas)
                     #prec_ensmed = median(prec),
                     #prec_ensmad = mad(prec)
                   ),
                   #keyby = .(S, L)
                   by = c("S", "L", "X", "Y")
  ]
  refcst[, model := model_name_rds(refcst_rds, var_name)]
  refcst
}


# medias dos membros de um modelo
# para formar prev por ensemble (por mes de inicialização, leadtime e modelo)
# o nome do modelo será inserido numa coluna
# pode ser aplicado a uma lista de arquivos rds separados por lead time
ensemble_refcst_files <- function(files_rds, variable, statistic){
  ens <- data.table::rbindlist(
    lapply(
      files_rds,
      function(ifile) {
        cat(fs::path_file(ifile), "\n")
        ensemble_refcst(refcst_rds = ifile, 
                        var_name = variable, 
                        stat = statistic
                        )
      }
    )
  )

  #187.09 sec elapsed
  ens <- ens[order(S, L)]
  ens
}



