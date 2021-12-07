join_rds_model_nmme <- function(model_dir){
  
  # model_dir <- nmme_models_d[5]
  
  files_rds <- fs::dir_ls(model_dir, 
                          type = "file",
                          glob = "*.RDS"
                          )
  data_rds <- purrr::map_df(files_rds, readr::read_rds)
  
  # ERRO!
  data_trans <- data_rds %>%
    dplyr::arrange(codONS, S, L) %>%
    dplyr::mutate(
          Sr = floor_date(S + ddays(15), "month"),
          #date_lead = S + dmonths(trunc(L)) + ddays(15),
          #date_lead = lubridate::floor_date(as_date(date_lead), "month"),
          date_lead = Sr + dmonths(trunc(L)) + ddays(15),
          date_lead = lubridate::as_date(lubridate::floor_date(date_lead, "month"))
          )  %>% 
    dplyr::relocate(model, S, Sr, L, date_lead)
  data_trans
  
}




# # teste para conversao de S,L para date ----------------------------------
# data_test <- expand.grid(S = unique(data_trans$S),L = unique(data_trans$L)) %>%
#   as_tibble() %>%
#   arrange(S, L) 
# paste0(day(data_test$S), "-", month(data_test$S))  
# 
# data_test <- data_test %>%
#   dplyr::mutate(
#     date_lead = S + dmonths(trunc(L)) + ddays(15),
#     date_lead = lubridate::floor_date(as_date(date_lead), "month")
#   )
# head(as.data.frame(select(data_test, S:date_lead)), 30)
# tail(as.data.frame(select(data_test, S:date_lead)), 30)