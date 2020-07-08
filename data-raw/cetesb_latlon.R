## code to prepare `DATASET` dataset goes here

cetesb_latlon <- read.table("~/R_tests/cetesb2017_latlon.dat",
                            sep = ",", header = TRUE, dec = ".",
                            stringsAsFactors = F)
save(cetesb_latlon, file = "data/cetesb_latlon.rda")
usethis::use_data(cetesb_latlon, overwrite = TRUE)
