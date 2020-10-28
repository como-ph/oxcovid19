################################################################################
#
#'
#' An R API to the Oxford COVID-19 Database
#'
#' The [OxCOVID19 Project](https://covid19.eng.ox.ac.uk) aims to increase
#' our understanding of the COVID-19 pandemic and elaborate possible strategies
#' to reduce the impact on the society through the combined power of statistical,
#' mathematical modelling, and machine learning techniques. **The OxCOVID19**
#' **Database** is a large, single-centre, multimodal relational database
#' consisting of information (using acknowledged sources) related to COVID-19
#' pandemic. This package provides an R-specific interface to the
#' **OxCOVID19 Database** based on widely-used data handling and manipulation
#' approaches in R.
#'
#' @docType package
#' @keywords internal
#' @name oxcovid19
#' @importFrom DBI dbConnect dbListTables dbListFields
#' @importFrom RPostgres Postgres
#' @importFrom dplyr tbl mutate collect filter select
#' @importFrom dbplyr remote_name remote_src remote_con remote_query
#'   remote_query_plan
#' @importFrom sf st_read
#' @importFrom lubridate ymd
#' @importFrom countrycode countryname
#' @importFrom magrittr %>%
#'
#
################################################################################
"_PACKAGE"

## quiets concerns of R CMD check re: data_sources
if(getRversion() >= "2.15.1")  utils::globalVariables(c("data_sources",
                                                        "tbl_name",
                                                        "adm_area_1",
                                                        "adm_area_2",
                                                        "adm_area_3",
                                                        "Source code",
                                                        "Table",
                                                        "Source",
                                                        "Terms of Use"))
