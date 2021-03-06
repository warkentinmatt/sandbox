#' @title Broom tidiers for Fine and Gray models.
#'
#' @description Tidy summarizes information about the components of a model. A model component might be a single term in a regression, a single hypothesis, a cluster, or a class. Exactly what tidy considers to be a model component varies cross models but is usually self-evident. If a model has several distinct types of components, you will need to specify which components to return.
#'
#' @param x A \code{FGR} object created by \code{\link[riskRegression]{FGR}}
#' @param conf.int Logical indicating whether or not to include a confidence interval in the tidied output. Defaults to FALSE.
#' @param conf.level The confidence level to use for the confidence interval if conf.int = TRUE. Must be strictly greater than 0 and less than 1. Defaults to 0.95, which corresponds to a 95 percent confidence interval.
#' @param exponentiate Logical indicating whether or not to exponentiate the the coefficient estimates. This will return sub-hazard ratios (SHR). Defaults to FALSE.
#' @param quick Logical indiciating if the only the term and estimate columns should be returned. Often useful to avoid time consuming covariance and standard error calculations. Defaults to FALSE.
#' @param ... Additional arguments. Not used. Needed to match generic signature only. Cautionary note: Misspelled arguments will be absorbed in ..., where they will be ignored. If the misspelled argument has a default value, the default value will be used. For example, if you pass conf.lvel = 0.9, all computation will proceed using conf.level = 0.95. Additionally, if you pass newdata = my_tibble to an augment() method that does not accept a newdata argument, it will use the default value for the data argument.
#'
#' @details If you have missing values in your model data, you may need to refit the model with na.action = na.exclude.
#'
#' @return A \code{\link[tibble]{tibble}} with one row for each term in the regression. The tibble has columns:
#'
#' \itemize{
#' \item \code{term} The name of the regression term.
#' \item \code{estimate} The name of the regression term.
#' \item \code{std.error} The name of the regression term.
#' \item \code{statistics} The name of the regression term.
#' \item \code{p.value} The name of the regression term.
#' \item \code{conf.low} The name of the regression term.
#' \item \code{conf.high} The name of the regression term.
#' }
#'
#' @seealso
#'
#' Other \code{FGR} tidiers: \code{glance.FGR}, \code{augment.FGR}
#'
#' @examples
#' \dontrun{
#' library(riskRegression)
#' sim.data <- sampleData(50, outcome = 'competing.risks')
#' fgr.model <- FGR(Hist(time, event) ~ X10, data = sim.data, cause = 1)
#' #tidy(fgr.model)
#' #glance(fgr.model)
#' #augment(fgr.model)
#' }
#'

tidy.FGR <- function(x, conf.int = FALSE,
                     conf.level = 0.95,
                     exponentiate = FALSE, quick, ...) {
  coefs <- coef_FGR(x)
  var <- vcov_FGR(x)
  summ <- summary_FGR(x, conf.level)

  tidy_FGR <- tibble::tibble(
    term = names(coefs),
    estimate = coefs,
    std.error = summ$coef[, 'se(coef)'],
    statistic = summ$coef[, 4],
    p.value = summ$coef[, 'p-value'])

  if (conf.int){
    cis <- tibble::tibble(
      conf.low = log(summ$conf.int[, 3]),
      conf.high = log(summ$conf.int[, 4]))
    tidy_FGR <- bind_cols(tidy_FGR, cis)
    tidy_FGR
  } else {
    tidy_FGR
  }

  if (exponentiate && conf.int) {
    tidy_FGR$estimate <- exp(tidy_FGR$estimate)
    tidy_FGR$conf.low <- exp(tidy_FGR$conf.low)
    tidy_FGR$conf.high <- exp(tidy_FGR$conf.high)
    tidy_FGR
  } else if (exponentiate) {
    tidy_FGR$estimate <- exp(tidy_FGR$estimate)
    tidy_FGR
  } else {
    tidy_FGR
  }

  return(tidy_FGR)
}

coef_FGR <- function(obj) {
  coefs <- purrr::chuck(obj, 'crrFit', 'coef')
  coefs
}

vcov_FGR <- function(obj) {
  var <- purrr::chuck(obj, 'crrFit', 'var')
  var
}

summary_FGR <- function(obj, conf.int = conf.level){
  sum_FGR <- summary(obj, conf.int)
  sum_FGR
}
