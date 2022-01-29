## code to prepare `monitor_ar_aqs` dataset goes here

monitor_ar_aqs <- read.table("~/Downloads/aqs_rio.csv", header = TRUE, stringsAsFactors = FALSE,
                      sep = ",", dec=".")
monitor_ar_aqs <- monitor_ar_aqs[, c(4, 8, 1, 2, 12, 13)]
names(monitor_ar_aqs) <- c("name", "code", "lon", "lat", "x_utm_sirgas2000", "y_utm_sirgas2000")
monitor_ar_aqs$name <- iconv(monitor_ar_aqs$name, from = "UTF-8", to = "ASCII//TRANSLIT")

usethis::use_data(monitor_ar_aqs, overwrite = TRUE)
