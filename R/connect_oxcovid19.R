################################################################################
#
#' Initiate a connection to the OxCOVID19 PostgreSQL database
#'
#' @param dbname Name of database. Default is \code{"covid19"}. Unless
#'   OxCOVID19 Project changes database details, this should be kept as
#'   default.
#' @param host Name of database host. Default is \code{"covid19db.org"}. Unless
#'   OxCOVID19 Project changes database details, this should be kept as
#'   default.
#' @param port Port specifications. Default is \code{5432}. Unless OxCOVID19
#'   Project changes database details, this should be kept as default.
#' @param user User specifications. Default is \code{"covid19"}. Unless
#'   OxCOVID19 Project changes database details, this should be kept as default.
#' @param password Password specifications. Default is \code{"covid19"}. Unless
#'   OxCOVID19 Project changes database details, this should be kept as
#'   default.
#'
#' @return A PostgreSQL connection to OxCOVID19 database
#'
#' @author Ernest Guevarra
#'
#' @examples
#' connect_oxcovid19()
#'
#' @export
#'
#
################################################################################

connect_oxcovid19 <- function(dbname = "covid19",
                              host = "covid19db.org",
                              port = 5432,
                              user = "covid19",
                              password = "covid19") {
  ## Check OS
  if(Sys.info()["sysname"] == "Windows") {
    ## Start connection using available OxCOVID19 database credentials
    con <- DBI::dbConnect(RPostgres::Postgres(),
                          dbname     = dbname,
                          host       = host,
                          port       = port,
                          user       = user,
                          password   = password)
  } else {
    ## Start connection using available OxCOVID19 database credentials
    con <- DBI::dbConnect(RPostgres::Postgres(),
                          dbname     = dbname,
                          host       = host,
                          port       = port,
                          user       = user,
                          password   = password,
                          gssencmode = "disable")
  }

  ## Return connection
  return(con)
}
