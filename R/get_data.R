################################################################################
#
#'
#' Get data from specified table based on specified query parameters
#'
#' @param tbl_name Name of table available in **OxCOVID19 Database**. Should be
#'   one of the table names given by a call to [list_tables()].
#' @param .source Source of data. Should be specified as per source
#'   code shown in [data_sources] for specified table. Default is NULL
#'   which returns data from specified table from all data sources.
#' @param ccode A character value of country name specified as either a two
#'   character ISO country code, or a three character ISO country code, or any
#'   of the country names specified in the [countrycode] package, or a
#'   vector of country names using a combination of these country name variants.
#'   Defaults to NULL which returns data for all countries in the database.
#' @param .start Starting date (in `YYYY-MM-DD` character format) of data
#'   to retrieve. Defaults to NULL which returns data from the earliest date
#'   available.
#' @param .end End date (in `YYYY-MM-DD` character format) of data to
#'   retrieve. Defaults to current date as speciifed by [Sys.Date()].
#' @param adm Numeric value for administrative level data required. Possible
#'   values are 0 for whole country, 1 for administrative level 1, 2 for
#'   administrative level 2 and 3 for administrative level 3. Default is NULL
#'   which returns data for all administrative divisions.
#'
#' @return A tibble of specified table dataset based on specified parameters. If
#'   all parameters are kept to default, output is the same as that when
#'   [get_table()] is used with `tbl_name` based on specified table.
#'   However, this function will retrieve the full data into a local tibble
#'   which will take considerable time. It is therefore recommended that
#'   this function be used when the specific data requirements are already
#'   clearly determined. For data exploration, [get_table()] should be used
#'   instead.
#'
#' @author Ernest Guevarra
#'
#' @examples
#' ## Get epidemiology data for the the whole of the UK from the ECDC for all
#' ## available dates
#' get_data(tbl_name = "epidemiology",
#'          .source = "WRD_ECDC",
#'          ccode = "GBR",
#'          adm = 0)
#'
#' ## Get epidemiology data for the the whole of the UK from the ECDC for all
#' ## available dates
#' get_data_epidemiology(.source = "WRD_ECDC",
#'                       ccode = "UK",
#'                       adm = 0)
#'
#' ## Get weather data for the the whole of the UK for all available dates
#' get_data_weather(ccode = "GBR",
#'                  adm = 0)
#'
#' ## Get mobility data for the the whole of the UK from Apple for all
#' ## available dates
#' get_data_mobility(.source = "APPLE_MOBILITY",
#'                   ccode = "United Kingdom",
#'                   adm = 0)
#'
#' ## Get government response data for the the whole of the UK for all
#' ## available dates
#' get_data_response(ccode = "UK",
#'                   adm = 0)
#'
#' @rdname get_data
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

  ## Retrieve table specified by tbl_name
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
    c1 <- countrycode::countrycode(sourcevar = ccode,
                                   origin = "iso2c",
                                   destination = "iso3c",
                                   warn = FALSE)
    country <- ifelse(is.na(c1), ccode, c1)
    c2 <- countrycode::countryname(sourcevar = country,
                                   destination = "iso3c",
                                   warn = FALSE)
    country <- ifelse(is.na(c2), country, c2)
    ccode <- country
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
#' @rdname get_data
#' @export
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
#' @rdname get_data
#' @export
#
################################################################################

get_data_weather <- function(.source = NULL,
                             ccode = NULL,
                             .start = NULL,
                             .end = Sys.Date(),
                             adm = NULL) {

  ## Create connection
  con <- connect_oxcovid19()

  ## Retrieve table specified by tbl_name
  x <- get_table(con = con, tbl_name = "weather")

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
    c1 <- countrycode::countrycode(sourcevar = ccode,
                                   origin = "iso2c",
                                   destination = "iso3c",
                                   warn = FALSE)
    country <- ifelse(is.na(c1), ccode, c1)
    c2 <- countrycode::countryname(sourcevar = country,
                                   destination = "iso3c",
                                   warn = FALSE)
    country <- ifelse(is.na(c2), country, c2)
    ccode <- country
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

  ## Concatenate query
  query <- paste("dplyr::filter(.data = x, ",
                 source_query, ", ",
                 ccode_query, ", ",
                 date_query, ")",
                 sep = "")

  ## Query table as per query parameters
  tab <- eval(parse(text = query))

  ## Collect
  tab <- dplyr::collect(tab)

  ## Clean-up NaNs and filter based on adm parameter
  tab <- tab %>%
    dplyr::mutate(adm_area_1 = ifelse(adm_area_1 == "NaN", NA, adm_area_1),
                  adm_area_2 = ifelse(adm_area_2 == "NaN", NA, adm_area_2),
                  adm_area_3 = ifelse(adm_area_3 == "NaN", NA, adm_area_3))

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
  query <- paste("dplyr::filter(.data = tab, ", adm_query, ")", sep = "")

  ## Filter
  tab <- eval(parse(text = query))

  ## Return
  return(tab)
}


################################################################################
#
#' @rdname get_data
#' @export
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
#' @rdname get_data
#' @export
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
