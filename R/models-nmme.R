## aperfeicoamentos futuros
#anos <- 1981:2018
#modelos <- c("CanCM4i",
#              "CanSIPSv2",
#              "CMC1-CanCM3",
#              "CMC2-CanCM4",
#              "GEM-NEMO",
#              "NASA-GEOSS2S",
#              "NCAR-CESM1",
#              "NCEP-CFSv2")
#variaveis <- c("prec", "tmax", "tmin", "t2mmax", "t2mmin", "tsmn", "tsmx", "tref")

#tabela_control <- expand.grid(variaveis, modelos, anos) %>%
#  as.data.frame() %>%
#  setNames(c("var", "modelo", "ano")) %>%
#  as_tibble() %>%
#  mutate_all(.funs = as.character) %>%
#  arrange(modelo, var)

# montar tabela de ano inicial e final de cada modelo
library(data.table)
models <- data.table(modelo = c("CanCM4i", "CanSIPSv2", "CMC1-CanCM3",
                                "CMC2-CanCM4", "GEM-NEMO", "NASA-GEOSS2S",
                                "NCAR-CESM1", "NCEP-CFSv2"),
                     # centro = c("Canadian Meteorological Centre (CMC) – Canada",
                     #            "Canadian Meteorological Centre (CMC) – Canada",
                     #            "Canadian Meteorological Centre (CMC) – Canada",
                     #            "Canadian Meteorological Centre (CMC) – Canada",
                     #            "Recherche en Prévision Numérique (RPN)",
                     #            "National Aeronautics and Space Administration (NASA) – United States",
                     #            "National Center for Atmospheric Research (NCAR)",
                     #            "National Centers for Environmental Prediction (NOAA/NCEP) – United States"),
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
                     # fase_i = c(""),
                     # fase_ii = c(""),
                     # variaveis = c("Precipitation (mm/day), Maximum Temperature (K), Minimum Temperature (K)", "", "", "", "","Precipitation (mm/day), Maximum Temperature (K), Minimum Temperature (K)", "Precipitation (mm/day), Daily minimum of average 2-m temperature (K), Daily maximum of average 2-m temperature (K)", "Precipitation (mm/day), Reference Temperature (K)"),
                     # var_abrev = c("prec, tmax, tmin", "", "", "", "", "prec, t2mmax, t2mmin", "prec, tsmx, tsmn", "prec, tref")
)
models

# verificacao
#files_nc <- dir_ls("../output", glob = "*.nc")
#range(rast(files_nc[1])[])
#range(rast(files_nc[2])[])
#tidync::hyper_tibble(files_nc[1])
#tidync::hyper_tibble(files_nc[2])
#summary(tidync::hyper_tibble(files_nc[2]))
