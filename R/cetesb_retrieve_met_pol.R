#' Download meteorological and pollutant data from CETESB QUALAR
#'
#' This function download the main meteorological parameters for model
#' evaluation, together with criteria pollutants for one
#' air quality station (AQS). It will pad out the date with
#' missing data with NA.
#' This function required to have
#' \href{https://seguranca.cetesb.sp.gov.br/Home/CadastrarUsuario}{an account}
#' in \href{https://qualar.cetesb.sp.gov.br/qualar/home.do}{CETESB QUALAR}.
#'
#' @param username User name of CETESB QUALAR
#' @param password User name's password of CETESB QUALAR
#' @param aqs_code Code of AQS
#' @param start_date Date to start downloading in dd/mm/yyyy
#' @param end_date Date to end downloading in dd/mm/yyyy
#' @param verbose Print query summary
#' @param to_csv Creates a csv file. FALSE by default
#' @param csv_path Path to save the csv file.
#'
#' @return data.frame with Temperature (C), Relative Humidity (%),
#' Wind Speed (m/s) and Direction (degrees), Pressure information (hPa),
#'  O3, NO, NO2, NOx, PM2.5, PM10 and CO information.
#' @export
#'
#' @examples
#' \dontrun{
#' # Downloading main meteorological parameters and criteria pollutants
#' # from Pinheiros AQS from January first to 7th of 2020
#' my_user_name <- "John Doe"
#' my_pass_word <- "drowssap"
#' pin_code <- 99 # Check with cetesb_aqs
#' start_date <- "01/01/2020"
#' end_date <- "07/01/2020"
#'
#' pin_all <- cetesb_retrieve_met_pol(my_user_name, my_pass_word, pin_code,
#'                                    start_date, end_date)
#'
#' }
cetesb_retrieve_met_pol <- function(username, password,
                                    aqs_code, start_date,
                                    end_date, verbose = TRUE,
                                    to_csv = FALSE, csv_path = ""){

  # Check if aqs_code is valid
  aqs <- cetesb
  check_code <- check_cetesb_code(aqs, aqs_code)
  aqs_name <- check_code[1]
  aqs_code <- as.numeric(check_code[2])

  # Adding query summary
  if (verbose){
    message("Your query is: ")
    message(paste("Parameter: TC, RH, WS, WD, Pressure,",
                  "O3, NO, NO2, NOX, PM2.5, PM10, CO"))
    message("Air quality station: ", aqs_name)
    message("Period: From ", start_date, " to ", end_date)
  }

  tc <- cetesb_retrieve(username, password, 25,
                       aqs_code, start_date,
                       end_date, verbose = FALSE)

  rh <- cetesb_retrieve(username, password, 28,
                       aqs_code, start_date,
                       end_date, verbose = FALSE)

  ws <- cetesb_retrieve(username, password, 24,
                       aqs_code, start_date,
                       end_date, verbose = FALSE)

  wd <- cetesb_retrieve(username, password, 23,
                       aqs_code, start_date,
                       end_date, verbose = FALSE)

  p <- cetesb_retrieve(username, password, 29,
                      aqs_code, start_date,
                      end_date, verbose = FALSE)

  o3 <- cetesb_retrieve(username, password, 63,
                       aqs_code, start_date,
                       end_date, verbose = FALSE)

  no <- cetesb_retrieve(username, password, 17,
                       aqs_code, start_date,
                       end_date, verbose = FALSE)

  no2 <- cetesb_retrieve(username, password, 15,
                        aqs_code, start_date,
                        end_date, verbose = FALSE)

  nox <- cetesb_retrieve(username, password, 18,
                        aqs_code, start_date,
                        end_date, verbose = FALSE)

  pm25 <- cetesb_retrieve(username, password, 57,
                         aqs_code, start_date,
                         end_date, verbose = FALSE)

  pm10 <- cetesb_retrieve(username, password, 12,
                         aqs_code, start_date,
                         end_date, verbose = FALSE)

  co <- cetesb_retrieve(username, password, 16,
                       aqs_code, start_date,
                       end_date, verbose = FALSE)


  all_data <- data.frame(date = o3$date,
                         tc = tc$pol,
                         rh = rh$pol,
                         ws = ws$pol,
                         wd = wd$pol,
                         p = p$pol,
                         o3 = o3$pol,
                         no = no$pol,
                         no2 = no2$pol,
                         nox = nox$pol,
                         co = co$pol,
                         pm10 = pm10$pol,
                         pm25 = pm25$pol,
                         aqs = o3$aqs,
                         stringsAsFactors = FALSE)

  cols_unchange <- -c(1, ncol(all_data))
  all_data[, cols_unchange] <- sapply(all_data[, cols_unchange], as.numeric)

  message(paste(
    "Download complete for", unique(all_data$aqs)
  ))

  if (to_csv){                                                  # nocov start
    write_csv(all_data, aqs_name, start_date, end_date, "MET_POL", csv_path)
  }                                                             # nocov end

    return(all_data)
}
