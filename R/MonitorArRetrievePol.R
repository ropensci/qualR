#' Download criteria pollutants from Monitor Ar program
#'
#' This function download the criteria pollutants from
#' one air quality station (AQS) of Monitor Ar Program.
#' It will pad out the date with missing data with NA.
#'
#' @param start_date Date to start downloading in dd/mm/yyyy.
#' @param end_date Date to end downloading in dd/mm/yyyy.
#' @param aqs_code Code of AQS.
#' @param verbose Print query summary.
#' @param to_local Date information in local time. TRUE by default.
#' @param to_csv Creates a csv file. FALSE by default.
#' @param csv_path Path to save the csv file.
#'
#' @return data.frame with O3, NO, NO2, NOx, PM2.5, PM10 and CO
#' information.
#' @export
#'
#' @examples
#' \dontrun{
#' # Downloading criteria pollutants from CENTRO AQS
#' # from January first to 7th of 2020
#' start_date <- "01/01/2020"
#' end_date <- "07/01/2020"
#' ca_pol <- MonitorArRetrievePol(start_date, end_date, "CA")
#' }
MonitorArRetrievePol <- function(start_date, end_date, aqs_code,
                                 verbose = TRUE, to_local = TRUE,
                                 to_csv = FALSE, csv_path = ""){
  # Check is aqs_code is valid
  if (!(aqs_code %in% aqs_monitor_ar$code)){
    stop("Wrong aqs_code, please check monitor_ar_aqs", call. = FALSE) # nocov
  }

  params <- c("O3", "NO", "NO2", "NOx", "CO", "PM10", "PM2_5")

  # Adding query summary
  aqs_name <- aqs_monitor_ar$name[aqs_monitor_ar$code == aqs_code]

  if (verbose){
    message("Your query is:")
    message("Parameter: ", paste(params, collapse = ", "))
    message("Air quality station: ", aqs_name)
    message("Period: From ", start_date, " to ", end_date)
  }

  all_pol <- MonitorArRetrieveParam(start_date, end_date, aqs_code,
                                    params, to_local = to_local,
                                    verbose = FALSE)

  names(all_pol) <- c("date", tolower(params), "aqs")
  names(all_pol)[8] <- "pm25"

  # Ensure columns as numeric
  cols_unchange <- -c(-1, -ncol(all_pol))
  all_pol[, cols_unchange] <- sapply(all_pol[, cols_unchange], as.numeric)

  if (to_csv){
    WriteCSV(all_pol, aqs_name, start_date, end_date, "POL", csv_path) # nocov
  }

  return(all_pol)
}
