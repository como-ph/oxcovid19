## Load libraries
library(magrittr)

## Read HTML page for data sources - https://covid19.eng.ox.ac.uk/data_sources.html -
## and extract sources tables
data_sources <- xml2::read_html(x = "https://covid19.eng.ox.ac.uk/data_sources.html") %>%
  rvest::html_nodes(css = ".container_col .table") %>%
  rvest::html_table(fill = TRUE)

## Clean up column in epidemiology sources table with NA
data_sources[[1]] <- data_sources[[1]] %>%
  dplyr::select(Country:`Terms of Use`)

## Convert each table in list to tibble
for(i in seq_len(length(data_sources))) {
  data_sources[[i]] <- tibble::tibble(data_sources[[i]])
}

## Rename list
names(data_sources) <- c("epidemiology", "government_response",
                         "country_statistics", "mobility", "weather")

## Save as .rda
usethis::use_data(data_sources, overwrite = TRUE, compress = "xz")

## Read HTML page for data structures = https://covid19.eng.ox.ac.uk/data_schema.html -
## and extract structures tables
data_structures <- xml2::read_html(x = "https://covid19.eng.ox.ac.uk/data_schema.html") %>%
  rvest::html_nodes(css = ".container_col .table") %>%
  rvest::html_table(fill = TRUE)

## Clean up adminstrative table to remove NA row
data_structures[[6]] <- data_structures[[6]] %>%
  dplyr::filter(!is.na(Name))

## Clean up government response table to remove NA row
data_structures[[2]] <- data_structures[[2]] %>%
  dplyr::filter(!is.na(Name))

## Clean up country statistics table to remove linebreaks in fields
data_structures[[3]]$Description <- stringr::str_remove_all(
  string = data_structures[[3]]$Description,
  pattern = "\\\n             ")

## Convert each table in list to tibble
for(i in seq_len(length(data_structures))) {
  data_structures[[i]] <- tibble::tibble(data_structures[[i]])
}

## Rename data_structures list
names(data_structures) <- c("epidemiology", "government_response",
                            "country_statistics", "mobility",
                            "weather", "administrative_division")

## Save as .rda
usethis::use_data(data_structures, overwrite = TRUE, compress = "xz")
