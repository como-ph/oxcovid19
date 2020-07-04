
<!-- README.md is generated from README.Rmd. Please edit that file -->

# oxcovid19: An R API to the Oxford COVID-19 Database <img src="man/figures/oxcovid19.png" width="200px" align="right" />

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![R build
status](https://github.com/como-ph/oxcovid19/workflows/R-CMD-check/badge.svg)](https://github.com/como-ph/oxcovid19/actions)
[![Codecov test
coverage](https://codecov.io/gh/como-ph/oxcovid19/branch/master/graph/badge.svg)](https://codecov.io/gh/como-ph/oxcovid19?branch=master)
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
the [CoMo
Consortium](https://www.tropicalmedicine.ox.ac.uk/news/como-consortium-the-covid-19-pandemic-modelling-in-context)
during its weekly meeting on the 1st of July 2020. During this meeting,
the [CoMo
Consortium](https://www.tropicalmedicine.ox.ac.uk/news/como-consortium-the-covid-19-pandemic-modelling-in-context)
considered the use of the OxCOVID19 Database for use in filling data and
information for country-specific parameters required in the [CoMo
Consortium](https://www.tropicalmedicine.ox.ac.uk/news/como-consortium-the-covid-19-pandemic-modelling-in-context)
model. Given that the [CoMo
Consortium](https://www.tropicalmedicine.ox.ac.uk/news/como-consortium-the-covid-19-pandemic-modelling-in-context)
model is R-centric, it makes logical sense to build an R-specific API to
connect with the [OxCOVID19](https://covid19.eng.ox.ac.uk)
[PostgreSQL](https://www.postgresql.org) database. This package aims to
facilitate the possible use of the
[OxCOVID19](https://covid19.eng.ox.ac.uk) database for this purpose
through purposefully-written functions that connects an R user to the
database directly from R (as opposed to doing a manual download of the
data or using separate tools to access
[PostgreSQL](https://www.postgresql.org)) and processes and structures
the available datasets into country-specific tables structured for the
requirements of the [CoMo
Consortium](https://www.tropicalmedicine.ox.ac.uk/news/como-consortium-the-covid-19-pandemic-modelling-in-context)
model. A direct link to the [PostgreSQL](https://www.postgresql.org) via
R is also advantageous as this is updated more frequently than the CSV
datasets made available via GitHub.

## Installation

`oxcovid19` is not yet available on CRAN.

You can install the development version of `oxcovid19` from
[GitHub](https://github.com/como-ph/oxcovid19) with:

``` r
if(!require(remotes)) install.packages("remotes")
remotes::install_github("como-ph/oxcovid19")
```

## Usage

The primary use case for the `oxcovid19` package is for facilitating a
simplified, R-based workflow for 1) connecting to the
[OxCOVID19](https://covid19.eng.ox.ac.uk)
[PostgreSQL](https://www.postgresql.org) server; 2) accessing table/s
available from the [PostgreSQL](https://www.postgresql.org) server; and,
3) querying the [PostgreSQL](https://www.postgresql.org) server with
specific parameters to customise table/s output for intended use.

The following code demonstrates this workflow:

``` r
library(oxcovid19)

## Step 1: Create a connection to OxCOVID19 PostgreSQL server
con <- connect_oxcovid19()

## Step 2: Access epidemiology table from OxCOVID19 PostgreSQL server
epi_tab <- get_table(con = con, tbl_name = "epidemiology")

## Step 3: Query the epidemiology table to show data for Great Britain
gbr_epi_tab <- dplyr::filter(.data = epi_tab, countrycode == "GBR")
```

**Step 1** and **Step 2** above are facilitated by the
`connect_oxcovid19` and the `get_table` functions provided by the
`oxcovid19` package. These functions are basically low-level wrappers to
functions in the [`DBI`](https://db.rstudio.com/dbi/) and
[`RPostgres`](https://rpostgres.r-dbi.org) packages applied specifically
to work with the [OxCOVID19](https://covid19.eng.ox.ac.uk)
[PostgreSQL](https://www.postgresql.org). These functions facilitate
convenient access to the server for general R users without having to
learn to use the `DBI` and `RPostgres` packages.

**Step 3**, on the other hand, is facilitated by the `dplyr` package
functions which were designed to work with different types of tables
including those from various database server connections such as
[PostgreSQL](https://www.postgresql.org).

The output of the workflow shown above is:

    #> # Source:   lazy query [?? x 15]
    #> # Database: postgres [covid19@covid19db.org:5432/covid19]
    #>    source date       country countrycode adm_area_1 adm_area_2 adm_area_3 tested
    #>    <chr>  <date>     <chr>   <chr>       <chr>      <chr>      <chr>       <int>
    #>  1 WRD_W… 2020-05-03 United… GBR         <NA>       <NA>       <NA>           NA
    #>  2 WRD_W… 2020-05-04 United… GBR         <NA>       <NA>       <NA>           NA
    #>  3 WRD_W… 2020-05-05 United… GBR         <NA>       <NA>       <NA>           NA
    #>  4 WRD_W… 2020-05-06 United… GBR         <NA>       <NA>       <NA>           NA
    #>  5 WRD_W… 2020-05-07 United… GBR         <NA>       <NA>       <NA>           NA
    #>  6 WRD_W… 2020-05-08 United… GBR         <NA>       <NA>       <NA>           NA
    #>  7 WRD_W… 2020-05-09 United… GBR         <NA>       <NA>       <NA>           NA
    #>  8 WRD_W… 2020-05-10 United… GBR         <NA>       <NA>       <NA>           NA
    #>  9 WRD_W… 2020-05-17 United… GBR         <NA>       <NA>       <NA>           NA
    #> 10 WRD_W… 2020-05-18 United… GBR         <NA>       <NA>       <NA>           NA
    #> # … with more rows, and 7 more variables: confirmed <int>, recovered <int>,
    #> #   dead <int>, hospitalised <int>, hospitalised_icu <int>, quarantined <int>,
    #> #   gid <chr>

The `oxcovid19` package functions are also designed to allow *pipe
operations* using the `magrittr` package. The workflow above can be done
using piped operations as follows:

``` r
## Load magrittr to use pipe operator %>%
library(magrittr)

connect_oxcovid19() %>%
  get_table(tbl_name = "epidemiology") %>%
  dplyr::filter(countrycode == "GBR")
#> # Source:   lazy query [?? x 15]
#> # Database: postgres [covid19@covid19db.org:5432/covid19]
#>    source date       country countrycode adm_area_1 adm_area_2 adm_area_3 tested
#>    <chr>  <date>     <chr>   <chr>       <chr>      <chr>      <chr>       <int>
#>  1 WRD_W… 2020-05-03 United… GBR         <NA>       <NA>       <NA>           NA
#>  2 WRD_W… 2020-05-04 United… GBR         <NA>       <NA>       <NA>           NA
#>  3 WRD_W… 2020-05-05 United… GBR         <NA>       <NA>       <NA>           NA
#>  4 WRD_W… 2020-05-06 United… GBR         <NA>       <NA>       <NA>           NA
#>  5 WRD_W… 2020-05-07 United… GBR         <NA>       <NA>       <NA>           NA
#>  6 WRD_W… 2020-05-08 United… GBR         <NA>       <NA>       <NA>           NA
#>  7 WRD_W… 2020-05-09 United… GBR         <NA>       <NA>       <NA>           NA
#>  8 WRD_W… 2020-05-10 United… GBR         <NA>       <NA>       <NA>           NA
#>  9 WRD_W… 2020-05-17 United… GBR         <NA>       <NA>       <NA>           NA
#> 10 WRD_W… 2020-05-18 United… GBR         <NA>       <NA>       <NA>           NA
#> # … with more rows, and 7 more variables: confirmed <int>, recovered <int>,
#> #   dead <int>, hospitalised <int>, hospitalised_icu <int>, quarantined <int>,
#> #   gid <chr>
```

The workflow using the piped workflow outputs the same result as the
earlier workflow but with a much streamlined use of code.

## Limitations

The `oxcovid19` package is in active development which will be dictated
by the evolution of the [OxCOVID19
Database](http://covid19.eng.ox.ac.uk/) over time. Whilst every attempt
will be employed to maintain syntax of current functions, it is possible
that current functions may change syntax or operability in order to
ensure relevance or maybe deprecated in lieu of a more appropriate
and/or more performant function. In either of these cases, any change
will be well-documented and explained to users and deprecation will be
staged in such a way that users will be informed in good time to allow
for transition to using the new functions.
