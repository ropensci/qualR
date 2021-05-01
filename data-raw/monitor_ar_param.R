## code to prepare `monitor_ar_param` dataset goes here

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

monitor_ar_param <- data.frame(code = param_code,
                               name = param_name,
                               units = param_units)
usethis::use_data(monitor_ar_param, overwrite = TRUE)
