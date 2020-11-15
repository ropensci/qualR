## code to prepare `monitor_ar_aqs` dataset goes here

monitor_ar_aqs <- read.table("~/Downloads/aqs_rio.csv", header = TRUE, stringsAsFactors = FALSE,
                      sep = ",", dec=".")
monitor_ar_aqs <- monitor_ar_aqs[, c(4, 8, 1, 2, 12, 13)]
names(monitor_ar_aqs) <- c("name", "code", "lon", "lat", "X_UTM_Sirgas2000", "Y_UTM_Sirgas2000")
monitor_ar_aqs$name <- iconv(monitor_ar_aqs$name, from = "UTF-8", to = "ASCII//TRANSLIT")

usethis::use_data(monitor_ar_aqs, overwrite = TRUE)
