#' Download meteorological and pollutant data from Monitor Ar Program
#'
#' This function download the main meteorological parameters for model
#' evaluation, together with criteria pollutants for in air quality station
#' (AQS) of Monitor Ar program.
#' It will pad out the date with missing data with NA
#'
#' @param start_date Date to start downloading dd/mm/yyyy
#' @param end_date Date to end downloading dd/mm/yyyy
#' @param aqs_code Code of AQS
#' @param verbose Print query summary
#' @param to_local Date information in local time. TRUE by default.
#' @param to_csv Creates a csv file. FALSE by default.
#' @param csv_path Path to save the csv file.
#'
#' @return data.frame with Temperature (C), Relative Humidity (%),
#' Wind Speed (m/s) and Direction (degrees), Pressure information (hPa),
#'  O3, NO, NO2, NOx, PM2.5, PM10 and CO information.
#' @export
#'
#' @examples
#' \dontrun{
#' # Downloading main meteorological parameters and criteria pollutant
#' # from CENTRO AQS from January first to 7th of 2020
#' start_date <- "01/01/2020"
#' end_date <- "07/01/2020"
#' ca_all <- MonitorArRetrieceMetPol(start_date, end_date, "CA")
#' }
MonitorArRetrieveMetPol <- function(start_date, end_date, aqs_code,
                                    verbose = TRUE, to_local = TRUE,
                                    to_csv = FALSE, csv_path = ""){
  # Check is aqs_code is valid
  if (!(aqs_code %in% aqs_monitor_ar$code)){
    stop("Wrong aqs_code, please check monitor_ar_aqs", call. = FALSE) # nocov
  }

  params <- c("Temp", "UR", "Vel_Vento", "Dir_Vento", "Pres",
              "O3", "NO", "NO2", "NOx", "CO", "PM10", "PM2_5")

  # Adding query summary
  aqs_name <- aqs_monitor_ar$name[aqs_monitor_ar$code == aqs_code]

  if (verbose){
    message("Your query is: ")
    message("Parameter: ", paste(params, collapse = ", "))
    message("Air quality station: ", aqs_name)
    message("Period: From ", start_date, " to ", end_date)
  }

  all_data <- MonitorArRetrieveParam(start_date, end_date, aqs_code,
                                     params, to_local = to_local,
                                     verbose = FALSE)

  names(all_data) <- c("date", tolower(params), "aqs")
  names(all_data)[2:6] <- c("tc", "rh", "ws", "wd", "p")
  names(all_data)[13] <- "pm25"

  cols_unchange <- -c(1, ncol(all_data))
  all_data[, cols_unchange] <- sapply(all_data[, cols_unchange],
                                      as.numeric)

  if (to_csv){                                                  # nocov start
    WriteCSV(all_data, aqs_name, start_date, end_date, "MET_POL", csv_path)
  }                                                             # nocov end

  return(all_data)
}
