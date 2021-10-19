#' Download meteorological parameters from CETESB QUALAR
#'
#' This function download the main meteorological parameters for
#' model evaluation from one air quality station (AQS) of CETESB AQS network.
#' It will pad out the date with missing data with NA.
#'
#'
#' @param username User name of CETESB QUALAR
#' @param password User name's password of CETESB QUALAR
#' @param aqs_code Code of AQS
#' @param start_date Date to start downloading in dd/mm/yyyy
#' @param end_date Date to end downloading in dd/mm/yyyy
#' @param verbose Print query summary
#' @param to_csv  Creates a csv file. FALSE by default
#'
#' @return data.frame wth Temperature (C), Relative Humidity (%), Wind Speed (m/s) and Direction (degrees),
#' and Pressure information.
#' @export
#'
#' @examples
#' \dontrun{
#' # Downloading meteorological data from Pinheiros AQS
#' # from January first to 7th of 2020
#' my_user_name <- "John Doe"
#' my_pass_word <- "drowssap"
#' pin_code <- 99 # Check with cetesb_aqs
#' start_date <- "01/01/2020"
#' end_date <- "07/01/2020"
#'
#' pin_pol <- CetesbRetrieveMet(my_user_name, my_pass_word, pin_code, start_date, end_date)
#' }
CetesbRetrieveMet <-  function(username, password,
                               aqs_code, start_date,
                               end_date, verbose = TRUE,
                               to_csv = FALSE){

  # Check if aqs_code is valid
  aqs <- cetesb
  check_code <- CheckCetesbCode(aqs, aqs_code)
  aqs_name <- check_code[1]
  aqs_code <- as.numeric(check_code[2])

  # Adding query summary
  if (verbose){
    cat("Your query is:\n")
    cat("Parameter: TC, RH, WS, WD, Pressure \n")
    cat("Air quality station:", aqs_name, "\n")
    cat("Period: From", start_date, "to", end_date, "\n")
  }

  tc <- CetesbRetrieve(username, password, 25,
                       aqs_code, start_date,
                       end_date, verbose = FALSE)

  rh <- CetesbRetrieve(username, password, 28,
                       aqs_code, start_date,
                       end_date, verbose = FALSE)

  ws <- CetesbRetrieve(username, password, 24,
                       aqs_code, start_date,
                       end_date, verbose = FALSE)

  wd <- CetesbRetrieve(username, password, 23,
                       aqs_code, start_date,
                       end_date, verbose = FALSE)

  p <- CetesbRetrieve(username, password, 29,
                      aqs_code, start_date,
                      end_date, verbose = FALSE)

  all_met <- data.frame(date = tc$date,
                        tc = tc$pol,
                        rh = rh$pol,
                        ws = ws$pol,
                        wd = wd$pol,
                        p = p$pol,
                        aqs = tc$aqs,
                        stringsAsFactors = FALSE)
  cat(paste(
    "Download complete for", unique(all_met$aqs), "\n"
    ))

  if (to_csv){
    WriteCSV(all_met, aqs_name, start_date, end_date, "MET") # nocov
  }

  return(all_met)
}
