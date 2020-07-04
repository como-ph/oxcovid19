################################################################################
#
#'
#' Get specified table from OxCOVID19 Database
#'
#' @param con Connection to OxCOVID19 Database. This can be specified using
#'   the \code{connect_oxcovid19} function.
#' @param tbl_name Name of table available in OxCOVID19 Database. Should be
#'   one of the table names given by a call to \code{list_tables}.
#'
#' @return An RPostgres_tbl object of the specified OxCOVID19 Database table
#'
#' @examples
#' con <- connect_oxcovid19()
#' get_table(con = con, tbl_name = "epidemiology")
#'
#' @export
#'
#
################################################################################

get_table <- function(con, tbl_name) {
  ##
  dplyr::tbl(src = con, tbl_name)
}

################################################################################
#
#'
#'
#'
#'
#'
#
################################################################################

query_table <- function(tbl,
                        field = NULL,
                        query = NULL) {
  ##

  ##
  tbl
}
