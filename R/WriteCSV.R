#' Internal function - Export to csv data download
#'
#' @param aqs_data_frame Downloaded dataframe
#' @param aqs_name AQS name
#' @param start_date Download start date
#' @param end_date Download end date
#' @param vars identifier in file name
#'
#' @noRd
#' @keywords internal

WriteCSV <- function(aqs_data_df, aqs_name, start_date, end_date,
                     vars, csv_path){
  file_name <- paste0(aqs_name, "_",
                      paste0(vars, collapse = "_"), "_",
                      gsub("/", "-", start_date), "_",
                      gsub("/", "-", end_date), ".csv")

  if (csv_path == ""){
    file_path <- paste(getwd(), file_name, sep = "/") # nocov
  } else {
    file_path <- paste(csv_path, file_name, sep = "/") # nocov
  }

  utils::write.table(aqs_data_df, file_path, sep = ",", row.names = FALSE)
  message(paste(file_path, "was created"))
}
