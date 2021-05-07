## Release summary

This is the fourth [CRAN](https://cran.r-project.org) release of `oxcovid19`. 
This is a minor release. In this release:

## Enhancements

* Added *merge_* functions to create combined tables for relational analysis

* Added a built-in Shiny package for basic data access and basic data
  visualisation; this was also a way to demonstrate how the package functions
  work
  
* Added graceful erroring when database unavailable (in response to CRAN
  comments and recent CRAN errors)


## Bug fixes

* addressed issue with `get_data_weather` not working as expected. Issue was
  with how missing values were reported in the actual datasets (usage of
  character value NaN rather than NA or special value NaN)

## Test environments
* local R installation, R 4.0.5
* ubuntu 16.04 (on travis), R 4.0.5
* ubuntu 20.04 (on github actions), R 4.0.5
* windows latest (on github actions), R 4.0.5
* windows latest (on appveyor), R 4.0.5
* win-builder (devel, oldrelease, release)
* rhub windows ubuntu, fedora (devel, release)

## R CMD check results

### For all checks, the results showed:

0 errors | 0 warnings | 0 note

## Reverse dependencies

This package has no reverse/downstream dependencies.
