################################################################################
#
#'
#' Get remote table metadata
#'
#' @param x An object of class \code{tbl_lazy} produced by \link{get_table}
#'
#' @return A named list of remote table metadata
#'
#' @examples
#' x <- get_table(con = connect_oxcovid19(), tbl_name = "epidemiology")
#' get_metadata(x)
#'
#' @export
#'
#
################################################################################

get_metadata <- function(x) {
  md <- list(dbplyr::remote_name(x),
             dbplyr::remote_src(x),
             dbplyr::remote_con(x),
             dbplyr::remote_query(x),
             dbplyr::remote_query_plan(x))

  names(md) <- c("Name", "Source", "DBI connection", "Query text", "Query plan")

  return(md)
}
