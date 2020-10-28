################################################################################
#
#'
#' Cite data sources
#'
#' \lifecycle{experimental}
#'
#' @param x An object of class `tbl` produced by [get_data()]
#'
#' @return A tibble containing information on data source and relevant terms of
#'   use.
#'
#' @author Ernest Guevarra
#'
#' @examples
#' epidata <- get_data_epidemiology(ccode = "UK", adm = 0)
#' cite_sources(x = epidata)
#'
#' @export
#'
#'
#
################################################################################

cite_sources <- function(x) {
  ## match sources to tables - epidemiology
  if(any(unique(x$source) %in% data_sources[["epidemiology"]][["Source code"]])) {
    epi_sources <- data_sources$epidemiology %>%
      dplyr::filter(`Source code` %in% unique(x$source)) %>%
      dplyr::mutate(Table = "Epidemiology") %>%
      dplyr::select(Table, Source, `Terms of Use`)
  } else {
    epi_sources <- NULL
  }

  ## match sources to tables - government response
  if(any(unique(x$source) == "GOVTRACK")) {
    response_sources <- data_sources$government_response %>%
      dplyr::mutate(Table = "Government Response") %>%
      dplyr::select(Table, Source, `Terms of Use`)
  } else {
    response_sources <- NULL
  }

  ## match sources to tables - country statistics
  if(any(unique(x$source) %in% c("WVS", "EVS", "World Bank"))) {
    stats_sources <- data_sources$country_statistics %>%
      dplyr::mutate(Table = "Country Statistics") %>%
      dplyr::select(Table, Source, `Terms of Use`)
  } else {
    stats_sources <- NULL
  }

  ## match sources to tables - mobility
  if(any(unique(x$source) %in% data_sources[["mobility"]][["Source code"]])) {
    mobility_sources <- data_sources$mobility %>%
      dplyr::filter(`Source code` %in% unique(x$source)) %>%
      dplyr::mutate(Table = "Mobility") %>%
      dplyr::select(Table, Source, `Terms of Use`)
  } else {
    mobility_sources <- NULL
  }

  ## match sources to tables - weather
  if(any(unique(x$source) == "MET")) {
    weather_sources <- data_sources$weather %>%
      dplyr::mutate(Table = "Weather") %>%
      dplyr::select(Table, Source, `Terms of Use`)
  } else {
    weather_sources <- NULL
  }

  ## Concatenate sources
  sources <- rbind(epi_sources, response_sources, stats_sources,
                   mobility_sources, weather_sources)

  ## Message
  message("Please cite the following source/s:")

  if(any(sources$Table == "Government Response")) {
    message("Please also cite:\nHale, Thomas, Sam Webster, Anna Petherick,
            Toby Phillips, and Beatriz Kira (2020). Oxford COVID-19 Government
            Response Tracker, Blavatnik School of Government.")
  }

  ## Return sources
  return(sources)
}
