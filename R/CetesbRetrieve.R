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
#'
#' @return data.frame with the selected parameter information
#' @export
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
                           start_date, end_date){

  aqs <- cetesb
  aqs_name <- aqs$name[aqs$code == aqs_code]

  curl = RCurl::getCurlHandle()
  RCurl::curlSetOpt(cookiejar = 'cookies.txt', followlocation = TRUE, autoreferer = TRUE, curl = curl)

  url  <- "https://qualar.cetesb.sp.gov.br/qualar/autenticador"

  # To actually log in in the site 'style = "POST" ' seems mandatory
  RCurl::postForm(url, cetesb_login = username, cetesb_password = password,
                  style = "POST", curl = curl)


  url2 <-"https://qualar.cetesb.sp.gov.br/qualar/exportaDados.do?method=pesquisar"

  # Start the query
  ask  <- RCurl::postForm(url2,
                          irede = 'A',
                          dataInicialStr = start_date,
                          dataFinalStr   =  end_date,
                          iTipoDado = 'P',
                          estacaoVO.nestcaMonto = aqs_code,
                          parametroVO.nparmt = pol_code,
                          style = 'POST',
                          curl = curl)
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
    dat <- data.frame(date = all.dates$date , pol = NA, aqs = aqs_name,
                      stringsAsFactors = F)
    print('No data')
  } else if (ncol(dat) == 19) {
    names(dat) <- cet.names
    dat$date <- paste(dat$day, dat$hour, sep = '_')
    dat$date <- as.POSIXct(strptime(dat$date, format = '%d/%m/%Y_%H:%M'),
                           tz = 'UTC')
    dat$value <- as.numeric(gsub(",", ".", gsub("\\.", "", dat$value)))
    dat <- dat[dat$test == 'Sim', ]
    dat <- merge(all.dates, dat, all = T)

    if (nrow(dat) != nrow(all.dates)){
      print(paste0('Dates missmatch ', unique(stats::na.omit(dat$est))))
      print('Duplicated date in ',dat$date[duplicated(dat$date)])
      dat <- data.frame(date = dat$date , pol = dat$value, aqs = aqs_name,
                        stringsAsFactors = F)
    } else {
      print(paste0('Download OK ', unique(stats::na.omit(dat$pol))))
      dat <- data.frame(date = all.dates$date , pol = dat$value , aqs = aqs_name,
                        stringsAsFactors = F)
    }

  }

  if (file.exists("cookies.txt")){
    file.remove("cookies.txt")
  }



  return(dat)
}
