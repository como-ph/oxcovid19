## Release summary

This is the second release of `oxcovid19`. 

This is a release to address warnings and notes identified in [CRAN results](https://cran.r-project.org/web/checks/check_results_oxcovid19.html). In this release:

* I addressed two warnings produced by CRAN checks on macOS:

  Warning in engine$weave(file, quiet = quiet, encoding = enc) :
    Pandoc (>= 1.12.3) and/or pandoc-citeproc not available. Falling back to R Markdown v1.

  Warning in engine$weave(file, quiet = quiet, encoding = enc) :
    Pandoc (>= 1.12.3) and/or pandoc-citeproc not available. Falling back to R Markdown v1.

These are the same warnings for two different vignettes. On further investigation, this seems to be related to my generation of figures using Rmarkdown. To address this, I instead generated and saved these figures locally and then inserted the figures into the respective vignettes rather than generating the figures on build.

* I addressed two notes produced by CRAN checks on linux fedora clang and gcc:

  Note: found 2 marked UTF-8 strings
  
  Namespace in Imports field not imported from: ‘dbplyr’
    All declared Imports should be used.
  
I found the two marked UTF-8 strings and have edited them accordingly

I do not directly use `dbplyr` in my functions but I use the `tbl` function in `dplyr` that when used with a database connection requires `dbplyr`

## Test environments
* local R installation, R 4.0.2
* ubuntu 16.04 (on github actions), R 4.0.2
* windows latest (on github actions), R 4.0.2
* windows latest (on appveyor), R 4.0.2
* win-builder (devel, oldrelease, release)
* rhub windows, ubuntu, fedora (devel, release)

## R CMD check results

### For all checks, the results showed:

0 errors | 0 warnings | 0 note

### For rhub checks, additional resuls showed:

Possibly mis-spelled words in DESCRIPTION:
  COVID (3:31, 17:30, 21:60)
  OxCOVID (16:18, 19:66, 22:58)

* These words are correctly spelled but unrecognised by spelling checker

## Reverse dependencies

This package has no reverse/downstream dependencies.
