#' Download meteorological and pollutant data from CETESB QUALAR
#'
#' This function download the main meteorological parameters for model evaluation,
#' together with criteria pollutants for one air quality station (AQS).
#' It will pad out the date with missing data with NA.
#'
#' @param username User name of CETESB QUALAR
#' @param password User name's password of CETESB QUALAR
#' @param aqs_code Code of AQS
#' @param start_date Date to start downloading in dd/mm/yyyy
#' @param end_date Date to end downloading in dd/mm/yyyy
#' @param verbose Print query summary
#' @param to_csv Creates a csv file. FALSE by default
#'
#' @return data.frame with Temperature (C), Relative Humidity (%), Wind Speed (m/s) and Direction (degrees),
#' Pressure information (hPa), O3, NO, NO2, NOx, PM2.5, PM10 and CO information.
#' @export
#'
#' @examples
#' \dontrun{
#' # Downloading main meteorological parameters and criteria pollutants from Pinheiros AQS
#' # from January first to 7th of 2020
#' my_user_name <- "John Doe"
#' my_pass_word <- "drowssap"
#' pin_code <- 99 # Check with cetesb_aqs
#' start_date <- "01/01/2020"
#' end_date <- "07/01/2020"
#'
#' pin_pol <- CetesbRetrieveMetPol(my_user_name, my_pass_word, pin_code, start_date, end_date)
#'
#' }
CetesbRetrieveMetPol <- function(username, password,
                                 aqs_code, start_date,
                                 end_date, verbose = TRUE,
                                 to_csv = FALSE){

  aqs <- cetesb

  # Check if aqs_code is valid
  if (is.numeric(aqs_code) & aqs_code %in% aqs$code){
    aqs_code <- aqs_code
    aqs_name <- aqs$name[aqs$code == aqs_code]
  } else if (is.character(aqs_code) & aqs_code %in% (aqs$name)){   # nocov start
    aqs_name <- aqs_code
    aqs_code <- aqs$code[aqs$name == aqs_code]
  } else {
    stop("Wrong aqs_code value, please check cetesb_latlon or cetesb_aqs",
         call. = FALSE)
  }                                                                # nocov end

  # Adding query summary
  if (verbose){
    cat("Your query is:\n")
    cat("Parameter: TC, RH, WS, WD, Pressure,\n",
        "O3, NO, NO2, NOX, PM2.5, PM10, CO \n")
    cat("Air quality staion:", aqs_name, "\n")
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

  o3 <- CetesbRetrieve(username, password, 63,
                       aqs_code, start_date,
                       end_date, verbose = FALSE)

  no <- CetesbRetrieve(username, password, 17,
                       aqs_code, start_date,
                       end_date, verbose = FALSE)

  no2 <- CetesbRetrieve(username, password, 15,
                        aqs_code, start_date,
                        end_date, verbose = FALSE)

  nox <- CetesbRetrieve(username, password, 18,
                        aqs_code, start_date,
                        end_date, verbose = FALSE)

  pm25 <- CetesbRetrieve(username, password, 57,
                         aqs_code, start_date,
                         end_date, verbose = FALSE)

  pm10 <- CetesbRetrieve(username, password, 12,
                         aqs_code, start_date,
                         end_date, verbose = FALSE)

  co <- CetesbRetrieve(username, password, 16,
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
                         stringsAsFactors = F)
  cat(paste(
    "Download complete for", unique(all_data$aqs)
  ))

  if (to_csv){
    file_name <- paste0(aqs_name, "_", "MET_POL_",                    # nocov start
                        gsub("/", "-", start_date), "_",
                        gsub("/", "-", end_date), ".csv")
    utils::write.table(all_data, file_name, sep = ",", row.names = F)

    file_path <- paste(getwd(), file_name, sep = "/")
    cat(paste(file_path, "was created"))                            # nocov end
  }


  return(all_data)
}
