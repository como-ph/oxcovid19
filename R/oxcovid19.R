################################################################################
#
#'
#' An R API to the Oxford COVID-19 Database
#'
#' The OxCOVID19 Project \url{https://covid19.eng.ox.ac.uk} aims to increase
#' our understanding of the COVID-19 pandemic and elaborate possible strategies
#' to reduce the impact on the society through the combined power of statistical,
#' mathematical modelling, and machine learning techniques. The OxCOVID19
#' Database is a large, single-centre, multimodal relational database consisting
#' of information (using acknowledged sources) related to COVID-19 pandemic.
#' This package provides an R-specific interface to the OxCOVID19 Database based
#' on widely-used data handling and manipulation approaches in R.
#'
#' @docType package
#' @keywords internal
#' @name oxcovid19
#' @importFrom DBI dbConnect dbListTables dbListFields
#' @importFrom RPostgres Postgres
#' @importFrom dplyr tbl
#' @importFrom sf st_read
#'
#
################################################################################
"_PACKAGE"
