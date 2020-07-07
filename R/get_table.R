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
#' @author Ernest Guevarra
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
  ## Check that tbl_name is available from PostgreSQL server
  if(!tbl_name %in% list_tables()) {
    stop(paste(tbl_name, " is not available from OxCOVID19 Database. Please try again.", sep = ""),
         call. = TRUE)
  }

  ## Connect to specified table name
  tab <- dplyr::tbl(src = con, tbl_name)

  ## Return tab
  return(tab)
}

