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
#variaveis <- c("prec", "sst")

#tabela_control <- expand.grid(variaveis, modelos, anos) %>%
#  as.data.frame() %>%
#  setNames(c("var", "modelo", "ano")) %>%
#  as_tibble() %>%
#  mutate_all(.funs = as.character) %>%
#  arrange(modelo, var)

# montar tabela de ano inicial e final de cada modelo
models <- data.table(modelos = c("CanCM4i", "CanSIPSv2", "CMC1-CanCM3",
                                 "CMC2-CanCM4", "GEM-NEMO", "NASA-GEOSS2S",
                                 "NCAR-CESM1", "NCEP-CFSv2"),  
                     ano_i = c("1981", "1981", "1981",  
                               "1981", "1981", "1981",   
                               "1980", "1982"),  
                     ano_f = c("2018", "2018", "2010",
                               "2010", "2018", "2017", 
                               "2010", "2010"),
                     n_membros = c(10, 20, 10,
                                  10, 10, 4,
                                  10, 24),
                     lead = c(11.5, 11.5, 11.5,
                              11.5, 11.5, 8.5,
                              11.5, 9.5)
)

# ver nomes das variaveis
# Total Precipitation (mm/day): prec

# CanCM4i, CanSIPSv2, CMC1-CanCM3, CMC2-CanCM4 e GEM-NEMO: "tmax" e "tmin"
# NASA-GEOSS2S: "t2mmax" e "t2mmin"
# NCAR-CESM1: Daily minimum of average 2-m temperature ("tsmn")
#             Daily maximum of average 2-m temperature ("tsmx")
# NCEP-CFSv2: Reference Temperature ("tref")


# verificacao
#files_nc <- dir_ls("../output", glob = "*.nc")
#range(rast(files_nc[1])[])
#range(rast(files_nc[2])[])
#tidync::hyper_tibble(files_nc[1])
#tidync::hyper_tibble(files_nc[2])
#summary(tidync::hyper_tibble(files_nc[2]))
