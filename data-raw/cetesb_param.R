## code to prepare `cetesb_param` dataset goes here

cetesb_param <- read.table("~/R_tests/cetesb_variables.dat", header = FALSE,
                           sep = ",", col.names = c("code", "name"),
                           stringsAsFactors = FALSE)
cetesb_param <- cetesb_param[, c(2, 1)]
cetesb_param$name <- iconv(cetesb_param$name, from = "UTF-8", to = "ASCII//TRANSLIT")

usethis::use_data(cetesb_param, overwrite = TRUE)
