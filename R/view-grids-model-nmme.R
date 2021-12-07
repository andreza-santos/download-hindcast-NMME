pcks <- c("raster", "terra", "tidyverse", "here", 
          "checkmate", "metR", "fs", "lubridate",
          "tictoc", "furrr")
easypackages::libraries(pcks)


source(here("R", "data-proc-basin.R"))

## poligonos bacias ------------------------------------------------------------
# arquivo RDS disponibilizado em 
pols_inc <- readr::read_rds("~/Dropbox/datasets/GIS/BaciaHidrograficaONS-enviadoProfAssis/poligonos-bacias-incrementais.RDS") %>%
  sf::st_transform(crs = "+proj=longlat +datum=WGS84") %>%
  dplyr::select(codONS, nome, area)

pols_inc_sp <- as(pols_inc, "Spatial")
#plot(pols_inc_sp)


## dados de prec do CRU --------------------------------------------------------
# Grades do CRU nas bhs
library(terra)
cru_prec <- raster::brick(
  "~/Dropbox/datasets/climate_datasets/superficie/CRU-TS4.04/cru_ts4.04.1901.2019.pre.dat.nc",
  varname = "pre" 
)
cru_r <- raster::subset(cru_prec, raster::nlayers(cru_prec))
#plot(cru_r)
cprec <- raster::crop(cru_r, pols_inc_sp)
#plot(cprec)
#plot(pols_inc, add = TRUE, border = 1, col = NA)

cprec_pols <- raster::rasterToPolygons(cprec)
cprec_pols <- sf::st_as_sfc(cprec_pols)
#plot(cprec_pols)
#plot(pols_inc[1], add = TRUE, border = 2, col = NA, lwd = 2)

# BHs com area maior que 50 * 50 km2
a_km2 <- raster::area(cprec)
amx_km2 <- raster::cellStats(a_km2, max)

pols_inc_large <- pols_inc %>%
  dplyr::filter(area > units::set_units(amx_km2, km^2)) #%>%
#st_geometry(.) #%>%  plot(border = "red", col = NA)
pols_inc_large_ll <- sf::st_transform(pols_inc_large, sf::st_crs(cprec_pols))
cprec_pols_inters <- sf::st_intersection(pols_inc_large_ll, cprec_pols)

plot(sf::st_geometry(pols_inc_large_ll), border = "red", col = NA)
plot(sf::st_geometry(cprec_pols), add = TRUE, border = "gray90", lwd = 0.4, col = NA)
plot(sf::st_geometry(cprec_pols_inters), add = TRUE, border = "red", lwd = 0.5, col = NA)
