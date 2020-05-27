## code to prepare `cetesb` dataset goes here

cetesb <- read.table("~/R_tests/QualR/qualR/cetesb_qualR.dat", sep = ",",
                     header = FALSE, col.names = c("code", "name"),
                     stringsAsFactors = FALSE)


usethis::use_data(cetesb, internal = TRUE)
