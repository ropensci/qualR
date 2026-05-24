#' Display query summary
#'
#' @param start_date Start date of query
#' @param end_date End date of query
#' @param aqs_name Name of the station
#' @param retrive_type Type of retrieve function
#' @param param_vector Use when using *_param functions
#'
#' @noRd
#' @keywords internal

query_summary <- function(start_date, end_date, aqs_name,
                          retrive_type, param_vector = NULL){
  if (getOption("qualR.quiet", FALSE)) {
    return()
  }

  switch (retrive_type,
          pol = {parameters <- "O3, NO, NO2, NOX, MP2.5, MP10, CO"},
          met = {parameters <- "TC, RH, WS, WD, Pressure"},
          met_pol = {parameters <- "TC, RH, WS, WD, Pressure,O3, NO, NO2, NOX, PM2.5, PM10, CO"},
          param = {parameters <- paste(param_vector, collapse = ", ")}
  )

  message("Your query is:")
  message(paste0("Parameter: ", parameters))
  message("Air quality station: ", aqs_name)
  message("Period: From ", start_date, " to ", end_date)
}

#' Download Ok message for CETESB
#'
#' @param pol_br Name of the download parameter
#'
#' @noRd
#' @keywords internal
download_ok_cetesb_msg <-function(pol_abr, aqs_name = NULL){
  if (getOption("qualR.quiet", FALSE)) {
    return()
  }

  if (!is.null(aqs_name)){
    message(paste("Download complete for", aqs_name))
  } else {
    message(paste0('Download OK ', pol_abr))
  }
}

#' Padding out message
#'
#' @param param_name Parameter name that has missing data
#'
#' @noRd
#' @keywords internal
padding_out_message_for <- function(param_name){
  if (getOption("qualR.quiet", FALSE)) {
    return()
  }
  message(paste0(                                                      # nocov
    'No data available for ',                                          # nocov
    param_name,                                                          # nocov
    ". Filling with NA."))
}

#' Download Ok message for MOnitor AR
#'
#' @param res request
#' @param parameters  Name of the download parameter
#'
#' @noRd
#' @keywords internal
download_ok_monitor_msg <-function(res, parameters){
  if (getOption("qualR.quiet", FALSE)) {
    return()
  }
  if (res$status_code == 200){
    message("Succesful request")
    message(paste("Downloading ", paste(parameters, collapse = " ")))
  } else {
    stop("Unsuccesful request. Something goes wrong", call. = FALSE)     # nocov
  }
}


