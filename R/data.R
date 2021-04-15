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
#' List of CETESB QUALAR available parameters and units. Use this to check the
#' pol_code parameter.
#' Parameter names are without diacritics.
#'
#' @format A data frame with 3 variables: \code{name}, \code{units}, and \code{code}
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

#' Monitor Ar AQS stations.
#'
#' List of Monitor Ar Rio air quality stations (AQS) with their codes
#' and locations. Use this to check the aqs_code parameter in
#' MonitorArRetrieve() function.
#'
#' @format A data frame with 6 variables: \code{name}, \code{code}, \code{lon}, \code{lat},
#' \code{X_UTM_Sirgas2000}, and  \code{Y_UTM_Sirgas2000}
#'   of AQS.
"monitor_ar_aqs"

#' Monitor Ar Parameters
#'
#' List of Monitor Ar Rio available parameters. Use this to check the
#' param parameter of MonitorArRetrieve() function .
#'
#' @format A data frame with 3 variables: \code{code}, \code{name}, and \code{units}
#'   of parameter.
"monitor_ar_param"
