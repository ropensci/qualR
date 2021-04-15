#' Download list of observation from CETESB QUALAR
#'
#' This function downloads the parameters in a vector, this parameters
#' can be both pollutants or meteorological observations for one air
#' quality station (AQS). It will pad out the date with missing data
#'
#' @param username User name of CETESB QUALAR
#' @param password User name's password of CETESB QUALAR
#' @param params a character vector with the parameters abbreviations to download
#' @param aqs_code Code of AQS
#' @param start_date Date to start downloading in dd/mm/yyyy
#' @param end_date Date to end downloading in dd/mm/yyyy
#' @param verbose Print query summary
#'
#' @return data.frame with parameters described in `params` vector
#' @export
#'
#' @examples
#' \dontrun{
#' # Download ozone, nitrogen dioxide, and wind speed
#' # from Pinheiros AQS, from January first to 7th of 2020
#'
#' my_user_name <- "John Doe"
#' my_pass_word <- "drowssap"
#' pin_code <- 99 # Check with cetesb_aqs
#' start_date <- "01/01/2020"
#' end_date <- "07/01/2020"
#' params <- c("o3","NOX", "VV")
#'
#' pin_param <- CetesbRetrieveParam(my_user_name, my_pass_word,
#'                                  params, pin_code,
#'                                  start_date, end_date)
#' }
CetesbRetrieveParam <- function(username, password, params,
                                aqs_code, start_date, end_date,
                                verbose = TRUE){
  aqs <- cetesb

  # Check if aqs_code is valid
  if (is.numeric(aqs_code) & aqs_code %in% aqs$code){
    aqs_code <- aqs_code
    aqs_name <- aqs$name[aqs$code == aqs_code]
  } else if (is.character(aqs_code) & aqs_code %in% (aqs$name)){
    aqs_name <- aqs_code
    aqs_code <- aqs$code[aqs$name == aqs_code]
  } else {
    stop("Wrong aqs_code value, please check cetesb_latlon or cetesb_aqs",
         call. = FALSE)
  }

  param <- toupper(params)
  codes_df <- params_code[params_code$name %in% param, ]

  # Adding query summary
  if (verbose){
    cat("Your query is:\n")
    cat("Parameter:", paste(param, collapse = ", "), "\n")
    cat("Air quality staion:", aqs_name, "\n")
    cat("Period: From", start_date, "to", end_date, "\n")
  }

  # Downloading data
  aqs_data <-  lapply(codes_df$code, CetesbRetrieve,
                      username = username,
                      password = password,
                      aqs_code = aqs_code,
                      start_date = start_date,
                      end_date = end_date,
                      verbose = FALSE)

  for (i in seq(length(aqs_data))){
    names(aqs_data[[i]]) <- c("date", tolower(codes_df$name[i]), "aqs")
  }

  aqs_data_df <- Reduce(merge, aqs_data)
  return(aqs_data_df)
}
