## code to prepare `cetesb` dataset goes here

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


usethis::use_data(cetesb, params, params_code, internal = TRUE, overwrite = TRUE)
