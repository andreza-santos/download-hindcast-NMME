
pcks <- c("tidyverse", "here", 
          "checkmate", "lubridate",
          "tictoc")
easypackages::libraries(pcks)

avg_type <- "arithmetic"

out_dir <- here(str_replace("output/rds/basin-avgs/average_type", "average_type", avg_type))

# nmme
prec_nmme_avg_basin_file <- here(out_dir, 
                                 str_replace("nmme-models-average_type-avg-basins-ons.RDS",
                                             "average_type", 
                                             avg_type
                                             )
                                 )

prec_nmme_avg_basin <- readr::read_rds(prec_nmme_avg_basin_file) %>%
  mutate(data = map(data, 
                    ~.x %>% 
                      rename("date" = date_lead,
                             "prec_model" = prec) %>%
                      mutate(prec_model = prec_model * 30) # 30 eh o num de dias no calendario dos modelos
                    )
         # ,
         # prec_min = map_dbl(data, 
         #                    function(x) min(x$prec_model, na.rm = TRUE)
         # ),
         # prec_max = map_dbl(data, 
         #                    function(x) max(x$prec_model, na.rm = TRUE)
         # )
) # 30.4175


# obs ----------------------------------------------------------------
prec_cru_avg_basin_file <- here(out_dir, 
                                str_replace("cru-prec-basins-average_type-avg.RDS",
                                            "average_type", 
                                            avg_type
                                            )
                                )
prec_cru_avg_basin <- readr::read_rds(prec_cru_avg_basin_file) %>%
  mutate(ID = NULL,
         # ajuste das datas
         date = lubridate::floor_date(date, unit = "months"))
str(prec_cru_avg_basin)
summary(prec_cru_avg_basin)

# check how to join-----
# pred <- prec_nmme_avg_basin[["data"]][[1]] 
# summary(pred)
# comb_nmme_obs <- dplyr::inner_join(pred, prec_cru_avg_basin, 
#                                    by = c("date", "codONS")
#                                    )
# tail(as.data.frame(comb_prec_obs), 30)


# Combinacao de dados prec Obs e Model-----------------------------------------
prec_nmme_avg_basin <- prec_nmme_avg_basin %>%
  mutate(data = map(data, 
                    ~.x %>% 
                      dplyr::inner_join(
                        prec_cru_avg_basin, 
                        by = c("date", "codONS")
                      )
                    )
         )
prec_nmme_avg_basin[["data"]][[8]]

readr::write_rds(prec_nmme_avg_basin, 
                 file = here(out_dir, 
                             str_replace("nmme-cru-mly-average_type-avg-basins-ons.RDS",
                                         "average_type",
                                         avg_type
                                         )
                 ))
summary(prec_nmme_avg_basin[["data"]][[1]])
