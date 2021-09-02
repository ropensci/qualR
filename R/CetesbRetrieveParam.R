#' Download list of observation from CETESB QUALAR
#'
#' This function downloads the parameters in a vector, this parameters
#' can be both pollutants or meteorological observations for one air
#' quality station (AQS). It will pad out the date with missing data
#'
#' @param username User name of CETESB QUALAR
#' @param password User name's password of CETESB QUALAR
#' @param parameters a character vector with the parameters abbreviations to download
#' @param aqs_code Code of AQS
#' @param start_date Date to start downloading in dd/mm/yyyy
#' @param end_date Date to end downloading in dd/mm/yyyy
#' @param verbose Print query summary
#' @param to_csv  Creates a csv file. FALSE by default
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
CetesbRetrieveParam <- function(username, password, parameters,
                                aqs_code, start_date, end_date,
                                verbose = TRUE, to_csv = FALSE){

  # Check if aqs_code is valid
  aqs <- cetesb
  check_code <- CheckCetesbCode(aqs, aqs_code)
  aqs_name <- check_code[1]
  aqs_code <- as.numeric(check_code[2])

  # Check parameters code
  param <- toupper(parameters)
  all_params <- c(params_code$name, params_code$code)
  param_exist <- param %in% all_params

  if (FALSE %in% param_exist){
    stop(paste(paste(param[!param_exist], collapse = ", "),
               "are wrong parameters, please check cetesb_param"),
         call. = FALSE)
  } else {
    codes_df <- params_code[params_code$name %in% param, ]
    if (nrow(codes_df) != length(param)){
      codesd_df2 <- params_code[params_code$code %in% param, ]
      codes_df <- rbind(codes_df, codesd_df2)
      codes_df <- unique(codes_df)
    }
  }


  # Adding query summary
  if (verbose){
    cat("Your query is:\n")
    cat("Parameter:", paste(codes_df$name, collapse = ", "), "\n")
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

  # Changing wind speed and direction columns to ws and wd
  if ("dv" %in% names(aqs_data_df)){
    names(aqs_data_df)[names(aqs_data_df) == "dv"] <- "wd"  # nocov
  }
  if ("vv" %in% names(aqs_data_df)){
    names(aqs_data_df)[names(aqs_data_df) == "vv"] <- "ws"
  }
  if ("ur" %in% names(aqs_data_df)){
    names(aqs_data_df)[names(aqs_data_df) == "ur"] <- "rh"
  }
  if ("temp" %in% names(aqs_data_df)){
    names(aqs_data_df)[names(aqs_data_df) == "temp"] <- "tc"
  }
  if ("mp10" %in% names(aqs_data_df)){
    names(aqs_data_df)[names(aqs_data_df) == "mp10"] <- "pm10"
  }
  if ("mp2.5" %in% names(aqs_data_df)){
    names(aqs_data_df)[names(aqs_data_df) == "mp2.5"] <- "pm25"
  }

  if (to_csv){
    WriteCSV(aqs_data_df, aqs_name, start_date, end_date, param)
  }

  return(aqs_data_df)
}
