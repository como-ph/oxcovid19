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

