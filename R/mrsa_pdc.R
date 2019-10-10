#' @title Prevalence dependent calibration of a model predicting probability of MRSA carriage and diagnostic test PPV
#'
#' @description mrsa.pdc exposes a prevalence adjusted model which predicts probability of MRSA carriage positive predictive value (PPV) of a diagnostic test with known specificity and sensitivity.
#'
#' @param tb A data.frame with the five columns 'caseid', 'age', 'nh', 'em', and 'aj'. Columns have to be of classes 'character', 'integer', 'logical', 'logical', and 'logical', respectively.
#' @param prev prevalence of MRSA, numeric ranging from 0 to 1
#' @param spec specificity of diagnostic test, numeric ranging from 0 to 1
#' @param sens sensitivity of diagnostic test, numeric ranging from 0 to 1
#' @return The function returns data.frame tb with columns 'p' and 'PPV', corresponding to probability of MRSA carriage and estimated PPV of the diagnostic test, respectively, attached.
#' @examples mrsa.pdc(test.table, .02, .98, .99)
#' @export mrsa.pdc
#' @author Johannes Elias
#' @note The underlying model was used in an article by Elias et al (2013), available at https://doi.org/10.1186/1471-2334-13-111

mrsa.pdc <- function(tb,
                     prev,
                     spec,
                     sens) {
  # Table check
  if (!inherits(tb, "data.frame")) stop("Argument 'tb' is not a data.frame object. Pleas supply a data.frame.")
  ok <- check.df(tb, column.names = c("caseid", "age", "nh", "em", "aj"),
                 column.conv = c("as.character", "as.integer", "as.logical", "as.logical", "as.logical"))
  if (!ok)
    stop("The table does not contain the required columns. Please supply a data.frame with the five columns 'caseid', 'age', 'nh', 'em', and 'aj'. Additionally, columns have to be of classes 'character', 'integer', 'logical', 'logical', and 'logical', respectively.")

  # check other arguments
  for (a in c(prev, spec, sens))
    if (a < 0 | a > 1)
      stop("At least one of the supplied parameters is out of range. Arguments 'prev', 'sens', and 'spec' have to be numeric values ranging from 0 to 1.")

  # convert entries in table
  tb$caseid <- as.character(tb$caseid)
  tb$age <- as.integer(as.character(tb$age))
  tb[, c("nh", "aj", "em")] <- as.logical(as.numeric(as.character(unlist(tb[, c("nh", "aj", "em")]))))

  # f equals to (1 - spec)/sens and is needed below
  f <- ifelse((sens > 0 & sens <= 1) & (spec > 0 & spec <= 1), (1 - spec)/sens, 0)

  # predict p and ppv and amend table tb
  L <- pdc.d2L(tb) + pdc.corr.L(prev)
  tb$p <- plogis(L)
  if (f == 0) {
    tb$PPV <- pdc.L2ppv(L)
  } else {
    tb$PPV <- pdc.nlsfunL(L, f)
  }

  # return amended table
  return(tb)
}
