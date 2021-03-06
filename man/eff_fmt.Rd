% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/relative-effect-format.R
\name{eff_fmt}
\alias{eff_fmt}
\title{Effect Size Formatter}
\usage{
eff_fmt(
  effect,
  se = NULL,
  level = 0.95,
  lci = NULL,
  uci = NULL,
  sep = "-",
  round = 2L
)
}
\arguments{
\item{effect}{Effect estimate.}

\item{se}{Standard error.}

\item{level}{Confidence level. Default is 0.95.}

\item{lci}{Confidence bound, lower.}

\item{uci}{Confidence bound, higher.}

\item{sep}{Character separator.}

\item{round}{Number of digits to round to. Default is 2.}
}
\value{
Character vector of formatted data. Same length as \code{effect}.
}
\description{
Formats text as effect sizes plus confidence intervals for tabular presentation.
}
\details{
One of \code{se} or \code{lci}/\code{uci} must be specificed, but not both, and must be the same length vectors as \code{effect}, or length 1 (recycled to be the same length as \code{effect}). If both are provided, the confidence intervals will be computed using the standard error and \code{level}.
}
\examples{

set.seed(12345)
eff_fmt(rnorm(10), se = 0.1)
eff_fmt(rnorm(10), se = 0.1, round = 4L, level = 0.99)

}
