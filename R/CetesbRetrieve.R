#' Download a single parameter from CETESB QUALAR system
#'
#' This function download one parameter from one air quality stations (AQS)
#' of CETESB AQS network. It will pad out the date with missing data with NA.
#'
#' @param username User name of CETESB QUALAR
#' @param password User name's password of CETESB QUALAR
#' @param pol_code Code of parameter
#' @param aqs_code Code of AQS
#' @param start_date Date to start downloading in dd/mm/yyyy
#' @param end_date Date to end downloading in dd/mm/yyyy
#' @param verbose Print query summary
#' @param to_csv  Creates a csv file. FALSE by default
#'
#' @return data.frame with the selected parameter information
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' # Downloading Ozone information from Pinheiros AQS
#' # from January first to 7th of 2020
#' my_user_name <- "John Doe"
#' my_pass_word <- "drowssap"
#' o3_code <- 63  # Check with cetesb_param
#' pin_code <- 99 # Check with cetesb_aqs
#' start_date <- "01/01/2020"
#' end_date <- "07/01/2020"
#'
#' pin_o3 <- CetesbRetrieve(my_user_name, my_pass_word, o3_code, pin_code, start_date, end_date)
#'
#' }
CetesbRetrieve <- function(username, password,
                           pol_code, aqs_code,
                           start_date, end_date,
                           verbose = TRUE, to_csv = FALSE){

  # Renaming dataframes
  aqs <- cetesb
  pols <- params

  # Check if pol_code is valid
  if (is.numeric(pol_code) & pol_code %in% pols$code){
    pol_code <- pol_code
  } else if (is.character(pol_code) & toupper(pol_code) %in% (params_code$name)){ # nocov start
    pol_code <- params_code$code[params_code$name == toupper(pol_code)]
  } else {
    stop("Wrong pol_code value, please check cetesb_param",
         call. = FALSE)
  }                                                                               # nocov end

  # Getting full pollutant name
  pol_name <- pols$name[pols$code == pol_code]
  pol_abr <- params_code$name[params_code$code == pol_code]

  # Getting aqs_name in ascii
  aqs_name <- aqs$ascii[aqs$code == aqs_code]

  # Adding query summary
  if (verbose){
    cat("Your query is:\n")                                                       # nocov
    cat("Parameter:", pol_name, "\n")                                             # nocov
    cat("Air quality staion:", aqs_name, "\n")                                    # nocov
    cat("Period: From", start_date, "to", end_date, "\n")                         # nocov
  }


  # Logging to CETESB QUALAR
  log_params <- list(
    cetesb_login = username,
    cetesb_password = password
  )

  url_log  <- "https://qualar.cetesb.sp.gov.br/qualar/autenticador"
  log_qualar <- httr::POST(url_log, body = log_params, encode = "form")

  # Downloading data from Air quality stations
  url_aqs <-"https://qualar.cetesb.sp.gov.br/qualar/exportaDados.do?method=pesquisar"

  aqs_params  <- list(irede = 'A',
                      dataInicialStr = start_date,
                      dataFinalStr   =  end_date,
                      iTipoDado = 'P',
                      estacaoVO.nestcaMonto = aqs_code,
                      parametroVO.nparmt = pol_code)

  ask <- httr::POST(url_aqs, body = aqs_params, encode = "form")

  # Transforming query to dataframe
  pars <- XML::htmlParse(ask, encoding = "UTF-8") # 'Encoding "UTF-8", preserves special characteres
  tabl <- XML::getNodeSet(pars, "//table")
  dat  <- XML::readHTMLTable(tabl[[2]], skip.rows = 1, stringsAsFactors = F)

  # Creating a complete date data frame to merge and to pad out with NA
  end_date2  <- as.character(as.Date(end_date, format = '%d/%m/%Y') + 1)
  all.dates <- data.frame(
    date = seq(
      as.POSIXct(strptime(start_date, format = '%d/%m/%Y'),
                 tz = 'UTC'),
      as.POSIXct(strptime(end_date2, format = '%Y-%m-%d'),
                 tz = 'UTC'),
      by = 'hour'
    )
  )

  # These are the columns of the html table
  cet.names <- c('emp1', 'red', 'mot', 'type', 'day', 'hour', 'cod', 'est',
                 'pol', 'unit', 'value', 'mov','test', 'dt.amos', 'dt.inst',
                 'dt.ret', 'con', 'tax', 'emp2')

  # In case there is no data
  if (ncol(dat) != 19){
    dat <- data.frame(date = all.dates$date , pol = NA, aqs = aqs_name,     # nocov
                      stringsAsFactors = F)                                 # nocov
    cat(paste0('No data available for ', pol_name), "\n")                       # nocov
  } else if (ncol(dat) == 19) {
    names(dat) <- cet.names
    dat$date <- paste(dat$day, dat$hour, sep = '_')
    dat$date <- as.POSIXct(strptime(dat$date, format = '%d/%m/%Y_%H:%M'),
                           tz = 'UTC')
    dat$value <- as.numeric(gsub(",", ".", gsub("\\.", "", dat$value)))
    dat <- dat[dat$test == 'Sim', ]
    dat <- merge(all.dates, dat, all = T)

    if (nrow(dat) != nrow(all.dates)){
      cat(paste0('Dates missmatch ', unique(stats::na.omit(dat$est))), "\n")    # nocov
      cat('Duplicated date in ',dat$date[duplicated(dat$date)], "\n")           # nocov
      dat <- data.frame(date = dat$date , pol = dat$value, aqs = aqs_name,  # nocov
                        stringsAsFactors = F)                               # nocov
    } else {
      cat(paste0('Download OK ', pol_abr), "\n")
      dat <- data.frame(date = all.dates$date , pol = dat$value , aqs = aqs_name,
                        stringsAsFactors = F)
    }
  }

  if (to_csv){
    WriteCSV(dat, aqs_name, start_date, end_date, pol_abr) # nocov
  }

  return(dat)
}
