################################################################################
#
#'
#' Get data from specified table based on specified query parameters
#'
#' @param tbl_name Name of table available in OxCOVID19 Database. Should be
#'   one of the table names given by a call to \link{list_tables}.
#' @param .source Source of data. Should be specified as per source
#'   code shown in \link{data_sources} for specified table. Default is NULL
#'   which returns data from specified table from all data sources.
#' @param ccode Three character ISO country code for country to which data is
#'   required. Defaults to NULL which returns data for all countries.
#' @param .start Starting date in \code{YYYY-MM-DD} character format of data
#'   to retrieve. Defaults to NULL which returns data from the earliest date
#'   available.
#' @param .end End date in \code{YYYY-MM-DD} character format of data to
#'   retrieve. Defaults to current date as speciifed by \link{Sys.Date}.
#' @param adm Numeric value for administrative level data required. Possible
#'   values are 0 for whole country, 1 for administrative level 1, 2 for
#'   administrative level 2 and 3 for administrative level 3. Default is NULL
#'   which returns data for all administrative divisions.
#'
#' @return A tibble of specified table dataset based on specified parameters. If
#'   all parameters are kept to default, output is the same as that when
#'   \link{get_table} is used with \code{tbl_name} based on specified table.
#'   However, this function will retrieve the full data into a local tibble
#'   which will take considerable time. It is therefore recommended that
#'   this function be used when the specific data requirements are already
#'   clearly determined. For data exploration, \link{get_table} should be used
#'   instead.
#'
#' @examples
#' ## Get epidemiology data for the the whole of the UK from the ECDC for all
#' ## available dates
#' get_data(tbl_name = "epidemiology",
#'          .source = "WRD_ECDC",
#'          ccode = "GBR",
#'          adm = 0)
#'
#' @export
#'
#'
#
################################################################################

get_data <- function(tbl_name,
                     .source = NULL,
                     ccode = NULL,
                     .start = NULL,
                     .end = Sys.Date(),
                     adm = NULL) {
  ## Create connection
  con <- connect_oxcovid19()

  ## Retrieve epidemiology table
  x <- get_table(con = con, tbl_name = tbl_name)

  ## Create source query
  if(is.null(.source)) {
    source_query <- "!is.null(source)"
  } else {
    ## Check that source is valid
    if(!.source %in% data_sources[[tbl_name]]$`Source code`) {
      stop(paste(.source,
                 " is not available from OxCOVID19 Database. Please try again.",
                 sep = ""),
           call. = TRUE)
    }

    source_query <- "source %in% .source"
  }

  ## Create country query
  if(is.null(ccode)) {
    ccode_query <- "!is.null(countrycode)"
  } else {
    ccode_query <- "countrycode %in% ccode"
  }

  ## Create date queries
  if(is.null(.start)) {
    start_date <- as.Date("2019-10-01")
  } else {
    ## Check that dates are in appropriate format
    if(is.na(lubridate::ymd(.start))) {
      stop("Start date is not in appropriate format. Please try again.",
           call. = TRUE)
    }

    start_date <- as.Date(.start)
  }

  if(is.na(lubridate::ymd(.end))) {
    stop("End date is not in appropriate format. Please try again.",
         call. = TRUE)
  }

  end_date <- as.Date(.end)

  date_query <- "date >= start_date & date <= end_date"

  ## Create adm query
  if(is.null(adm)) {
    adm_query <- ""
  } else {
    ##
    if(adm == 0) {
      adm_query <- "is.na(adm_area_1) & is.na(adm_area_2) & is.na(adm_area_3)"
    }
    ##
    if(adm == 1) {
      adm_query <- "!is.na(adm_area_1) & is.na(adm_area_2) & is.na(adm_area_3)"
    }
    ##
    if(adm == 2) {
      adm_query <- "!is.na(adm_area_2) & is.na(adm_area_3)"
    }
    ##
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
#' @param .start Starting date in \code{YYYY-MM-DD} character format of data
#'   to retrieve. Defaults to NULL which returns data from the earliest date
#'   available.
#' @param .end End date in \code{YYYY-MM-DD} character format of data to
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
                                  .start = NULL,
                                  .end = Sys.Date(),
                                  adm = NULL) {
  ## Retrieve dataset
  tab <- get_data(tbl_name = "epidemiology",
                  .source = .source,
                  ccode = ccode,
                  .start = .start,
                  .end = .end,
                  adm = adm)

  ## Return
  return(tab)
}


################################################################################
#
#'
#' Get weather data based on specified query parameters
#'
#' @param ccode Three character ISO country code for country to which data is
#'   required. Defaults to NULL which returns data for all countries.
#' @param .start Starting date in \code{YYYY-MM-DD} character format of data
#'   to retrieve. Defaults to NULL which returns data from the earliest date
#'   available.
#' @param .end End date in \code{YYYY-MM-DD} character format of data to
#'   retrieve. Defaults to current date as speciifed by \link{Sys.Date}.
#' @param adm Numeric value for administrative level data required. Possible
#'   values are 0 for whole country, 1 for administrative level 1, 2 for
#'   administrative level 2 and 3 for administrative level 3. Default is NULL
#'   which returns data for all administrative divisions.
#'
#' @return A tibble of weather dataset based on specified parameters. If
#'   all parameters are kept to default, output is the same as that when
#'   \link{get_table} is used with \code{tbl_name} specified as weather.
#'   However, this function will retrieve the full data into a local tibble
#'   which will take considerable time. It is therefore recommended that
#'   this function be used when the specific data requirements are already
#'   clearly determined. For data exploration, \link{get_table} shouild be used
#'   instead.
#'
#' @examples
#' ## Get weather data for the the whole of the UK for all available dates
#' get_data_weather(ccode = "GBR",
#'                  adm = 0)
#'
#' @export
#'
#'
#
################################################################################

get_data_weather <- function(ccode = NULL,
                             .start = NULL,
                             .end = Sys.Date(),
                             adm = NULL) {
  ## Retrieve dataset
  tab <- get_data(tbl_name = "weather",
                  ccode = ccode,
                  .start = .start,
                  .end = .end,
                  adm = adm)

  ## Return
  return(tab)
}


################################################################################
#
#'
#' Get mobility data based on specified query parameters
#'
#' @param .source Source of mobility data. Should be specified as per source
#'   code shown in \link{data_sources} for mobility table. Default is NULL
#'   which returns data fraom all data sources.
#' @param ccode Three character ISO country code for country to which data is
#'   required. Defaults to NULL which returns data for all countries.
#' @param .start Starting date in \code{YYYY-MM-DD} character format of data
#'   to retrieve. Defaults to NULL which returns data from the earliest date
#'   available.
#' @param .end End date in \code{YYYY-MM-DD} character format of data to
#'   retrieve. Defaults to current date as speciifed by \link{Sys.Date}.
#' @param adm Numeric value for administrative level data required. Possible
#'   values are 0 for whole country, 1 for administrative level 1, 2 for
#'   administrative level 2 and 3 for administrative level 3. Default is NULL
#'   which returns data for all administrative divisions.
#'
#' @return A tibble of mobility dataset based on specified parameters. If
#'   all parameters are kept to default, output is the same as that when
#'   \link{get_table} is used with \code{tbl_name} specified as mobility.
#'   However, this function will retrieve the full data into a local tibble
#'   which will take considerable time. It is therefore recommended that
#'   this function be used when the specific data requirements are already
#'   clearly determined. For data exploration, \link{get_table} shouild be used
#'   instead.
#'
#' @examples
#' ## Get mobility data for the the whole of the UK from Apple for all
#' ## available dates
#' get_data_mobility(.source = "APPLE_MOBILITY",
#'                   ccode = "GBR",
#'                   adm = 0)
#'
#' @export
#'
#'
#
################################################################################

get_data_mobility <- function(.source = NULL,
                              ccode = NULL,
                              .start = NULL,
                              .end = Sys.Date(),
                              adm = NULL) {
  ## Retrieve dataset
  tab <- get_data(tbl_name = "mobility",
                  .source = .source,
                  ccode = ccode,
                  .start = .start,
                  .end = .end,
                  adm = adm)

  ## Return
  return(tab)
}


################################################################################
#
#'
#' Get government response data based on specified query parameters
#'
#' @param ccode Three character ISO country code for country to which data is
#'   required. Defaults to NULL which returns data for all countries.
#' @param .start Starting date in \code{YYYY-MM-DD} character format of data
#'   to retrieve. Defaults to NULL which returns data from the earliest date
#'   available.
#' @param .end End date in \code{YYYY-MM-DD} character format of data to
#'   retrieve. Defaults to current date as speciifed by \link{Sys.Date}.
#' @param adm Numeric value for administrative level data required. Possible
#'   values are 0 for whole country, 1 for administrative level 1, 2 for
#'   administrative level 2 and 3 for administrative level 3. Default is NULL
#'   which returns data for all administrative divisions.
#'
#' @return A tibble of government response dataset based on specified parameters.
#'   If all parameters are kept to default, output is the same as that when
#'   \link{get_table} is used with \code{tbl_name} specified as
#'   government_response. However, this function will retrieve the full data
#'   into a local tibble which will take considerable time. It is therefore
#'   recommended that this function be used when the specific data requirements
#'   are already clearly determined. For data exploration, \link{get_table}
#'   shouild be used instead.
#'
#' @examples
#' ## Get government response data for the the whole of the UK for all
#' ## available dates
#' get_data_response(ccode = "GBR",
#'                   adm = 0)
#'
#' @export
#'
#'
#
################################################################################

get_data_response <- function(ccode = NULL,
                              .start = NULL,
                              .end = Sys.Date(),
                              adm = NULL) {
  ## Retrieve dataset
  tab <- get_data(tbl_name = "government_response",
                  ccode = ccode,
                  .start = .start,
                  .end = .end,
                  adm = adm)

  ## Return
  return(tab)
}
