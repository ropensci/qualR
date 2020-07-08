#' CETESB AQS stations.
#'
#' List of CETESB air quality stations (AQS) with their codes in
#' CETESB QUALAR system. Use this to check the aqs_code parameter.
#' AQS names are without diacritics.
#'
#' @format A data frame with two variables: \code{name} and \code{code}
#'   of AQS.
"cetesb_aqs"

#' CETESB Parameters
#'
#' List of CETESB QUALAR available parameters. Use this to check the
#' pol_code parameter.
#' Parameter names are without diacritics.
#'
#' @format A data frame with 2 variables: \code{name} and \code{code}
#'   of parameter.
"cetesb_param"

#' CETESB AQS station latitude and longitude
#'
#' List of CETESB QUALAR AQS latitudes and longitudes. Use this to check the
#' AQS location, if you need to make some maps. AQS names contains diacritics.
#'
#'
#' @format A data frame with 4 variables: \code{name} , \code{code}, \code{lat}, and
#' \code{latitude} of AQS.
"cetesb_latlon"

