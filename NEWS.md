# oxcovid19 0.1.2

## Enhancements

* added function to get remote table metadata (party to fix CRAN NOTE on non-use
of imported `dbplyr` package)

* improved documentation

* updated lifecycle to *maturing*

## Bug fixes

* addressed CRAN NOTE regarding 2 marked UTF-9 strings

* addressed CRAN NOTE regarding non-use of imported `dbplyr` package


# oxcovid19 0.1.1

* Edited 2 marked UTF8 strings

* addressed WARNING on CRAN checks

* improved documentation

* addressed issue with connect function regarding `gssencmode` specification

* updated test package GitHub Actions specifications

* updated check package GitHub Actions specifications


# oxcovid19 0.1.0

* Created a function to open a connection to the PostgreSQL server of the OxCOVID19 Database.

* Created a function to output lists of available tables in the PostgreSQL server and lists of fields in each table in the PostgreSQL server.

* Created a function to output specified tables for use within R environment.

* Pulled source and structure specifications of tables in PostgreSQL server and saved as package datasets.

* Added README to document package description, installation and use.

* Added tests using `testhat`

* Added GitHub Actions for performing R CMD check on package

* Added GitHub Actions for performing code coverage

* Added vignettes to demonstrate similar outputs as OxCOVID-19 Project

* Added a `NEWS.md` file to track changes to the package.
