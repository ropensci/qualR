#' Internal function - Check if CETESB AQS code or name is valid
#'
#' @param aqs data frame with cetesb aqs code and names
#' @param aqs_code user's input code or name
#'
#' @keywords internal

CheckCetesbCode <- function(aqs, aqs_code){
  if (is.numeric(aqs_code) & aqs_code %in% aqs$code){
    aqs_code <- aqs_code
    aqs_name <- aqs$name[aqs$code == aqs_code]
  } else if (is.character(aqs_code) & aqs_code %in% aqs$name){
    aqs_name <- aqs_code
    aqs_code <- aqs$code[aqs$name == aqs_code]
  } else if (is.character(aqs_code) & aqs_code %in% aqs$ascii){
    aqs_name <- aqs$name[aqs_code == aqs$ascii]
    aqs_code <- aqs$code[aqs$ascii == aqs_code]
  } else {
    stop("Wrong aqs_code value or aqs name, please check cetesb_aqs",
         call. = FALSE)
  }
  aqs_code_name <- c(aqs_name, aqs_code)
  return(aqs_code_name)
}
