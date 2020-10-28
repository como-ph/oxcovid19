################################################################################
#
#'
#' Get specified spatial layer from OxCOVID19 Database
#'
#' @param con Connection to **OxCOVID19 Database**. This can be specified using
#'   the [connect_oxcovid19()] function.
#' @param layer Name of spatial layer available in **OxCOVID19 Database**.
#'   Currently, only `administrative_division` is a spatial layer.
#' @param ccode Three character ISO country code for required country
#'   layers.
#' @param adm Numeric value for administrative level layer required. Possible
#'   values are 0 for whole country, 1 for administrative level 1, 2 for
#'   administrative level 2 and 3 for administrative level 3. Default is 0 for
#'   country borders.
#'
#' @return An object of `sf` class of the specified spatial layer
#'
#' @author Ernest Guevarra
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
                      ccode,
                      adm) {

  ## Read spatial layer given query
  layer <- sf::st_read(dsn = con,
                       query = paste("select * from ", layer,
                                     " where countrycode='", ccode,
                                     "' and adm_level=", adm, ";",
                                     sep = ""))

  ## Return layer
  return(layer)
}

