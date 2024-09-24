## code to prepare internal datasets goes here

cetesb <- read.table("cetesb_qualR.dat", sep = ",",
                     header = TRUE, col.names = c("code", "name"),
                     stringsAsFactors = FALSE)
cetesb$ascii <- iconv(cetesb$name, from = "UTF-8", to = "ASCII//TRANSLIT")
params <- read.table("cetesb_variables.dat", header = TRUE,
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
param_monitor_ar <- read.table("monitor_ar_variables.dat",
                               header = TRUE, sep = ",",
                               stringsAsFactors = FALSE)

aqs_monitor_ar <- read.table("monitor_ar_qualR.dat", header = TRUE, stringsAsFactors = FALSE,
                             sep = ",", dec=".")
aqs_monitor_ar$name <- iconv(aqs_monitor_ar$name, from = "UTF-8", to = "ASCII//TRANSLIT")


usethis::use_data(cetesb, params, params_code,
                  param_monitor_ar, aqs_monitor_ar,
                  internal = TRUE, overwrite = TRUE)
