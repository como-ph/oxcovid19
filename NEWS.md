# oxcovid19 0.1.4

<!---
# oxcovid19 0.2.0

This is the fourth [CRAN](https://cran.r-project.org) release of `oxcovid19`. 
This is a minor release. In this release:

## Enhancements

* Added *merge_* functions to create combined tables for relational analysis

* Added a built-in Shiny package for basic data access and basic data
  visualisation; this was also a way to demonstrate how the package functions
  work

* Improved code coverage (from 53% to XX)

## Bug fixes

* addressed issue with `get_data_weather` not working as expected. Issue was
  with how missing values were reported in the actual datasets (usage of
  character value NaN rather than NA or special value NaN)
--->

# oxcovid19 0.1.3

This is a patch release of `oxcovid19` (GitHub and Zenodo release only). This
is a development release leading up to `oxcovid19` minor 
[CRAN](https://cran.r-rpoject.org) release v0.2.0 in December 2020.

In this release:

## Enhancements

* Improved documentation with community guidelines that include code of conduct
  and contributing guidelines
  
* Improved website (favicon, etc)

* Removed Travis ci/cd

## Bug fixes

* addressed issue with `get_data_weather` not working as expected. Issue was
  with how missing values were reported in the actual datasets (usage of
  character value NaN rather than NA or special value NaN)

# oxcovid19 0.1.2

This is the third [CRAN](https://cran.r-project.org) release of `oxcovid19`. In 
this release:

## Enhancements

* added function to get remote table metadata (party to fix CRAN NOTE on non-use
  of imported `dbplyr` package)

* added convenience wrapper functions to retrieve data from specific tables
  based on specified query parameters

* added utility function to help in citing appropriate data sources

* improved documentation including adding markdown support

* updated lifecycle to *maturing*

## Bug fixes

* addressed CRAN NOTE regarding 2 marked UTF-8 strings

* addressed CRAN NOTE regarding non-use of imported `dbplyr` package

# oxcovid19 0.1.1

This is the second [CRAN](https://cran.r-project.org) release of `oxcovid19`. In 
this release:

## Enhancements

* improved documentation

* updated test package GitHub Actions specifications

* updated check package GitHub Actions specifications

## Bug fixes

* Edited 2 marked UTF8 strings

* addressed WARNING on CRAN checks

* addressed issue with connect function regarding `gssencmode` specification

# oxcovid19 0.1.0

This is the first [CRAN](https://cran.r-project.org) release of `oxcovid19`. In 
this release:

* Created a function to open a connection to the PostgreSQL server of the 
  OxCOVID19 Database.

* Created a function to output lists of available tables in the PostgreSQL 
  server and lists of fields in each table in the PostgreSQL server.

* Created a function to output specified tables for use within R environment.

* Pulled source and structure specifications of tables in PostgreSQL server and 
  saved as package datasets.

* Added README to document package description, installation and use.

* Added tests using `testhat`

* Added GitHub Actions for performing R CMD check on package

* Added GitHub Actions for performing code coverage

* Added vignettes to demonstrate similar outputs as OxCOVID-19 Project

* Added a `NEWS.md` file to track changes to the package.
