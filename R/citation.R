################################################################################
#
#'
#' Cite data sources
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
  if(any(unique(x[["source"]]) %in% data_sources[["epidemiology"]][["Source code"]])) {
    epi_sources <- data_sources$epidemiology %>%
      dplyr::filter(`Source code` %in% unique(x[["source"]])) %>%
      dplyr::mutate(Table = "Epidemiology") %>%
      dplyr::select(Table, Source, `Terms of Use`)
  } else {
    epi_sources <- NULL
  }

  ## match sources to tables - government response
  if(any(unique(x[["source"]]) == "GOVTRACK")) {
    response_sources <- data_sources$government_response %>%
      dplyr::mutate(Table = "Government Response") %>%
      dplyr::select(Table, Source, `Terms of Use`)
  } else {
    response_sources <- NULL
  }

  ## match sources to tables - country statistics
  if(any(unique(x[["source"]]) %in% c("WVS", "EVS", "World Bank"))) {
    stats_sources <- data_sources$country_statistics %>%
      dplyr::mutate(Table = "Country Statistics") %>%
      dplyr::select(Table, Source, `Terms of Use`)
  } else {
    stats_sources <- NULL
  }

  ## match sources to tables - mobility
  if(any(unique(x[["source"]]) %in% data_sources[["mobility"]][["Source code"]])) {
    mobility_sources <- data_sources$mobility %>%
      dplyr::filter(`Source code` %in% unique(x[["source"]])) %>%
      dplyr::mutate(Table = "Mobility") %>%
      dplyr::select(Table, Source, `Terms of Use`)
  } else {
    mobility_sources <- NULL
  }

  ## match sources to tables - weather
  if(any(unique(x[["sources"]]) == "MET")) {
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
  message(
    paste(
      strwrap("Please cite the following source/s and follow respective
              Terms of Use:",
              width = 80),
      "\n",
      collapse = "\n"
    )
  )

  ## Check if Government Response
  if(any(sources$Table == "Government Response")) {
    message(
      paste(
        strwrap("Hale, Thomas, Sam Webster, Anna Petherick, Toby Phillips, and
                Beatriz Kira (2020). Oxford COVID-19 Government Response Tracker,
                Blavatnik School of Government.",
                width = 80),
        "\n"
      )
    )
  }

  ## Check if country statistics
  if(any(sources$Table == "Country Statistics")) {
    message(
      paste(
        strwrap("Inglehart, R., C. Haerpfer, A. Moreno, C. Welzel, K. Kizilova,
                J. Diez-Medrano, M. Lagos, P. Norris, E. Ponarin & B. Puranen
                et al. (eds.). 2014. World Values Survey: Round Six -
                Country-Pooled Datafile Version:
                http://www.worldvaluessurvey.org/WVSDocumentationWV6.jsp.
                Madrid: JD Systems Institute.\n\nGedeshi, Ilir, Zulehner,
                Paul M., Rotman, David, Swyngedouw, Marc, Voye, Liliane, Fotev,
                Georgy, Baloban, Josip,...(2016). European Values Study 2008:
                Integrated Dataset (EVS 2008). GESIS Datenarchiv, Koln. ZA4800
                Datenfile Version 4.0.0, https://doi.org/10.4232/1.12458.",
                width = 80),
        "\n"
      )
    )
  }

  ## Return sources
  return(sources)
}
