## aperfeicoamentos futuros
library(data.table)

# anos <- 1980:2018
# variaveis <- c("prec", "tmax", "tmin", "t2mmax", "t2mmin", "tsmx", "tsmn", "tref")

#tabela_control <- expand.grid(variaveis, modelos, anos) %>%
#  as.data.frame() %>%
#  setNames(c("var", "modelo", "ano")) %>%
#  as_tibble() %>%
#  mutate_all(.funs = as.character) %>%
#  arrange(modelo, var)

## montar tabela de ano inicial e final de cada modelo
tabela1 <- data.table(modelo = c("CanCM4i", "CanSIPSv2", "CMC1-CanCM3",
                                "CMC2-CanCM4", "GEM-NEMO", "NASA-GEOSS2S",
                                "NCAR-CESM1", "NCEP-CFSv2"),
                     centro = c("Canadian Meteorological Centre (CMC) – Canada",
                                "Canadian Meteorological Centre (CMC) – Canada",
                                "Canadian Meteorological Centre (CMC) – Canada",
                                "Canadian Meteorological Centre (CMC) – Canada",
                                "Recherche en Prévision Numérique (RPN)",
                                "National Aeronautics and Space Administration (NASA) – United States",
                                "National Center for Atmospheric Research (NCAR)",
                                "National Centers for Environmental Prediction (NOAA/NCEP) – United States"),
                     periodo = c("1981-2018", "1981-2018", "1981-2010",  
                                 "1981-2010", "1981-2018", "1981-2017",   
                                 "1980-2010", "1982-2010"),
                     n_membros = c(10, 20, 10,
                                   10, 10, 4,
                                   10, 24),
                     lead = c("0.5-11.5", "0.5-11.5", "0.5-11.5",
                              "0.5-11.5", "0.5-11.5", "0.5-8.5",
                              "0.5-11.5", "0.5-9.5"),
                     referencia = c("Kirtman et al. (2014)",
                                    "Kirtman et al. (2014)",
                                    "Merryfield et al. (2013)",
                                    "Merryfield et al. (2013)",
                                    "Kirtman et al. (2014)",
                                    "Vernieres et al. (2012)",
                                    "Lawrence et al. (2012)",
                                    "Saha et al. (2014)")
                     # variaveis = c("Precipitation (prec; mm/day), Maximum Temperature (tmax; K), Minimum Temperature (tmin; K)",
                     #               "",
                     #               "",
                     #               "",
                     #               "",
                     #               "Precipitation (prec; mm/day), Maximum Temperature (t2mmax; K), Minimum Temperature (t2mmin; K)",
                     #               "Precipitation (prec; mm/day), Daily minimum of average 2-m temperature (tsmx; K), Daily maximum of average 2-m temperature (tsmn; K)",
                     #               "Precipitation (prec; mm/day), Reference Temperature (tref; K)"
                     # )

)
tabela1

# write.table(tabela1, file = "/home/andreza/Desktop/test-down-NMME/output/tabela1.csv",
#             row.names = FALSE, sep = ";"
#             )

# verificacao
files_nc <- dir_ls(here("output/prec"), glob = "*.nc")

#range(rast(files_nc[1])[])
#range(rast(files_nc[2])[])
nrow((ht_nc <- tidync::hyper_tibble(files_nc[1])))
table((ht_nc$S))
nrow((metr_nc <- metR::ReadNetCDF(files_nc[1])))
table((metr_nc$S))
#summary(tidync::hyper_tibble(files_nc[2]))
