pcks <- c("raster", "terra", "tidyverse", "here", 
          "checkmate", "metR", "fs", "lubridate",
          "tictoc", "furrr")
easypackages::libraries(pcks)


source(here("R/data-join-rds.R"))

## join rds files ------------------------------------------------------------
basin_avg_d <- here("output/rds/basin-avgs/arithmetic")
#basin_avg_d <- here("output/rds/basin-avgs/weighted")
nmme_models_d <- dir_ls(basin_avg_d, type = "directory")
joined_rds <- path(basin_avg_d, "nmme-models-arithmetic-avg-basins-ons.RDS")
#joined_rds <- path(basin_avg_d, "nmme-models-weighted-avg-basins-ons.RDS")

if(!checkmate::test_file_exists(joined_rds)){
  
  tictoc::tic()
   basin_avg_nmme <- map_df(nmme_models_d, join_rds_model_nmme)
  tictoc::toc()
  # 5 min elapsed
   basin_avg_nmme <- basin_avg_nmme %>%
    group_by(model) %>%
    nest()
  write_rds(basin_avg_nmme, 
            file = joined_rds
  )
} else {
  basin_avg_nmme <- readr::read_rds(joined_rds)
}


# Verificação do período de dados dos modelos--------------------
temp <- basin_avg_nmme %>%
  mutate(sdate = map_chr(data, 
                     ~.x %>% 
                       pull(date_lead) %>% 
                       min() %>%
                       as.character()
                     ),
         edate= map_chr(data, 
                    ~.x %>% 
                      pull(date_lead) %>% 
                      max() %>%
                      as.character()
         ),
         data = NULL)

temp
read_rds("output/rds/model_counts.RDS")


# -----------------------------------------------
# library(openair)
# d <- basin_avg_nmme[["data"]][[8]]
# d <- rename(d, "date" = date_lead) %>%
#   mutate(L = as.factor(L)) %>%
#   filter(codONS == 74)
# 
# d %>%
#   select(-date, -S) %>%
#   rename(date = Sr) %>%
#   pivot_wider(names_from = L, values_from = prec) %>%
#   timePlot(., names(.)[-c(1,2)], group = TRUE)
