## Build the texts dataset from the Python export
##
## Run from ~/pali first:
##   PYTHONPATH=src python -c "
##   from pali import Canon
##   Canon().export_tipitaka_texts('../tipitaka.critical/data-raw/texts.csv')
##   "
##
## Then run this script from ~/tipitaka.critical:
##   Rscript data-raw/build_data.R

texts <- read.csv("data-raw/texts.csv", stringsAsFactors = FALSE)

cat("Loaded", nrow(texts), "text units\n")
cat("Collections:", paste(sort(unique(texts$collection)), collapse = ", "), "\n")
cat("Pitakas:", paste(sort(unique(texts$pitaka)), collapse = ", "), "\n")

usethis::use_data(texts, overwrite = TRUE, compress = "xz")
