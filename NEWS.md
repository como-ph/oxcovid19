# oxcovid19 0.1.1

* Edited 2 marked UTF8 strings

* added `dbplyr` in **Suggests** rather than in **Imports**

* addressed WARNING on CRAN checks

* improved documentation

* addressed issue with connect function regarding `gssencmode` specification

* updated test package GitHub Actions specifications

* updated check package GitHub Actions specifications

* added Travis CI for Ubuntu Bionic distribution


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
