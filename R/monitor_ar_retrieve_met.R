#' Download meteorological parameters from Monitor Ar program
#'
#' This function download the main meteorological parameters from one
#' air quality station (AQS) of Monitor Ar network. It will
#' pad out the date with missing data with NA.
#'
#' @param start_date Date to start downloading in dd/mm/yyyy.
#' @param end_date Date to end downloading in dd/mm/yyyy.
#' @param aqs_code Code of AQS. See `monitor_ar_aqs`.
#' @param verbose Print query summary.
#' @param to_local Date information in local time. TRUE by default.
#' @param to_csv Create a csv file. FALSE by default.
#' @param csv_path Path to save the csv file.
#'
#' @return data.frame with Temperature (c), Relative Humidity (%),
#' Wind speed (m/s) and direction (degrees) and Pressure information.
#' @export
#'
#' @examples
#' \dontrun{
#' # Downloading meteorological data from CENTRO AQS
#' # from January first to 7th of 2020
#' start_date <- "01/01/2020"
#' end_date <- "07/01/2020"
#' ca_met <- monitor_ar_retrieve_met(start_date, end_date, "CA")
#' }
monitor_ar_retrieve_met <- function(start_date, end_date, aqs_code,
                                    verbose = TRUE, to_local = TRUE,
                                    to_csv = FALSE, csv_path = ""){
  # Check is aqs_code is valid
  if (!(aqs_code %in% aqs_monitor_ar$code)){
    stop("Wrong aqs_code, please check monitor_ar_aqs", call. = FALSE) # nocov
  }

  params <- c("Temp", "UR", "Vel_Vento", "Dir_Vento", "Pres")

  # Adding query summary
  aqs_name <- aqs_monitor_ar$name[aqs_monitor_ar$code == aqs_code]

  if (verbose){
    message("Your query is:")
    message("Parameter: ", paste(params, collapse = ", "))
    message("Air quality station: ", aqs_name)
    message("Period: From ", start_date, " to ", end_date)
  }

  all_met <- monitor_ar_retrieve_param(start_date, end_date, aqs_code,
                                       params, to_local = to_local,
                                       verbose = FALSE)

  names(all_met) <- c("date", "tc", "rh", "ws", "wd", "p", "aqs")

  cols_unchage <- -c(1, ncol(all_met))
  all_met[, cols_unchage] <- sapply(all_met[, cols_unchage], as.numeric)

  if (to_csv){
    write_csv(all_met, aqs_name, start_date, end_date, "MET", csv_path) # nocov
  }

  return(all_met)
}
