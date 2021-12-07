pcks <- c("raster", "terra", "tidyverse", "here", 
          "checkmate", "metR", "fs", "lubridate",
          "tictoc", "furrr")
easypackages::libraries(pcks)


source(here("R", "data-proc-basin.R"))

## poligonos bacias ------------------------------------------------------------
# arquivo RDS disponibilizado em 
pols_inc <- readr::read_rds(here("input", "poligonos-bacias-incrementais.RDS")) %>%
  sf::st_transform(crs = "+proj=longlat +datum=WGS84") %>%
  dplyr::select(codONS, nome, area)

pols_inc_sp <- as(pols_inc, "Spatial")
#plot(pols_inc_sp)

## dados CRU (observacoes) ------------------------------------------------
obs_nc_file = "~/Dropbox/datasets/climate_datasets/superficie/CRU-TS4.04/cru_ts4.04.1901.2019.pre.dat.nc"
#"input/obs/prec/cru_ts4.04.1901.2019.pre.dat.nc"
file.exists(obs_nc_file)
# prec_cru <- ReadNetCDF(obs_nc_file)
# gc()
#prec_cru[!is.na(pre), ]


cru_prec_wavg_pols <- basin_average_cru(
  ncfile_obs = obs_nc_file,
  vname = "pre",
  prj = "+proj=longlat +datum=WGS84",
  pols = pols_inc_sp,
  raster = TRUE
)
readr::write_rds(cru_prec_wavg_pols, 
                    file = here("output/rds/basin-avgs/weighted", 
                                    "cru-prec-basins-weighted-avg.RDS"
                                    )
                    )




cru_prec_avg_pols <- basin_average_cru(
  ncfile_obs = obs_nc_file,
  vname = "pre",
  prj = "+proj=longlat +datum=WGS84",
  pols = pols_inc_sp,
  raster = FALSE
)
readr::write_rds(x = cru_prec_avg_pols, 
                    file = here("output/rds/basin-avgs/arithmetic", 
                                    "cru-prec-basins-arithmetic-avg.RDS"
                    )
                 )



