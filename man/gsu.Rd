% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dplyr-add-ons.R
\name{gsu}
\alias{gsu}
\title{Group, slice, and ungroup again.}
\usage{
gsu(.data, ..., .slices = 1)
}
\arguments{
\item{.data}{Data frame.}

\item{...}{Unquoted grouping columns.}

\item{.slices}{Vector of slice numbers.}
}
\value{
An object with the same class as .data.
}
\description{
Short-hand function to group data, slice within groupings, and ungroup.
}
\examples{

iris \%>\%
  gsu(Species, .slices = c(1, 5, 10))

}
