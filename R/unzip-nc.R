#----------------------------------------------------------------------------
# Pré-processamento adicional. Os dados que baixei do gdrive são zipados.
# foram salvos no output.

extract_zip <- function(ifile, ex_dir) {
  # ifile = zips[1]
  cat(ifile, "\n", dest_dir, "\n")
  unzip(ifile, exdir = dest_dir, jun) # %>% select(Name) %>% pull()
}

unzip_ncs <- function(vname = "prec", ex_dir = "output") {
  
  zips <- fs::dir_ls(ex_dir,
                     regexp = stringr::str_replace(
                       "vname.*zip$",
                       "vname",
                       vname
                     )
  )
  
  dest_dir <- fs::dir_create(here(ex_dir, vname))
  
  # a função map é para fazer looping, descompactando cada zip
  # purrr::map(zips, extract_zip)
  purrr::walk(zips, extract_zip)
}
# output/prec-20210316T182545Z-001.zip output/prec-20210316T182545Z-002.zip
# output/prec-20210316T182545Z-003.zip output/prec-20210316T182545Z-004.zip
