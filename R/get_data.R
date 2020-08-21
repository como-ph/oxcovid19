################################################################################
#
#'
#' Get epidemiology data based on specified query parameters
#'
#' @param .source Source of epidemiology data. Should be specified as per source
#'   code shown in \link{data_sources} for epidemiology table. Default is NULL
#'   which returns data fraom all data sources.
#' @param ccode Three character ISO country code for country to which data is
#'   required. Defaults to NULL which returns data for all countries.
#' @param start Starting date in \code{YYYY-MM-DD} character format of data
#'   to retrieve. Defaults to NULL which returns data from the earliest date
#'   available.
#' @param end End date in \code{YYYY-MM-DD} character format of data to
#'   retrieve. Defaults to current date as speciifed by \link{Sys.Date}.
#' @param adm Numeric value for administrative level data required. Possible
#'   values are 0 for whole country, 1 for administrative level 1, 2 for
#'   administrative level 2 and 3 for administrative level 3. Default is NULL
#'   which returns data for all administrative divisions.
#'
#' @return A tibble of epidemiology dataset based on specified parameters. If
#'   all parameters are kept to default, output is the same as that when
#'   \link{get_table} is used with \code{tbl_name} specified as epidemiology.
#'   However, this function will retrieve the full data into a local tibble
#'   which will take considerable time. It is therefore recommended that
#'   this function be used when the specific data requirements are already
#'   clearly determined. For data exploration, \link{get_table} shouild be used
#'   instead.
#'
#' @examples
#' ## Get epidemiology data for the the whole of the UK from the ECDC for all
#' ## available dates
#' get_data_epidemiology(.source = "WRD_ECDC",
#'                       ccode = "GBR",
#'                       adm = 0)
#'
#' @export
#'
#'
#
################################################################################

get_data_epidemiology <- function(.source = NULL,
                                  ccode = NULL,
                                  start = NULL,
                                  end = Sys.Date(),
                                  adm = NULL) {
  ## Create connection
  con <- connect_oxcovid19()

  ## Retrieve epidemiology table
  x <- get_table(con = con, tbl_name = "epidemiology")

  ## Create source query
  if(is.null(.source)) {
    source_query <- "!is.null(source)"
  } else {
    source_query <- "source %in% .source"
  }

  ## Create country query
  if(is.null(ccode)) {
    ccode_query <- "!is.null(countrycode)"
  } else {
    ccode_query <- "countrycode %in% ccode"
  }

  ## Create date queries
  if(is.null(start)) {
    start_date <- as.Date("2019-10-01")
  } else {
    start_date <- as.Date(start)
  }

  end_date <- as.Date(end)

  date_query <- "date >= start_date & date <= end_date"

  ## Create adm query
  if(is.null(adm)) {
    adm_query <- ""
  } else {

    if(adm == 0) {
      adm_query <- "is.na(adm_area_1) & is.na(adm_area_2) & is.na(adm_area_3)"
    }

    if(adm == 1) {
      adm_query <- "!is.na(adm_area_1) & is.na(adm_area_2) & is.na(adm_area_3)"
    }

    if(adm == 2) {
      adm_query <- "!is.na(adm_area_2) & is.na(adm_area_3)"
    }

    if(adm == 3) {
      adm_query <- "!is.na(adm_area_3)"
    }
  }

  ## Concatenate query
  query <- paste("dplyr::filter(.data = x, ",
                 source_query, ", ",
                 ccode_query, ", ",
                 date_query, ", ",
                 adm_query, ")",
                 sep = "")

  ## Query epi table as per query parameters
  tab <- eval(parse(text = query))

  ## Collect
  tab <- dplyr::collect(tab)

  ## Return
  return(tab)
}
