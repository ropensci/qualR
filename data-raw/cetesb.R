## code to prepare `cetesb` dataset goes here

cetesb <- read.table("~/R_tests/QualR/qualR/cetesb_qualR.dat", sep = ",",
                     header = FALSE, col.names = c("code", "name"),
                     stringsAsFactors = FALSE)
params <- read.table("~/R_tests/cetesb_variables.dat", header = FALSE,
                     sep = ",", col.names = c("code", "name"),
                     stringsAsFactors = FALSE)

usethis::use_data(cetesb, params, internal = TRUE, overwrite = TRUE)
