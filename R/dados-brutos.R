library(terra)
library(tidyverse)

##### BASE DE DADOS - PREVISÃO RESTROSPECTIVA NNME - CanCM4i #####
setwd('~/github/download-hindcast-NMME/output/prec/CanCM4i/')

## listar todos os arquivos das previsões retrospectivas da precipitação CanCM4i
list.files(pattern = "*.nc")
dados_prec <- rast(
  dir(
    "~/github/download-hindcast-NMME/output/prec/CanCM4i/",
    pattern = "*.nc"
  )
)

##### PREVISÃO RESTROSPECTIVA NNME - CanCM4i - LEAD TIME 1 #####
## Filtrando dados para o primeiro lead time == 0.5
prec_CanCM4i_L1 <- as.data.frame(dados_prec) %>%
  select(
    .,
    contains("L.0.5")
  )

##### MÉDIA MENSAL PREVISÃO RESTROSPECTIVA CanCM4i 1982 #####
# Média de todos os membros
# OBS: S264 == Dez/1981
dados_prec_CanCM4i_1982_L1 <- prec_CanCM4i_L1 %>%
  mutate(
    .,
    "jan_1982" = rowMeans(
      select(
        .,
        contains("S.264")
      )
    ),
    "fev_1982" = rowMeans(
      select(
        .,
        contains("S.265")
      )
    ),
    "mar_1982" = rowMeans(
      select(
        .,
        contains("S.266")
      )
    ),
    "abr_1982" = rowMeans(
      select(
        .,
        contains("S.267")
      )
    ),
    "mai_1982" = rowMeans(
      select(
        .,
        contains("S.268")
      )
    ),
    "jun_1982" = rowMeans(
      select(
        .,
        contains("S.269")
      )
    ),
    "jul_1982" = rowMeans(
      select(
        .,
        contains("S.270")
      )
    ),
    "ago_1982" = rowMeans(
      select(
        .,
        contains("S.271")
      )
    ),
    "set_1982" = rowMeans(
      select(
        .,
        contains("S.272")
      )
    ),
    "out_1982" = rowMeans(
      select(
        .,
        contains("S.273")
      )
    ),
    "nov_1982" = rowMeans(
      select(
        .,
        contains("S.274")
      )
    ),
    "dez_1982" = rowMeans(
      select(
        .,
        contains("S.275")
      )
    )
  )

med_prec_CanCM4i_1982_L1 <- dados_prec_CanCM4i_1982_L1 %>%
  select(
    .,
    jan_1982:dez_1982
  )

##### MÉDIA MENSAL PREVISÃO RESTROSPECTIVA CanCM4i 1983 #####
# Média de todos os membros
# OBS: S276 == Dez/1982
dados_prec_CanCM4i_1983_L1 <- prec_CanCM4i_L1 %>%
  mutate(
    .,
    "jan_1983" = rowMeans(
      select(
        .,
        contains("S.276")
      )
    ),
    "fev_1983" = rowMeans(
      select(
        .,
        contains("S.277")
      )
    ),
    "mar_1983" = rowMeans(
      select(
        .,
        contains("S.278")
      )
    ),
    "abr_1983" = rowMeans(
      select(
        .,
        contains("S.279")
      )
    ),
    "mai_1983" = rowMeans(
      select(
        .,
        contains("S.280")
      )
    ),
    "jun_1983" = rowMeans(
      select(
        .,
        contains("S.281")
      )
    ),
    "jul_1983" = rowMeans(
      select(
        .,
        contains("S.282")
      )
    ),
    "ago_1983" = rowMeans(
      select(
        .,
        contains("S.283")
      )
    ),
    "set_1983" = rowMeans(
      select(
        .,
        contains("S.284")
      )
    ),
    "out_1983" = rowMeans(
      select(
        .,
        contains("S.285")
      )
    ),
    "nov_1983" = rowMeans(
      select(
        .,
        contains("S.286")
      )
    ),
    "dez_1983" = rowMeans(
      select(
        .,
        contains("S.287")
      )
    )
  )

med_prec_CanCM4i_1983_L1 <- dados_prec_CanCM4i_1983_L1 %>%
  select(
    .,
    jan_1983:dez_1983
  )

##### MÉDIA MENSAL PREVISÃO RESTROSPECTIVA CanCM4i 1984 #####
# Média de todos os membros
# OBS: S288 == Dez/1983
dados_prec_CanCM4i_1984_L1 <- prec_CanCM4i_L1 %>%
  mutate(
    .,
    "jan_1984" = rowMeans(
      select(
        .,
        contains("S.288")
      )
    ),
    "fev_1984" = rowMeans(
      select(
        .,
        contains("S.289")
      )
    ),
    "mar_1984" = rowMeans(
      select(
        .,
        contains("S.290")
      )
    ),
    "abr_1984" = rowMeans(
      select(
        .,
        contains("S.291")
      )
    ),
    "mai_1984" = rowMeans(
      select(
        .,
        contains("S.292")
      )
    ),
    "jun_1984" = rowMeans(
      select(
        .,
        contains("S.293")
      )
    ),
    "jul_1984" = rowMeans(
      select(
        .,
        contains("S.294")
      )
    ),
    "ago_1984" = rowMeans(
      select(
        .,
        contains("S.295")
      )
    ),
    "set_1984" = rowMeans(
      select(
        .,
        contains("S.296")
      )
    ),
    "out_1984" = rowMeans(
      select(
        .,
        contains("S.297")
      )
    ),
    "nov_1984" = rowMeans(
      select(
        .,
        contains("S.298")
      )
    ),
    "dez_1984" = rowMeans(
      select(
        .,
        contains("S.299")
      )
    )
  )

med_prec_CanCM4i_1984_L1 <- dados_prec_CanCM4i_1984_L1 %>%
  select(
    .,
    jan_1984:dez_1984
  )

##### MÉDIA MENSAL PREVISÃO RESTROSPECTIVA CanCM4i 1985 #####
# Média de todos os membros
# OBS: S300 == Dez/1984
dados_prec_CanCM4i_1985_L1 <- prec_CanCM4i_L1 %>%
  mutate(
    .,
    "jan_1985" = rowMeans(
      select(
        .,
        contains("S.300")
      )
    ),
    "fev_1985" = rowMeans(
      select(
        .,
        contains("S.301")
      )
    ),
    "mar_1985" = rowMeans(
      select(
        .,
        contains("S.302")
      )
    ),
    "abr_1985" = rowMeans(
      select(
        .,
        contains("S.303")
      )
    ),
    "mai_1985" = rowMeans(
      select(
        .,
        contains("S.304")
      )
    ),
    "jun_1985" = rowMeans(
      select(
        .,
        contains("S.305")
      )
    ),
    "jul_1985" = rowMeans(
      select(
        .,
        contains("S.306")
      )
    ),
    "ago_1985" = rowMeans(
      select(
        .,
        contains("S.307")
      )
    ),
    "set_1985" = rowMeans(
      select(
        .,
        contains("S.308")
      )
    ),
    "out_1985" = rowMeans(
      select(
        .,
        contains("S.309")
      )
    ),
    "nov_1985" = rowMeans(
      select(
        .,
        contains("S.310")
      )
    ),
    "dez_1985" = rowMeans(
      select(
        .,
        contains("S.311")
      )
    )
  )

med_prec_CanCM4i_1985_L1 <- dados_prec_CanCM4i_1985_L1 %>%
  select(
    .,
    jan_1985:dez_1985
  )

##### MÉDIA MENSAL PREVISÃO RESTROSPECTIVA CanCM4i 1986 #####
# Média de todos os membros
# OBS: S312 == Dez/1985
dados_prec_CanCM4i_1986_L1 <- prec_CanCM4i_L1 %>%
  mutate(
    .,
    "jan_1986" = rowMeans(
      select(
        .,
        contains("S.312")
      )
    ),
    "fev_1986" = rowMeans(
      select(
        .,
        contains("S.313")
      )
    ),
    "mar_1986" = rowMeans(
      select(
        .,
        contains("S.314")
      )
    ),
    "abr_1986" = rowMeans(
      select(
        .,
        contains("S.315")
      )
    ),
    "mai_1986" = rowMeans(
      select(
        .,
        contains("S.316")
      )
    ),
    "jun_1986" = rowMeans(
      select(
        .,
        contains("S.317")
      )
    ),
    "jul_1986" = rowMeans(
      select(
        .,
        contains("S.318")
      )
    ),
    "ago_1986" = rowMeans(
      select(
        .,
        contains("S.319")
      )
    ),
    "set_1986" = rowMeans(
      select(
        .,
        contains("S.320")
      )
    ),
    "out_1986" = rowMeans(
      select(
        .,
        contains("S.321")
      )
    ),
    "nov_1986" = rowMeans(
      select(
        .,
        contains("S.322")
      )
    ),
    "dez_1986" = rowMeans(
      select(
        .,
        contains("S.323")
      )
    )
  )

med_prec_CanCM4i_1986_L1 <- dados_prec_CanCM4i_1986_L1 %>%
  select(
    .,
    jan_1986:dez_1986
  )

##### MÉDIA MENSAL PREVISÃO RESTROSPECTIVA CanCM4i 1987 #####
# Média de todos os membros
# OBS: S324 == Dez/1986
dados_prec_CanCM4i_1987_L1 <- prec_CanCM4i_L1 %>%
  mutate(
    .,
    "jan_1987" = rowMeans(
      select(
        .,
        contains("S.324")
      )
    ),
    "fev_1987" = rowMeans(
      select(
        .,
        contains("S.325")
      )
    ),
    "mar_1987" = rowMeans(
      select(
        .,
        contains("S.326")
      )
    ),
    "abr_1987" = rowMeans(
      select(
        .,
        contains("S.327")
      )
    ),
    "mai_1987" = rowMeans(
      select(
        .,
        contains("S.328")
      )
    ),
    "jun_1987" = rowMeans(
      select(
        .,
        contains("S.329")
      )
    ),
    "jul_1987" = rowMeans(
      select(
        .,
        contains("S.330")
      )
    ),
    "ago_1987" = rowMeans(
      select(
        .,
        contains("S.331")
      )
    ),
    "set_1987" = rowMeans(
      select(
        .,
        contains("S.332")
      )
    ),
    "out_1987" = rowMeans(
      select(
        .,
        contains("S.333")
      )
    ),
    "nov_1987" = rowMeans(
      select(
        .,
        contains("S.334")
      )
    ),
    "dez_1987" = rowMeans(
      select(
        .,
        contains("S.335")
      )
    )
  )

med_prec_CanCM4i_1987_L1 <- dados_prec_CanCM4i_1987_L1 %>%
  select(
    .,
    jan_1987:dez_1987
  )

##### MÉDIA MENSAL PREVISÃO RESTROSPECTIVA CanCM4i 1988 #####
# Média de todos os membros
# OBS: S336 == Dez/1987
dados_prec_CanCM4i_1988_L1 <- prec_CanCM4i_L1 %>%
  mutate(
    .,
    "jan_1988" = rowMeans(
      select(
        .,
        contains("S.336")
      )
    ),
    "fev_1988" = rowMeans(
      select(
        .,
        contains("S.337")
      )
    ),
    "mar_1988" = rowMeans(
      select(
        .,
        contains("S.338")
      )
    ),
    "abr_1988" = rowMeans(
      select(
        .,
        contains("S.339")
      )
    ),
    "mai_1988" = rowMeans(
      select(
        .,
        contains("S.340")
      )
    ),
    "jun_1988" = rowMeans(
      select(
        .,
        contains("S.341")
      )
    ),
    "jul_1988" = rowMeans(
      select(
        .,
        contains("S.342")
      )
    ),
    "ago_1988" = rowMeans(
      select(
        .,
        contains("S.343")
      )
    ),
    "set_1988" = rowMeans(
      select(
        .,
        contains("S.344")
      )
    ),
    "out_1988" = rowMeans(
      select(
        .,
        contains("S.345")
      )
    ),
    "nov_1988" = rowMeans(
      select(
        .,
        contains("S.346")
      )
    ),
    "dez_1988" = rowMeans(
      select(
        .,
        contains("S.347")
      )
    )
  )

med_prec_CanCM4i_1988_L1 <- dados_prec_CanCM4i_1988_L1 %>%
  select(
    .,
    jan_1988:dez_1988
  )

##### MÉDIA MENSAL PREVISÃO RESTROSPECTIVA CanCM4i 1989 #####
# Média de todos os membros
# OBS: S348 == Dez/1988
dados_prec_CanCM4i_1989_L1 <- prec_CanCM4i_L1 %>%
  mutate(
    .,
    "jan_1989" = rowMeans(
      select(
        .,
        contains("S.348")
      )
    ),
    "fev_1989" = rowMeans(
      select(
        .,
        contains("S.349")
      )
    ),
    "mar_1989" = rowMeans(
      select(
        .,
        contains("S.350")
      )
    ),
    "abr_1989" = rowMeans(
      select(
        .,
        contains("S.351")
      )
    ),
    "mai_1989" = rowMeans(
      select(
        .,
        contains("S.352")
      )
    ),
    "jun_1989" = rowMeans(
      select(
        .,
        contains("S.353")
      )
    ),
    "jul_1989" = rowMeans(
      select(
        .,
        contains("S.354")
      )
    ),
    "ago_1989" = rowMeans(
      select(
        .,
        contains("S.355")
      )
    ),
    "set_1989" = rowMeans(
      select(
        .,
        contains("S.356")
      )
    ),
    "out_1989" = rowMeans(
      select(
        .,
        contains("S.357")
      )
    ),
    "nov_1989" = rowMeans(
      select(
        .,
        contains("S.358")
      )
    ),
    "dez_1989" = rowMeans(
      select(
        .,
        contains("S.359")
      )
    )
  )

med_prec_CanCM4i_1989_L1 <- dados_prec_CanCM4i_1989_L1 %>%
  select(
    .,
    jan_1989:dez_1989
  )

##### MÉDIA MENSAL PREVISÃO RESTROSPECTIVA CanCM4i 1990 #####
# Média de todos os membros
# OBS: S360 == Dez/1989
dados_prec_CanCM4i_1990_L1 <- prec_CanCM4i_L1 %>%
  mutate(
    .,
    "jan_1990" = rowMeans(
      select(
        .,
        contains("S.360")
      )
    ),
    "fev_1990" = rowMeans(
      select(
        .,
        contains("S.361")
      )
    ),
    "mar_1990" = rowMeans(
      select(
        .,
        contains("S.362")
      )
    ),
    "abr_1990" = rowMeans(
      select(
        .,
        contains("S.363")
      )
    ),
    "mai_1990" = rowMeans(
      select(
        .,
        contains("S.364")
      )
    ),
    "jun_1990" = rowMeans(
      select(
        .,
        contains("S.365")
      )
    ),
    "jul_1990" = rowMeans(
      select(
        .,
        contains("S.366")
      )
    ),
    "ago_1990" = rowMeans(
      select(
        .,
        contains("S.367")
      )
    ),
    "set_1990" = rowMeans(
      select(
        .,
        contains("S.368")
      )
    ),
    "out_1990" = rowMeans(
      select(
        .,
        contains("S.369")
      )
    ),
    "nov_1990" = rowMeans(
      select(
        .,
        contains("S.370")
      )
    ),
    "dez_1990" = rowMeans(
      select(
        .,
        contains("S.371")
      )
    )
  )

med_prec_CanCM4i_1990_L1 <- dados_prec_CanCM4i_1990_L1 %>%
  select(
    .,
    jan_1990:dez_1990
  )

##### MÉDIA MENSAL PREVISÃO RESTROSPECTIVA CanCM4i 1991 #####
# Média de todos os membros
# OBS: S372 == Dez/1990
dados_prec_CanCM4i_1991_L1 <- prec_CanCM4i_L1 %>%
  mutate(
    .,
    "jan_1991" = rowMeans(
      select(
        .,
        contains("S.372")
      )
    ),
    "fev_1991" = rowMeans(
      select(
        .,
        contains("S.373")
      )
    ),
    "mar_1991" = rowMeans(
      select(
        .,
        contains("S.374")
      )
    ),
    "abr_1991" = rowMeans(
      select(
        .,
        contains("S.375")
      )
    ),
    "mai_1991" = rowMeans(
      select(
        .,
        contains("S.376")
      )
    ),
    "jun_1991" = rowMeans(
      select(
        .,
        contains("S.377")
      )
    ),
    "jul_1991" = rowMeans(
      select(
        .,
        contains("S.378")
      )
    ),
    "ago_1991" = rowMeans(
      select(
        .,
        contains("S.379")
      )
    ),
    "set_1991" = rowMeans(
      select(
        .,
        contains("S.380")
      )
    ),
    "out_1991" = rowMeans(
      select(
        .,
        contains("S.381")
      )
    ),
    "nov_1991" = rowMeans(
      select(
        .,
        contains("S.382")
      )
    ),
    "dez_1991" = rowMeans(
      select(
        .,
        contains("S.383")
      )
    )
  )

med_prec_CanCM4i_1991_L1 <- dados_prec_CanCM4i_1991_L1 %>%
  select(
    .,
    jan_1991:dez_1991
  )

##### MÉDIA MENSAL PREVISÃO RESTROSPECTIVA CanCM4i 1992 #####
# Média de todos os membros
# OBS: S384 == Dez/1991
dados_prec_CanCM4i_1992_L1 <- prec_CanCM4i_L1 %>%
  mutate(
    .,
    "jan_1992" = rowMeans(
      select(
        .,
        contains("S.384")
      )
    ),
    "fev_1992" = rowMeans(
      select(
        .,
        contains("S.385")
      )
    ),
    "mar_1992" = rowMeans(
      select(
        .,
        contains("S.386")
      )
    ),
    "abr_1992" = rowMeans(
      select(
        .,
        contains("S.387")
      )
    ),
    "mai_1992" = rowMeans(
      select(
        .,
        contains("S.388")
      )
    ),
    "jun_1992" = rowMeans(
      select(
        .,
        contains("S.389")
      )
    ),
    "jul_1992" = rowMeans(
      select(
        .,
        contains("S.390")
      )
    ),
    "ago_1992" = rowMeans(
      select(
        .,
        contains("S.391")
      )
    ),
    "set_1992" = rowMeans(
      select(
        .,
        contains("S.392")
      )
    ),
    "out_1992" = rowMeans(
      select(
        .,
        contains("S.393")
      )
    ),
    "nov_1992" = rowMeans(
      select(
        .,
        contains("S.394")
      )
    ),
    "dez_1992" = rowMeans(
      select(
        .,
        contains("S.395")
      )
    )
  )

med_prec_CanCM4i_1992_L1 <- dados_prec_CanCM4i_1992_L1 %>%
  select(
    .,
    jan_1992:dez_1992
  )

##### MÉDIA MENSAL PREVISÃO RESTROSPECTIVA CanCM4i 1993 #####
# Média de todos os membros
# OBS: S396 == Dez/1992
dados_prec_CanCM4i_1993_L1 <- prec_CanCM4i_L1 %>%
  mutate(
    .,
    "jan_1993" = rowMeans(
      select(
        .,
        contains("S.396")
      )
    ),
    "fev_1993" = rowMeans(
      select(
        .,
        contains("S.397")
      )
    ),
    "mar_1993" = rowMeans(
      select(
        .,
        contains("S.398")
      )
    ),
    "abr_1993" = rowMeans(
      select(
        .,
        contains("S.399")
      )
    ),
    "mai_1993" = rowMeans(
      select(
        .,
        contains("S.400")
      )
    ),
    "jun_1993" = rowMeans(
      select(
        .,
        contains("S.401")
      )
    ),
    "jul_1993" = rowMeans(
      select(
        .,
        contains("S.402")
      )
    ),
    "ago_1993" = rowMeans(
      select(
        .,
        contains("S.403")
      )
    ),
    "set_1993" = rowMeans(
      select(
        .,
        contains("S.404")
      )
    ),
    "out_1993" = rowMeans(
      select(
        .,
        contains("S.405")
      )
    ),
    "nov_1993" = rowMeans(
      select(
        .,
        contains("S.406")
      )
    ),
    "dez_1993" = rowMeans(
      select(
        .,
        contains("S.407")
      )
    )
  )

med_prec_CanCM4i_1993_L1 <- dados_prec_CanCM4i_1993_L1 %>%
  select(
    .,
    jan_1993:dez_1993
  )

##### MÉDIA MENSAL PREVISÃO RESTROSPECTIVA CanCM4i 1994 #####
# Média de todos os membros
# OBS: S408 == Dez/1993
dados_prec_CanCM4i_1994_L1 <- prec_CanCM4i_L1 %>%
  mutate(
    .,
    "jan_1994" = rowMeans(
      select(
        .,
        contains("S.408")
      )
    ),
    "fev_1994" = rowMeans(
      select(
        .,
        contains("S.409")
      )
    ),
    "mar_1994" = rowMeans(
      select(
        .,
        contains("S.410")
      )
    ),
    "abr_1994" = rowMeans(
      select(
        .,
        contains("S.411")
      )
    ),
    "mai_1994" = rowMeans(
      select(
        .,
        contains("S.412")
      )
    ),
    "jun_1994" = rowMeans(
      select(
        .,
        contains("S.413")
      )
    ),
    "jul_1994" = rowMeans(
      select(
        .,
        contains("S.414")
      )
    ),
    "ago_1994" = rowMeans(
      select(
        .,
        contains("S.415")
      )
    ),
    "set_1994" = rowMeans(
      select(
        .,
        contains("S.416")
      )
    ),
    "out_1994" = rowMeans(
      select(
        .,
        contains("S.417")
      )
    ),
    "nov_1994" = rowMeans(
      select(
        .,
        contains("S.418")
      )
    ),
    "dez_1994" = rowMeans(
      select(
        .,
        contains("S.419")
      )
    )
  )

med_prec_CanCM4i_1994_L1 <- dados_prec_CanCM4i_1994_L1 %>%
  select(
    .,
    jan_1994:dez_1994
  )

##### MÉDIA MENSAL PREVISÃO RESTROSPECTIVA CanCM4i 1995 #####
# Média de todos os membros
# OBS: S420 == Dez/1994
dados_prec_CanCM4i_1995_L1 <- prec_CanCM4i_L1 %>%
  mutate(
    .,
    "jan_1995" = rowMeans(
      select(
        .,
        contains("S.420")
      )
    ),
    "fev_1995" = rowMeans(
      select(
        .,
        contains("S.421")
      )
    ),
    "mar_1995" = rowMeans(
      select(
        .,
        contains("S.422")
      )
    ),
    "abr_1995" = rowMeans(
      select(
        .,
        contains("S.423")
      )
    ),
    "mai_1995" = rowMeans(
      select(
        .,
        contains("S.424")
      )
    ),
    "jun_1995" = rowMeans(
      select(
        .,
        contains("S.425")
      )
    ),
    "jul_1995" = rowMeans(
      select(
        .,
        contains("S.426")
      )
    ),
    "ago_1995" = rowMeans(
      select(
        .,
        contains("S.427")
      )
    ),
    "set_1995" = rowMeans(
      select(
        .,
        contains("S.428")
      )
    ),
    "out_1995" = rowMeans(
      select(
        .,
        contains("S.429")
      )
    ),
    "nov_1995" = rowMeans(
      select(
        .,
        contains("S.430")
      )
    ),
    "dez_1995" = rowMeans(
      select(
        .,
        contains("S.431")
      )
    )
  )

med_prec_CanCM4i_1995_L1 <- dados_prec_CanCM4i_1995_L1 %>%
  select(
    .,
    jan_1995:dez_1995
  )

##### MÉDIA MENSAL PREVISÃO RESTROSPECTIVA CanCM4i 1996 #####
# Média de todos os membros
# OBS: S432 == Dez/1995
dados_prec_CanCM4i_1996_L1 <- prec_CanCM4i_L1 %>%
  mutate(
    .,
    "jan_1996" = rowMeans(
      select(
        .,
        contains("S.432")
      )
    ),
    "fev_1996" = rowMeans(
      select(
        .,
        contains("S.433")
      )
    ),
    "mar_1996" = rowMeans(
      select(
        .,
        contains("S.434")
      )
    ),
    "abr_1996" = rowMeans(
      select(
        .,
        contains("S.435")
      )
    ),
    "mai_1996" = rowMeans(
      select(
        .,
        contains("S.436")
      )
    ),
    "jun_1996" = rowMeans(
      select(
        .,
        contains("S.437")
      )
    ),
    "jul_1996" = rowMeans(
      select(
        .,
        contains("S.438")
      )
    ),
    "ago_1996" = rowMeans(
      select(
        .,
        contains("S.439")
      )
    ),
    "set_1996" = rowMeans(
      select(
        .,
        contains("S.440")
      )
    ),
    "out_1996" = rowMeans(
      select(
        .,
        contains("S.441")
      )
    ),
    "nov_1996" = rowMeans(
      select(
        .,
        contains("S.442")
      )
    ),
    "dez_1996" = rowMeans(
      select(
        .,
        contains("S.443")
      )
    )
  )

med_prec_CanCM4i_1996_L1 <- dados_prec_CanCM4i_1996_L1 %>%
  select(
    .,
    jan_1996:dez_1996
  )

##### MÉDIA MENSAL PREVISÃO RESTROSPECTIVA CanCM4i 1997 #####
# Média de todos os membros
# OBS: S444 == Dez/1996
dados_prec_CanCM4i_1997_L1 <- prec_CanCM4i_L1 %>%
  mutate(
    .,
    "jan_1997" = rowMeans(
      select(
        .,
        contains("S.444")
      )
    ),
    "fev_1997" = rowMeans(
      select(
        .,
        contains("S.445")
      )
    ),
    "mar_1997" = rowMeans(
      select(
        .,
        contains("S.446")
      )
    ),
    "abr_1997" = rowMeans(
      select(
        .,
        contains("S.447")
      )
    ),
    "mai_1997" = rowMeans(
      select(
        .,
        contains("S.448")
      )
    ),
    "jun_1997" = rowMeans(
      select(
        .,
        contains("S.449")
      )
    ),
    "jul_1997" = rowMeans(
      select(
        .,
        contains("S.450")
      )
    ),
    "ago_1997" = rowMeans(
      select(
        .,
        contains("S.451")
      )
    ),
    "set_1997" = rowMeans(
      select(
        .,
        contains("S.452")
      )
    ),
    "out_1997" = rowMeans(
      select(
        .,
        contains("S.453")
      )
    ),
    "nov_1997" = rowMeans(
      select(
        .,
        contains("S.454")
      )
    ),
    "dez_1997" = rowMeans(
      select(
        .,
        contains("S.455")
      )
    )
  )

med_prec_CanCM4i_1997_L1 <- dados_prec_CanCM4i_1997_L1 %>%
  select(
    .,
    jan_1997:dez_1997
  )

##### MÉDIA MENSAL PREVISÃO RESTROSPECTIVA CanCM4i 1998 #####
# Média de todos os membros
# OBS: S456 == Dez/1997
dados_prec_CanCM4i_1998_L1 <- prec_CanCM4i_L1 %>%
  mutate(
    .,
    "jan_1998" = rowMeans(
      select(
        .,
        contains("S.456")
      )
    ),
    "fev_1998" = rowMeans(
      select(
        .,
        contains("S.457")
      )
    ),
    "mar_1998" = rowMeans(
      select(
        .,
        contains("S.458")
      )
    ),
    "abr_1998" = rowMeans(
      select(
        .,
        contains("S.459")
      )
    ),
    "mai_1998" = rowMeans(
      select(
        .,
        contains("S.460")
      )
    ),
    "jun_1998" = rowMeans(
      select(
        .,
        contains("S.461")
      )
    ),
    "jul_1998" = rowMeans(
      select(
        .,
        contains("S.462")
      )
    ),
    "ago_1998" = rowMeans(
      select(
        .,
        contains("S.463")
      )
    ),
    "set_1998" = rowMeans(
      select(
        .,
        contains("S.464")
      )
    ),
    "out_1998" = rowMeans(
      select(
        .,
        contains("S.465")
      )
    ),
    "nov_1998" = rowMeans(
      select(
        .,
        contains("S.466")
      )
    ),
    "dez_1998" = rowMeans(
      select(
        .,
        contains("S.467")
      )
    )
  )

med_prec_CanCM4i_1998_L1 <- dados_prec_CanCM4i_1998_L1 %>%
  select(
    .,
    jan_1998:dez_1998
  )

##### MÉDIA MENSAL PREVISÃO RESTROSPECTIVA CanCM4i 1999 #####
# Média de todos os membros
# OBS: S468 == Dez/1998
dados_prec_CanCM4i_1999_L1 <- prec_CanCM4i_L1 %>%
  mutate(
    .,
    "jan_1999" = rowMeans(
      select(
        .,
        contains("S.468")
      )
    ),
    "fev_1999" = rowMeans(
      select(
        .,
        contains("S.469")
      )
    ),
    "mar_1999" = rowMeans(
      select(
        .,
        contains("S.470")
      )
    ),
    "abr_1999" = rowMeans(
      select(
        .,
        contains("S.471")
      )
    ),
    "mai_1999" = rowMeans(
      select(
        .,
        contains("S.472")
      )
    ),
    "jun_1999" = rowMeans(
      select(
        .,
        contains("S.473")
      )
    ),
    "jul_1999" = rowMeans(
      select(
        .,
        contains("S.474")
      )
    ),
    "ago_1999" = rowMeans(
      select(
        .,
        contains("S.475")
      )
    ),
    "set_1999" = rowMeans(
      select(
        .,
        contains("S.476")
      )
    ),
    "out_1999" = rowMeans(
      select(
        .,
        contains("S.477")
      )
    ),
    "nov_1999" = rowMeans(
      select(
        .,
        contains("S.478")
      )
    ),
    "dez_1999" = rowMeans(
      select(
        .,
        contains("S.479")
      )
    )
  )

med_prec_CanCM4i_1999_L1 <- dados_prec_CanCM4i_1999_L1 %>%
  select(
    .,
    jan_1999:dez_1999
  )

##### MÉDIA MENSAL PREVISÃO RESTROSPECTIVA CanCM4i 2000 #####
# Média de todos os membros
# OBS: S480 == Dez/1999
dados_prec_CanCM4i_2000_L1 <- prec_CanCM4i_L1 %>%
  mutate(
    .,
    "jan_2000" = rowMeans(
      select(
        .,
        contains("S.480")
      )
    ),
    "fev_2000" = rowMeans(
      select(
        .,
        contains("S.481")
      )
    ),
    "mar_2000" = rowMeans(
      select(
        .,
        contains("S.482")
      )
    ),
    "abr_2000" = rowMeans(
      select(
        .,
        contains("S.483")
      )
    ),
    "mai_2000" = rowMeans(
      select(
        .,
        contains("S.484")
      )
    ),
    "jun_2000" = rowMeans(
      select(
        .,
        contains("S.485")
      )
    ),
    "jul_2000" = rowMeans(
      select(
        .,
        contains("S.486")
      )
    ),
    "ago_2000" = rowMeans(
      select(
        .,
        contains("S.487")
      )
    ),
    "set_2000" = rowMeans(
      select(
        .,
        contains("S.488")
      )
    ),
    "out_2000" = rowMeans(
      select(
        .,
        contains("S.489")
      )
    ),
    "nov_2000" = rowMeans(
      select(
        .,
        contains("S.490")
      )
    ),
    "dez_2000" = rowMeans(
      select(
        .,
        contains("S.491")
      )
    )
  )

med_prec_CanCM4i_2000_L1 <- dados_prec_CanCM4i_2000_L1 %>%
  select(
    .,
    jan_2000:dez_2000
  )

##### MÉDIA MENSAL PREVISÃO RESTROSPECTIVA CanCM4i 2001 #####
# Média de todos os membros
# OBS: S492 == Dez/2000
dados_prec_CanCM4i_2001_L1 <- prec_CanCM4i_L1 %>%
  mutate(
    .,
    "jan_2001" = rowMeans(
      select(
        .,
        contains("S.492")
      )
    ),
    "fev_2001" = rowMeans(
      select(
        .,
        contains("S.493")
      )
    ),
    "mar_2001" = rowMeans(
      select(
        .,
        contains("S.494")
      )
    ),
    "abr_2001" = rowMeans(
      select(
        .,
        contains("S.495")
      )
    ),
    "mai_2001" = rowMeans(
      select(
        .,
        contains("S.496")
      )
    ),
    "jun_2001" = rowMeans(
      select(
        .,
        contains("S.497")
      )
    ),
    "jul_2001" = rowMeans(
      select(
        .,
        contains("S.498")
      )
    ),
    "ago_2001" = rowMeans(
      select(
        .,
        contains("S.499")
      )
    ),
    "set_2001" = rowMeans(
      select(
        .,
        contains("S.500")
      )
    ),
    "out_2001" = rowMeans(
      select(
        .,
        contains("S.501")
      )
    ),
    "nov_2001" = rowMeans(
      select(
        .,
        contains("S.502")
      )
    ),
    "dez_2001" = rowMeans(
      select(
        .,
        contains("S.503")
      )
    )
  )

med_prec_CanCM4i_2001_L1 <- dados_prec_CanCM4i_2001_L1 %>%
  select(
    .,
    jan_2001:dez_2001
  )

##### MÉDIA MENSAL PREVISÃO RESTROSPECTIVA CanCM4i 2002 #####
# Média de todos os membros
# OBS: S504 == Dez/2001
dados_prec_CanCM4i_2002_L1 <- prec_CanCM4i_L1 %>%
  mutate(
    .,
    "jan_2002" = rowMeans(
      select(
        .,
        contains("S.504")
      )
    ),
    "fev_2002" = rowMeans(
      select(
        .,
        contains("S.505")
      )
    ),
    "mar_2002" = rowMeans(
      select(
        .,
        contains("S.506")
      )
    ),
    "abr_2002" = rowMeans(
      select(
        .,
        contains("S.507")
      )
    ),
    "mai_2002" = rowMeans(
      select(
        .,
        contains("S.508")
      )
    ),
    "jun_2002" = rowMeans(
      select(
        .,
        contains("S.509")
      )
    ),
    "jul_2002" = rowMeans(
      select(
        .,
        contains("S.510")
      )
    ),
    "ago_2002" = rowMeans(
      select(
        .,
        contains("S.511")
      )
    ),
    "set_2002" = rowMeans(
      select(
        .,
        contains("S.512")
      )
    ),
    "out_2002" = rowMeans(
      select(
        .,
        contains("S.513")
      )
    ),
    "nov_2002" = rowMeans(
      select(
        .,
        contains("S.514")
      )
    ),
    "dez_2002" = rowMeans(
      select(
        .,
        contains("S.515")
      )
    )
  )

med_prec_CanCM4i_2002_L1 <- dados_prec_CanCM4i_2002_L1 %>%
  select(
    .,
    jan_2002:dez_2002
  )

##### MÉDIA MENSAL PREVISÃO RESTROSPECTIVA CanCM4i 2003 #####
# Média de todos os membros
# OBS: S516 == Dez/2002
dados_prec_CanCM4i_2003_L1 <- prec_CanCM4i_L1 %>%
  mutate(
    .,
    "jan_2003" = rowMeans(
      select(
        .,
        contains("S.516")
      )
    ),
    "fev_2003" = rowMeans(
      select(
        .,
        contains("S.517")
      )
    ),
    "mar_2003" = rowMeans(
      select(
        .,
        contains("S.518")
      )
    ),
    "abr_2003" = rowMeans(
      select(
        .,
        contains("S.519")
      )
    ),
    "mai_2003" = rowMeans(
      select(
        .,
        contains("S.520")
      )
    ),
    "jun_2003" = rowMeans(
      select(
        .,
        contains("S.521")
      )
    ),
    "jul_2003" = rowMeans(
      select(
        .,
        contains("S.522")
      )
    ),
    "ago_2003" = rowMeans(
      select(
        .,
        contains("S.523")
      )
    ),
    "set_2003" = rowMeans(
      select(
        .,
        contains("S.524")
      )
    ),
    "out_2003" = rowMeans(
      select(
        .,
        contains("S.525")
      )
    ),
    "nov_2003" = rowMeans(
      select(
        .,
        contains("S.526")
      )
    ),
    "dez_2003" = rowMeans(
      select(
        .,
        contains("S.527")
      )
    )
  )

med_prec_CanCM4i_2003_L1 <- dados_prec_CanCM4i_2003_L1 %>%
  select(
    .,
    jan_2003:dez_2003
  )

##### MÉDIA MENSAL PREVISÃO RESTROSPECTIVA CanCM4i 2004 #####
# Média de todos os membros
# OBS: S528 == Dez/2003
dados_prec_CanCM4i_2004_L1 <- prec_CanCM4i_L1 %>%
  mutate(
    .,
    "jan_2004" = rowMeans(
      select(
        .,
        contains("S.528")
      )
    ),
    "fev_2004" = rowMeans(
      select(
        .,
        contains("S.529")
      )
    ),
    "mar_2004" = rowMeans(
      select(
        .,
        contains("S.530")
      )
    ),
    "abr_2004" = rowMeans(
      select(
        .,
        contains("S.531")
      )
    ),
    "mai_2004" = rowMeans(
      select(
        .,
        contains("S.532")
      )
    ),
    "jun_2004" = rowMeans(
      select(
        .,
        contains("S.533")
      )
    ),
    "jul_2004" = rowMeans(
      select(
        .,
        contains("S.534")
      )
    ),
    "ago_2004" = rowMeans(
      select(
        .,
        contains("S.535")
      )
    ),
    "set_2004" = rowMeans(
      select(
        .,
        contains("S.536")
      )
    ),
    "out_2004" = rowMeans(
      select(
        .,
        contains("S.537")
      )
    ),
    "nov_2004" = rowMeans(
      select(
        .,
        contains("S.538")
      )
    ),
    "dez_2004" = rowMeans(
      select(
        .,
        contains("S.539")
      )
    )
  )

med_prec_CanCM4i_2004_L1 <- dados_prec_CanCM4i_2004_L1 %>%
  select(
    .,
    jan_2004:dez_2004
  )

##### MÉDIA MENSAL PREVISÃO RESTROSPECTIVA CanCM4i 2005 #####
# Média de todos os membros
# OBS: S540 == Dez/2004
dados_prec_CanCM4i_2005_L1 <- prec_CanCM4i_L1 %>%
  mutate(
    .,
    "jan_2005" = rowMeans(
      select(
        .,
        contains("S.540")
      )
    ),
    "fev_2005" = rowMeans(
      select(
        .,
        contains("S.541")
      )
    ),
    "mar_2005" = rowMeans(
      select(
        .,
        contains("S.542")
      )
    ),
    "abr_2005" = rowMeans(
      select(
        .,
        contains("S.543")
      )
    ),
    "mai_2005" = rowMeans(
      select(
        .,
        contains("S.544")
      )
    ),
    "jun_2005" = rowMeans(
      select(
        .,
        contains("S.545")
      )
    ),
    "jul_2005" = rowMeans(
      select(
        .,
        contains("S.546")
      )
    ),
    "ago_2005" = rowMeans(
      select(
        .,
        contains("S.547")
      )
    ),
    "set_2005" = rowMeans(
      select(
        .,
        contains("S.548")
      )
    ),
    "out_2005" = rowMeans(
      select(
        .,
        contains("S.549")
      )
    ),
    "nov_2005" = rowMeans(
      select(
        .,
        contains("S.550")
      )
    ),
    "dez_2005" = rowMeans(
      select(
        .,
        contains("S.551")
      )
    )
  )

med_prec_CanCM4i_2005_L1 <- dados_prec_CanCM4i_2005_L1 %>%
  select(
    .,
    jan_2005:dez_2005
  )

##### MÉDIA MENSAL PREVISÃO RESTROSPECTIVA CanCM4i 2006 #####
# Média de todos os membros
# OBS: S552 == Dez/2005
dados_prec_CanCM4i_2006_L1 <- prec_CanCM4i_L1 %>%
  mutate(
    .,
    "jan_2006" = rowMeans(
      select(
        .,
        contains("S.552")
      )
    ),
    "fev_2006" = rowMeans(
      select(
        .,
        contains("S.553")
      )
    ),
    "mar_2006" = rowMeans(
      select(
        .,
        contains("S.554")
      )
    ),
    "abr_2006" = rowMeans(
      select(
        .,
        contains("S.555")
      )
    ),
    "mai_2006" = rowMeans(
      select(
        .,
        contains("S.556")
      )
    ),
    "jun_2006" = rowMeans(
      select(
        .,
        contains("S.557")
      )
    ),
    "jul_2006" = rowMeans(
      select(
        .,
        contains("S.558")
      )
    ),
    "ago_2006" = rowMeans(
      select(
        .,
        contains("S.559")
      )
    ),
    "set_2006" = rowMeans(
      select(
        .,
        contains("S.560")
      )
    ),
    "out_2006" = rowMeans(
      select(
        .,
        contains("S.561")
      )
    ),
    "nov_2006" = rowMeans(
      select(
        .,
        contains("S.562")
      )
    ),
    "dez_2006" = rowMeans(
      select(
        .,
        contains("S.563")
      )
    )
  )

med_prec_CanCM4i_2006_L1 <- dados_prec_CanCM4i_2006_L1 %>%
  select(
    .,
    jan_2006:dez_2006
  )

##### MÉDIA MENSAL PREVISÃO RESTROSPECTIVA CanCM4i 2007 #####
# Média de todos os membros
# OBS: S564 == Dez/2006
dados_prec_CanCM4i_2007_L1 <- prec_CanCM4i_L1 %>%
  mutate(
    .,
    "jan_2007" = rowMeans(
      select(
        .,
        contains("S.564")
      )
    ),
    "fev_2007" = rowMeans(
      select(
        .,
        contains("S.565")
      )
    ),
    "mar_2007" = rowMeans(
      select(
        .,
        contains("S.566")
      )
    ),
    "abr_2007" = rowMeans(
      select(
        .,
        contains("S.567")
      )
    ),
    "mai_2007" = rowMeans(
      select(
        .,
        contains("S.568")
      )
    ),
    "jun_2007" = rowMeans(
      select(
        .,
        contains("S.569")
      )
    ),
    "jul_2007" = rowMeans(
      select(
        .,
        contains("S.570")
      )
    ),
    "ago_2007" = rowMeans(
      select(
        .,
        contains("S.571")
      )
    ),
    "set_2007" = rowMeans(
      select(
        .,
        contains("S.572")
      )
    ),
    "out_2007" = rowMeans(
      select(
        .,
        contains("S.573")
      )
    ),
    "nov_2007" = rowMeans(
      select(
        .,
        contains("S.574")
      )
    ),
    "dez_2007" = rowMeans(
      select(
        .,
        contains("S.575")
      )
    )
  )

med_prec_CanCM4i_2007_L1 <- dados_prec_CanCM4i_2007_L1 %>%
  select(
    .,
    jan_2007:dez_2007
  )

##### MÉDIA MENSAL PREVISÃO RESTROSPECTIVA CanCM4i 2008 #####
# Média de todos os membros
# OBS: S576 == Dez/2007
dados_prec_CanCM4i_2008_L1 <- prec_CanCM4i_L1 %>%
  mutate(
    .,
    "jan_2008" = rowMeans(
      select(
        .,
        contains("S.576")
      )
    ),
    "fev_2008" = rowMeans(
      select(
        .,
        contains("S.577")
      )
    ),
    "mar_2008" = rowMeans(
      select(
        .,
        contains("S.578")
      )
    ),
    "abr_2008" = rowMeans(
      select(
        .,
        contains("S.579")
      )
    ),
    "mai_2008" = rowMeans(
      select(
        .,
        contains("S.580")
      )
    ),
    "jun_2008" = rowMeans(
      select(
        .,
        contains("S.581")
      )
    ),
    "jul_2008" = rowMeans(
      select(
        .,
        contains("S.582")
      )
    ),
    "ago_2008" = rowMeans(
      select(
        .,
        contains("S.583")
      )
    ),
    "set_2008" = rowMeans(
      select(
        .,
        contains("S.584")
      )
    ),
    "out_2008" = rowMeans(
      select(
        .,
        contains("S.585")
      )
    ),
    "nov_2008" = rowMeans(
      select(
        .,
        contains("S.586")
      )
    ),
    "dez_2008" = rowMeans(
      select(
        .,
        contains("S.587")
      )
    )
  )

med_prec_CanCM4i_2008_L1 <- dados_prec_CanCM4i_2008_L1 %>%
  select(
    .,
    jan_2008:dez_2008
  )

##### MÉDIA MENSAL PREVISÃO RESTROSPECTIVA CanCM4i 2009 #####
# Média de todos os membros
# OBS: S588 == Dez/2008
dados_prec_CanCM4i_2009_L1 <- prec_CanCM4i_L1 %>%
  mutate(
    .,
    "jan_2009" = rowMeans(
      select(
        .,
        contains("S.588")
      )
    ),
    "fev_2009" = rowMeans(
      select(
        .,
        contains("S.589")
      )
    ),
    "mar_2009" = rowMeans(
      select(
        .,
        contains("S.590")
      )
    ),
    "abr_2009" = rowMeans(
      select(
        .,
        contains("S.591")
      )
    ),
    "mai_2009" = rowMeans(
      select(
        .,
        contains("S.592")
      )
    ),
    "jun_2009" = rowMeans(
      select(
        .,
        contains("S.593")
      )
    ),
    "jul_2009" = rowMeans(
      select(
        .,
        contains("S.594")
      )
    ),
    "ago_2009" = rowMeans(
      select(
        .,
        contains("S.595")
      )
    ),
    "set_2009" = rowMeans(
      select(
        .,
        contains("S.596")
      )
    ),
    "out_2009" = rowMeans(
      select(
        .,
        contains("S.597")
      )
    ),
    "nov_2009" = rowMeans(
      select(
        .,
        contains("S.598")
      )
    ),
    "dez_2009" = rowMeans(
      select(
        .,
        contains("S.599")
      )
    )
  )

med_prec_CanCM4i_2009_L1 <- dados_prec_CanCM4i_2009_L1 %>%
  select(
    .,
    jan_2009:dez_2009
  )

##### MÉDIA MENSAL PREVISÃO RESTROSPECTIVA CanCM4i 2010 #####
# Média de todos os membros
# OBS: S600 == Dez/2009
dados_prec_CanCM4i_2010_L1 <- prec_CanCM4i_L1 %>%
  mutate(
    .,
    "jan_2010" = rowMeans(
      select(
        .,
        contains("S.600")
      )
    ),
    "fev_2010" = rowMeans(
      select(
        .,
        contains("S.601")
      )
    ),
    "mar_2010" = rowMeans(
      select(
        .,
        contains("S.602")
      )
    ),
    "abr_2010" = rowMeans(
      select(
        .,
        contains("S.603")
      )
    ),
    "mai_2010" = rowMeans(
      select(
        .,
        contains("S.604")
      )
    ),
    "jun_2010" = rowMeans(
      select(
        .,
        contains("S.605")
      )
    ),
    "jul_2010" = rowMeans(
      select(
        .,
        contains("S.606")
      )
    ),
    "ago_2010" = rowMeans(
      select(
        .,
        contains("S.607")
      )
    ),
    "set_2010" = rowMeans(
      select(
        .,
        contains("S.608")
      )
    ),
    "out_2010" = rowMeans(
      select(
        .,
        contains("S.609")
      )
    ),
    "nov_2010" = rowMeans(
      select(
        .,
        contains("S.610")
      )
    ),
    "dez_2010" = rowMeans(
      select(
        .,
        contains("S.611")
      )
    )
  )

med_prec_CanCM4i_2010_L1 <- dados_prec_CanCM4i_2010_L1 %>%
  select(
    .,
    jan_2010:dez_2010
  )


#### AGRUPANDO MÉDIAS CanCM4i ####
med_prec_CanCM4i <- cbind(
  med_prec_CanCM4i_1982_L1,
  med_prec_CanCM4i_1983_L1,
  med_prec_CanCM4i_1984_L1,
  med_prec_CanCM4i_1985_L1,
  med_prec_CanCM4i_1986_L1,
  med_prec_CanCM4i_1987_L1,
  med_prec_CanCM4i_1988_L1,
  med_prec_CanCM4i_1989_L1,
  med_prec_CanCM4i_1990_L1,
  med_prec_CanCM4i_1991_L1,
  med_prec_CanCM4i_1992_L1,
  med_prec_CanCM4i_1993_L1,
  med_prec_CanCM4i_1994_L1,
  med_prec_CanCM4i_1995_L1,
  med_prec_CanCM4i_1996_L1,
  med_prec_CanCM4i_1997_L1,
  med_prec_CanCM4i_1998_L1,
  med_prec_CanCM4i_1999_L1,
  med_prec_CanCM4i_2000_L1,
  med_prec_CanCM4i_2001_L1,
  med_prec_CanCM4i_2002_L1,
  med_prec_CanCM4i_2003_L1,
  med_prec_CanCM4i_2004_L1,
  med_prec_CanCM4i_2005_L1,
  med_prec_CanCM4i_2006_L1,
  med_prec_CanCM4i_2007_L1,
  med_prec_CanCM4i_2008_L1,
  med_prec_CanCM4i_2009_L1,
  med_prec_CanCM4i_2010_L1
)
med_prec_CanCM4i



# como extrair os valores de lat e long?