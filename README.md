
<!-- README.md is generated from README.Rmd. Please edit that file -->

# oxcovid19: An R API to the Oxford COVID-19 Database <img src="man/figures/oxcovid19.png" width="200px" align="right" />

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

The [OxCOVID19 Project](https://covid19.eng.ox.ac.uk) aims to increase
our understanding of the COVID-19 pandemic and elaborate possible
strategies to reduce the impact on the society through the combined
power of statistical, mathematical modelling, and machine learning
techniques. The [OxCOVID19 Database](https://covid19.eng.ox.ac.uk) is a
large, single-centre, multimodal relational database consisting of
information (using acknowledged sources) related to COVID-19 pandemic.
This package provides an R-specific interface to the [OxCOVID19
Database](https://covid19.eng.ox.ac.uk) based on widely-used data
handling and manipulation approaches in R.

## Motivation

The [OxCOVID19 Project](https://covid19.eng.ox.ac.uk) team presented to
the CoMo Consortium during its weekly meeting on the 1st of July 2020.
During this meeting, the CoMo Consortium considered the use of the
OxCOVID19 Database for use in filling data and information for
country-specific parameters required in the CoMo Consortium model. Given
that the CoMo Consortium model is R-centric, it makes logical sense to
build an R-specific API to connect with the OxCOVID19 PostgreSQL
database. This package aims to facilitate the possible use of the
OxCOVID19 database for this purpose through purposefully-written
functions that connects an R user to the database directly from R (as
opposed to doing a manual download of the data or using separate tools
to access PostgreSQL) and processes and structures the available
datasets into country-specific tables structured for the requirements of
the CoMo Consortium model. A direct link to the PostgreSQL via R is also
advantageous as this is updated more frequently than the CSV datasets
made available via GitHub.

## Installation

`oxcovid19` is not yet available on CRAN.

You can install the development version of `oxcovid19` from
[GitHub](https://github.com/como-ph/oxcovid19) with:

``` r
if(!require(remotes)) install.packages("remotes")
remotes::install_github("como-ph/oxcovid19")
```

## Usage
