## code to prepare `cetesb_aqs` dataset goes here

cetesb_aqs <- read.table("~/R_tests/QualR/qualR/cetesb_qualR.dat", header = FALSE,
                         sep = ',', col.names = c("code", "name"),
                         stringsAsFactors = FALSE)
cetesb_aqs <- cetesb_aqs[, c(2, 1)]
cetesb_aqs$name <- iconv(cetesb_aqs$name, from = "UTF-8", to = "ASCII//TRANSLIT")

usethis::use_data(cetesb_aqs, overwrite = TRUE)
