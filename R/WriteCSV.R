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

WriteCSV <- function(aqs_data_df, aqs_name, start_date, end_date, vars){
  file_name <- paste0(aqs_name, "_",
                      paste0(vars, collapse = "_"), "_",
                      gsub("/", "-", start_date), "_",
                      gsub("/", "-", end_date), ".csv")
  utils::write.table(aqs_data_df, file_name, sep = ",", row.names = F )

  file_path <- paste(getwd(), file_name, sep = "/")
  cat(paste(file_path, "was created \n"))
}
