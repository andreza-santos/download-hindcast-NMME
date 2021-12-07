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

## dados ensemble -------------------------------------------------------------
ens_files <- here("output", "rds") %>%
  dir_ls(regexp = "ensemble")
length(ens_files)

#ens_files <- ens_files[c(2, 5:7)]

# devido ao longo tempo de processamento das medias
# escrita de um arquivo rds das medias na area 
# por ano

out_basin_avg_d <- here("output/rds/basin-avgs")
checkmate::check_directory_exists(out_basin_avg_d)

out_basin_avgs <- map(seq_along(ens_files), 
                         #1:2,
                         function(i) {
                           # i = 1
                           #cat(path_file(ens_files[i]), "\n")
                           basin_avg_model(
                             file_model = ens_files[i], 
                             pols_sp = pols_inc_sp, 
                             weighted_mean = TRUE,  # media ponderada?
                             dest_path = out_basin_avg_d
                           )
                         }
                      )

# para diagnostico dos meses de inicialização presentes
#writexl::write_xlsx(out_basin_avgs, path = here("output", "check-forecast-start-time.xlsx"))


# tail(ens_data_nest)
# # datas variam por modelo
# min(ens_data_nest$S)
# max(ens_data_nest$S)
# seq(as.Date(min(ens_data_nest$S)), as.Date(max(ens_data_nest$S)), by = "months") %>%
#    length()
# 456 meses


# vamos gerar um raster para 1 tempo de inic. e 1 membro
# grid <- ens_data_nest[["data"]][[1]] 
# plot(raster_from_points(grid))
# basin_average(grid)
#conferido com 
#http://iridl.ldeo.columbia.edu/SOURCES/.Models/.NMME/.CanCM4i/.HINDCAST/.MONTHLY/.prec/figviewer.html?my.help=&map.L.plotvalue=0.5&map.M.plotvalue=1.0&map.S.plotvalue=0000+1+Jan+1981&map.Y.units=degree_north&map.Y.plotlast=15.5N&map.url=X+Y+fig-+colors+coasts+-fig&map.domain=+%7B+%2Fprec+1.23088903E-05+23.955059+plotrange+%2FL+0.5+plotvalue+%2FM+1.0+plotvalue+%2FS+252.0+plotvalue+X+274.5+389.5+plotrange+Y+-60.5+15.5+plotrange+%7D&map.domainparam=+%2Fplotaxislength+432+psdef+%2Fplotborder+72+psdef+%2FXOVY+null+psdef&map.zoom=Zoom&redraw.x=-1&redraw.y=13&map.Y.plotfirst=60.5S&map.X.plotfirst=85.5W&map.X.units=degree_east&map.X.modulus=360&map.X.plotlast=29.5W&map.prec.plotfirst=1.2308890E-05&map.prec.units=mm%2Fday&map.prec.plotlast=23.95506&map.newurl.grid0=X&map.newurl.grid1=Y&map.newurl.land=draw+coasts&map.newurl.plot=colors&map.plotaxislength=432&map.plotborder=72&map.fnt=NimbusSanLSymbol&map.fntsze=12&map.color_smoothing=1&map.XOVY=auto&map.iftime=25&map.mftime=25&map.fftime=200

# cr <- crop(raster_grid(grid), pols_inc_sp)
# cr_pols <- raster::rasterToPolygons(cr)
# cr_pols <- sf::st_as_sfc(cr_pols)
# cr_pols_inters <- sf::st_intersection(pols_inc_large_ll, cr_pols)
# plot(cr_pols_inters, add = TRUE, border = "blue", lwd = 0.9, col = NA)
# plot(sf::st_geometry(pols_inc_large_ll), border = "black", col = NA, add = TRUE)

# reamostrar cru para grade do modelo
# fazer media na area das bhs


