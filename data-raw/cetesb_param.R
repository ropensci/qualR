## code to prepare `cetesb_param` dataset goes here

cetesb_param <- read.table("~/R_tests/cetesb_variables.dat", header = FALSE,
                           sep = ",", col.names = c("code", "name"),
                           stringsAsFactors = FALSE)
cetesb_param <- cetesb_param[, c(2, 1)]
cetesb_param$name <- iconv(cetesb_param$name, from = "UTF-8", to = "ASCII//TRANSLIT")
cetesb_param$units <- c("ug/m3", "ppm", "º", "º", "ppb",
                        "-", "ug/m3", "ug/m3", "ug/m3", "ug/m3",
                        "ppb", "ug/m3", "hPa", "W/m2", "W/m2",
                        "ug/m3", "ºC", "ug/m3", "%", "m/s")
cetesb_param <- cetesb_param[c("name", "units", "code")]

usethis::use_data(cetesb_param, overwrite = TRUE)
