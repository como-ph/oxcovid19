################################################################################
#
#'
#' Get specified table from OxCOVID19 Database
#'
#' @param con Connection to **OxCOVID19 Database**. This can be specified using
#'   the [connect_oxcovid19()] function.
#' @param tbl_name Name of table available in **OxCOVID19 Database**. Should be
#'   one of the table names given by a call to [list_tables()].
#' @param tbl_names Name of tables available in **OxCOVID19 Database**. Should
#'   be a character vector of names of tables found in the table names given by
#'   a call to [list_tables()].
#'
#' @return For [get_table()], an `RPostgres_tbl` object of the specified
#'   **OxCOVID19 Database** table. For [get_tables()], an `RPostgres_tbl` object
#'   containing a named list of the specified **OxCOVID19 Database** tables.
#'
#' @author Ernest Guevarra
#'
#' @examples
#' ## Create a connection to OxCOVID19 Database
#' con <- connect_oxcovid19()
#'
#' ## Get epidemiology table
#' get_table(con = con, tbl_name = "epidemiology")
#'
#' ## Get epidemiology and weather tables
#' get_tables(con = con, tbl_names = c("epidemiology", "weather"))
#'
#' @rdname get_table
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


################################################################################
#
#'
#' @rdname get_table
#' @export
#'
#
################################################################################

get_tables <- function(con, tbl_names) {
  ## Check that all of tbl_names are available from PostgreSQL server
  if(all(!tbl_names %in% list_tables())) {
    stop(paste(paste(tbl_names, collapse = ", "),
               "table/tables is/are not available from OxCOVID19 Database. Please try again.",
               sep = ""),
         call. = TRUE)
  }

  ## Check that some of tbl_names are available from PostgreSQL server
  if(!all(tbl_names %in% list_tables())) {
    warning(paste("Only ",
                  paste(tbl_names[tbl_names %in% list_tables()],
                        collapse = ", "),
                  "table/tables is/are available from OxCOVID19 Database.",
                  sep = ""))
  }

  ## Connect to specified table names
  tabs <- lapply(X = tbl_names, FUN = dplyr::tbl, src = con)

  ## Return tabs
  return(tabs)
}

