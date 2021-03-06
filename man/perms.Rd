% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/perm-test-funs.R
\name{perms}
\alias{perms}
\title{Permutation Resampling}
\usage{
perms(
  data = NULL,
  ...,
  strata = NULL,
  times = 25,
  apparent = FALSE,
  seed = NULL
)
}
\arguments{
\item{data}{A data frame.}

\item{...}{Column names in \code{data} to permute/shuffle; or one of the \code{\link[tidyselect]{select_helpers}}.}

\item{strata}{A discrete varible for stratified permutations.}

\item{times}{Number of permutations.}

\item{apparent}{A \code{logical}. Should a copy of the input \code{data} be returned?}

\item{seed}{A numeric value used to set the RNG seed for reproducible permutations.}
}
\value{
A data frame (\code{\link{tibble}}) where each row is a permuted version of the input data. The returned data frame has the added class \code{perms} which can be used by the \code{summary} generic for S3 methods dispatch.
}
\description{
A function for generating permuted datasets; where one can permute as many columns as desired. Stratified (i.e. group-based) shuffling can be achieved by specifying a column name for the \code{strata} argument. See details for a more complete description and guidance on usage.
}
\details{
This function was motivated by the \code{rsample} package which allows straightforward implementation of several common resampling methods (e.g. boostrap, K-fold crossvalidation). While the internal mechanisms of this function are quite different, the goal is to provide a function that works like rsample for permuted data. This function works well with the pipe. See \code{\link{magrittr}} for more details.

After using \code{perms}, one can compute permutation-based P-values or other statistics using any function, including custom functions, in a concise manner. The syntax and usage of this function is motivated by the \code{tidy eval} principles. Thus, you specify both the names of the columns to permute and the stratitfying variable as bare column names, not quoted names. The default number of permutations is aligned with the default number of bootstraps for \code{rsample::bootstraps}.

This function allows for easy integration with \code{\link[purrr]{map}} functions for functional programming. See the examples for a use-case. Also, consider the using \code{\link[furrr]{future_map}} equivalents for parallel computations.
}
\examples{
iris \%>\%
  perms(Sepal.Length)

iris \%>\%
  perms(Sepal.Width, Sepal.Length) \%>\%
  dplyr::mutate(cor = purrr::map_dbl(data, ~with(., cor(Sepal.Width, Sepal.Length))))

}
