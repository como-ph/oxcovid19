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
#' Get specified spatial layer from OxCOVID19 Database
#'
#' @param con Connection to OxCOVID19 Database. This can be specified using
#'   the \code{connect_oxcovid19} function.
#' @param layer Name of spatial layer available in OxCOVID19 Database.
#'   Currently, only \code{administrative_division} is a spatial layer.
#' @param ccode Three character ISO country code for required country
#'   layers
#' @param adm Numeric value for administrative level layer required.
#'
#' @return An object of \code{sf} class of the specified spatial layer
#'
#' @examples
#' con <- connect_oxcovid19()
#' get_layer(con = con, ccode = "CHN", adm = 1)
#'
#' @export
#'
#
################################################################################

get_layer <- function(con,
                      layer = "administrative_division",
                      ccode, adm) {

  ## Read spatial layer given query
  layer <- sf::st_read(dsn = con,
                       query = paste("select * from ", layer,
                                     " where countrycode='", ccode,
                                     "' and adm_level=", adm, ";",
                                     sep = ""))

  ## Return layer
  return(layer)
}
