## code to prepare internal datasets goes here

cetesb <- read.table("~/R_tests/QualR/qualR/cetesb_qualR.dat", sep = ",",
                     header = FALSE, col.names = c("code", "name"),
                     stringsAsFactors = FALSE)
params <- read.table("~/R_tests/cetesb_variables.dat", header = FALSE,
                     sep = ",", col.names = c("code", "name"),
                     stringsAsFactors = FALSE)

params_code <- data.frame(
  name = do.call(
    rbind,
    lapply(strsplit(toupper(params$name), " "),
           function(x) x[[1]][1])
  ),
  code = params$code
)

# Monitor Ar data
param_code <- c("SO2", "NO2", "NO", "NOx", "HCNM", "HCT",
                "CH4", "CO", "O3", "PM10", "PM2_5",
                "Chuva", "Pres", "RS", "Temp", "UR",
                "Dir_Vento", "Vel_Vento")
param_name <- c("Dioxido de enxofre", "Dioxido de nitrogenio", "Monoxido de Nitrogenio", "Oxidos de nitrogenio",
                "Hidrocarbonetos Totais menos Metano", "Hidrocarbonetos Totais", "Metano", "Monoxido de Carbono",
                "Ozonio", "Particulas Inalaveis", "Particulas Inalaveis Finas", "Precipitacao Pluviometrica",
                "Pressao Atmosferica", "Radiacao Solar", "Temperatura", "Umidade Relativa do Ar",
                "Direcao do Vento", "Velocidade do Vento")
param_units <- c("ug/m3", "ug/m3", "ug/m3", "ug/m3", "ppm", "ppm",
                 "ug/m3", "ppm", "ug/m3", "ug/m3", "ug/m3",
                 "mm", "mbar", "W/m2", "ºC", "%",
                 "º", "m/s")

param_monitor_ar <- data.frame(code = param_code,
                               name = param_name,
                               units = param_units)

aqs_monitor_ar <- read.table("~/Downloads/aqs_rio.csv", header = TRUE, stringsAsFactors = FALSE,
                             sep = ",", dec=".")
aqs_monitor_ar <- aqs_monitor_ar[, c(4, 8, 1, 2, 12, 13)]
names(aqs_monitor_ar) <- c("name", "code", "lon", "lat", "X_UTM_Sirgas2000", "Y_UTM_Sirgas2000")
aqs_monitor_ar$name <- iconv(aqs_monitor_ar$name, from = "UTF-8", to = "ASCII//TRANSLIT")


usethis::use_data(cetesb, params, params_code,
                  param_monitor_ar, aqs_monitor_ar,
                  internal = TRUE, overwrite = TRUE)
