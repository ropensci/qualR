#' CETESB AQS station latitude and longitude
#'
#' List of CETESB QUALAR air quality stations (AQS) latitudes and longitudes.
#' Use this to check the AQS \code{aqs_code} argument in CetesbRetrieveParam()
#' function. AQS names are without diacritics.
#'
  #' @format A data frame with 74 observations and 5 variables:
#' \describe{
#' \item{name}{CETESB AQS name.}
#' \item{code}{CETESB AQS code in QUALAR System.}
#' \item{lat}{CETESB AQS latitude.}
#' \item{lon}{CETESB AQS longitude.}
#' \item{loc}{CETESB AQS location.}
#' }
#' @examples
#' cetesb_aqs
"cetesb_aqs"

#' CETESB Parameters
#'
#' List of CETESB QUALAR available parameters and units. Use this to check the
#' \code{parameters} argument.
#' Parameter names are without diacritics.
#'
#' @format A data frame with 20 observations and 3 variables:
#' \describe{
#' \item{name}{CETESB QUALAR parameter abbreviation and name.}
#' \item{units}{Parameter units.}
#' \item{code}{Parameter CETESB QUALAR code.}
#' }
#' @examples
#' cetesb_param
"cetesb_param"

#' Monitor Ar AQS stations.
#'
#' List of Monitor Ar Rio air quality stations (AQS) with their codes
#' and locations. Use this to check the parameters argument in
#' MonitorArRetrieveParam() function.
#'
#' @format A data frame with 8 observation and 6 variables:
#' \describe{
#' \item{name}{MonitorAr Program AQS name.}
#' \item{code}{MonitorAr Program AQS abbreviation.}
#' \item{lon}{MonitorAr Program AQS longitude.}
#' \item{lat}{MonitorAr Program AQS latitude.}
#' \item{x_utm_sirgas2000}{MonitorAr Program AQS longitude in SIRGAS 2000
#'  (EPSG:31983).}
#' \item{y_utm_sirgas2000}{MonitorAr Program AQS latitude in SIRGAS 2000
#'  (EPSG:31983).}
#' }
#' @examples
#' monitor_ar_aqs
"monitor_ar_aqs"

#' Monitor Ar Parameters
#'
#' List of Monitor Ar Rio available parameters. Use this to check the
#' parameters argument in MonitorArRetrieveParam() function.
#' Parameter names are without diacritics.
#'
#' @format A data frame with 18 observations and 3 variables:
#' \describe{
#' \item{code}{MonitorAr parameter abbreviation or code.}
#' \item{name}{MonitorAr parameter name}
#' \item{units}{Parameter units.}
#' }
#' @examples
#' monitor_ar_param
"monitor_ar_param"
