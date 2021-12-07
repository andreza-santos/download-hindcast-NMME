
<!-- README.md is generated from README.Rmd. Please edit that file -->

# download-hindcast-NMME

<!-- badges: start -->
<!-- badges: end -->

O objevo do download-hindcast-NMME é processar os dados das previsões
climática do NMME.

``` r
easypackages::libraries(c("tidyverse"))
#> Loading required package: tidyverse
#> ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.0 ──
#> ✓ ggplot2 3.3.5          ✓ purrr   0.3.4     
#> ✓ tibble  3.1.4          ✓ dplyr   1.0.5     
#> ✓ tidyr   1.1.3.9000     ✓ stringr 1.4.0     
#> ✓ readr   1.4.0          ✓ forcats 0.5.1
#> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
#> x dplyr::filter() masks stats::filter()
#> x dplyr::lag()    masks stats::lag()
#> All packages loaded successfully
#fs::dir_ls(here("R"), glob = "*.R") %>%
#  fs::path_file()
```

# Descrição

-   `test-down-nmme.R`: *Download* dos dados por modelo e ano, no format
    NetCDF.

    -   depende do script `models-nmme.R` que gera objeto chamado
        `tabela1` com informações dos modelos, como nomes e períodos.

    -   arquivos de saída em `output/prec` no padrão
        `nmme_{variavel}_{modelo}_{ano}.nc`

-   `dados-brutos.R`:

    -   depende do script `data-proc-nc.R` que contém as funções para
        extrair os dados de todos arquivos netcdf de um dado modelo,
        para um dado *lead time* (L, varia de 0.5 a 11.5).

    -   arquivos de saída no fomato RDS segundo o padrão
        `nmme_{var_name}_{model_id}_lt{lead_time}.RDS`
