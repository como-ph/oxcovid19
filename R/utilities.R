################################################################################
#
#'
#' List out names of tables available from OxCOVID19 Database
#'
#' @param con A PqConnection class object specifying the PostgreSQL connection
#'   to OxCOVID19 Database. This is produced by \code{connect_covid19}
#'   function
#'
#' @return A vector of table names available from OxCOVID19 Database
#'
#' @author Ernest Guevarra
#'
#' @examples
#' list_tables()
#'
#' @export
#'
#
################################################################################

list_tables <- function(con = connect_oxcovid19()) {
  ## Extract table names
  tabList <- DBI::dbListTables(conn = con)

  ## Return table names
  return(tabList)
}


################################################################################
#
#'
#' List out field names of specific tables available from OxCOVID19 Database
#'
#' @param con A PqConnection class object specifying the PostgreSQL connection
#'   to OxCOVID19 Database. This is produced by \code{connect_covid19}
#'   function
#' @param tab A character vector specifying table name/s to extract field names
#'   from. Must be a value included when a call to \code{list_names} is issued.
#'   Default is character vector of all table names specified by
#'   \code{list_names}.
#'
#' @return A named list of field names per specified table available from
#'   OxCOVID19 Database
#'
#' @author Ernest Guevarra
#'
#' @examples
#' list_fields()
#'
#' @export
#'
#
################################################################################

list_fields <- function(con = connect_oxcovid19(),
                        tab = list_tables()) {
  ## Create concatenating list
  fieldList <- vector(mode = "list", length = length(tab))
  names(fieldList) <- tab

  ## Cycle through selected tables
  for(i in tab) {
    ## Extract field names of current table
    fieldList[[i]] <- DBI::dbListFields(conn = con, name = i)
  }

  ## Return list of field names
  return(fieldList)
}
