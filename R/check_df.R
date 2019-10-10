#' @title Check data frame
#'
#' @description check.df examines if a given data.frame has required columns corresponding to required classes.
#'
#' @param x The data.frame to be checked.
#' @param column.names	character containing required column names
#' @param column.conv character containing conversion functions that should return TRUE for check to pass
#' @param min.rows integer specifying minimum number of rows of x
#' @return The function returns a logical, whose value indicates pass (TRUE) or fail (FALSE).
#' @examples check.df(test.table, column.names = c("caseid", "age", "nh", "em", "aj"), column.conv = c("as.character", "as.integer", "as.logical", "as.logical", "as.logical"))
#' @export check.df
#' @author Johannes Elias

check.df <- function(x, column.names, column.conv = rep("as.character", length(column.names)), min.rows = 1) {
  # Define logical result variable
  ok <- TRUE

  # Start with some easy checks
  if (length(column.names) != length(column.conv)) stop("'column.names' must be of same length as 'column.conv'")
  if (!is.data.frame(x)) ok <- FALSE
  if (!all(column.names %in% colnames(x))) ok <- FALSE
  if (nrow(x) < min.rows) ok <- FALSE

  # Proceed with checking the columns
  for (i in 1:length(column.conv)) {
    if (!ok) break
    tryCatch({
      txt <- paste(column.conv[i], "(x[, ", i, "])", sep = "")
      eval(parse(text = txt))
    },
    error = function(x) { ok <<- FALSE },
    warning = function(xx) { ok <<- FALSE })
  }

  # Return result
  return(ok)
}
