## Release summary

This is the third CRAN release of `oxcovid19`. In this release:

## Enhancements

* added function to get remote table metadata (party to fix CRAN NOTE on non-use
of imported `dbplyr` package)

* added convenience wrapper functions to retrieve data from specific tables
based on specified query parameters

* added utility function to help in citing appropriate data sources

* improved documentation including adding markdown support and lifecycle badges 
for `Rd`

* updated lifecycle to *maturing*

## Bug fixes

* addressed CRAN NOTE regarding 2 marked UTF-8 strings

* addressed CRAN NOTE regarding non-use of imported `dbplyr` package

## Test environments
* local R installation, R 4.0.3
* ubuntu 16.04 (on travis), R 4.0.3
* ubuntu 20.04 (on github actions), R 4.0.3
* windows latest (on github actions), R 4.0.3
* windows latest (on appveyor), R 4.0.3
* win-builder (devel, oldrelease, release)
* rhub windows ubuntu, fedora (devel, release)

## R CMD check results

### For all checks, the results showed:

0 errors | 0 warnings | 0 note

## Reverse dependencies

This package has no reverse/downstream dependencies.
