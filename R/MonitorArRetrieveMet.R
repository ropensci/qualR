#' Download meteorological parameters from Monitor Ar program
#'
#' This function download the main meterorological paramenters from one
#' air quality station (AQS) of Monitor Ar network. It will
#' pad out the date with missing data with NA.
#'
#' @param start_date Date to start downloading in dd/mm/yyyy.
#' @param end_date Date to end downloading in dd/mm/yyyy.
#' @param aqs_code Code of AQS. See `monitor_ar_aqs`.
#' @param verbose Print query summary.
#' @param to_local Date information in local time. TRUE by default.
#' @param to_csv Create a csv file. FALSE by default.
#'
#' @return data.frame with Temperatur (c), Relative Humidity (%), Wind speed (m/s) and direction (degrees)
#' and Pressure information
#' @export
#'
#' @examples
#' \dontrun{
#' # Downloading meteorological data from CENTRO AQS
#' # from January first to 7th of 2020
#' start_date <- "01/01/2020"
#' end_date <- "07/01/2020"
#' ca_met <- MonitorArRetrieveMet(start_date, end_date, "CA")
#' }
MonitorArRetrieveMet <- function(start_date, end_date, aqs_code,
                                 verbose = TRUE, to_local = TRUE,
                                 to_csv = FALSE){
  # Check is aqs_code is valid
  if (!(aqs_code %in% aqs_monitor_ar$code)){
    stop("Wrong aqs_code, please check monitor_ar_aqs")
  }

  params <- c("Temp", "UR", "Vel_Vento", "Dir_Vento", "Press")

  all_met <- MonitorArRetrieve(start_date, end_date, aqs_code,
                               params, to_local = to_local,
                               verbose = FALSE)

  names(all_met) <- c("date", "tc", "rh", "ws", "wd", "p", "aqs")

  if (to_local){
    file_name <- paste0(aqs_code, "_", "MET_",
                        gsub("/", "-", start_date), "_",
                        gsub("/", "-", end_date), ".csv")
    utils::write.table(all_met, file_name, sep = ",", row.names = F)
    file_path <- paste(getwd(), file_name, sep = "/")
    cat(file_path, "was created")
  }

  return(all_met)
}
