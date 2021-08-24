## code to prepare `DATASET` dataset goes here

cetesb_aqs <- read.table("~/R_tests/cetesb2017_latlon.dat",
                            sep = ",", header = TRUE, dec = ".",
                            stringsAsFactors = F)
Encoding(cetesb_aqs$name) <- "UTF-8"
save(cetesb_aqs, file = "data/cetesb_aqs.rda")
usethis::use_data(cetesb_aqs, overwrite = TRUE)
