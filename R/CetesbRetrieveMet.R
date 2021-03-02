#' Download criteria pollutants from CETESB QUALAR
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
                               end_date, to_csv = FALSE){

  aqs <- cetesb
  aqs_name <- aqs$name[aqs$code == aqs_code]

  tc <- CetesbRetrieve(username, password, 25,
                       aqs_code, start_date,
                       end_date)

  rh <- CetesbRetrieve(username, password, 28,
                       aqs_code, start_date,
                       end_date)

  ws <- CetesbRetrieve(username, password, 24,
                       aqs_code, start_date,
                       end_date)

  wd <- CetesbRetrieve(username, password, 23,
                       aqs_code, start_date,
                       end_date)

  p <- CetesbRetrieve(username, password, 29,
                      aqs_code, start_date,
                      end_date)

  all_met <- data.frame(date = tc$date,
                        tc = tc$pol,
                        rh = rh$pol,
                        ws = ws$pol,
                        wd = wd$pol,
                        p = p$pol,
                        aqs = tc$aqs,
                        stringsAsFactors = F)
  print(paste(
    "Download complete for", unique(all_met$aqs)
    ))

  if (to_csv){
    file_name <- paste0(aqs_name, "_", "MET_",                          # nocov start
                        gsub("/", "-", start_date), "_",
                        gsub("/", "-", end_date), ".csv")
    utils::write.table(all_met, file_name, sep = ",", row.names = F )

    file_path <- paste(getwd(), file_name, sep = "/")
    print(paste(file_path, "was created"))                              # nocov end
  }

  return(all_met)
}
