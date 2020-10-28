
<!-- README.md is generated from README.Rmd. Please edit that file -->

# oxcovid19: An R API to the Oxford COVID-19 Database

<!-- <img src="man/figures/oxcovid19.png" width="200px" align="right" /> -->

<!-- badges: start -->

[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![CRAN](https://img.shields.io/cran/l/oxcovid19.svg)](https://CRAN.R-project.org/package=oxcovid19)
[![CRAN
status](https://www.r-pkg.org/badges/version/oxcovid19)](https://CRAN.R-project.org/package=oxcovid19)
[![cran
checks](https://cranchecks.info/badges/summary/oxcovid19)](https://cran.r-project.org/web/checks/check_results_oxcovid19.html)
[![CRAN](http://cranlogs.r-pkg.org/badges/oxcovid19)](https://CRAN.R-project.org/package=oxcovid19)
[![CRAN](http://cranlogs.r-pkg.org/badges/grand-total/oxcovid19)](https://CRAN.R-project.org/package=oxcovid19)
[![dev](https://img.shields.io/badge/dev-v0.1.2.9000-orange.svg)](https://github.com/como-ph/oxcovid19)
[![R build
status](https://github.com/como-ph/oxcovid19/workflows/R-CMD-check/badge.svg)](https://github.com/como-ph/oxcovid19/actions)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/como-ph/oxcovid19?branch=master&svg=true)](https://ci.appveyor.com/project/como-ph/oxcovid19)
[![Travis build
status](https://travis-ci.org/como-ph/oxcovid19.svg?branch=master)](https://travis-ci.org/como-ph/oxcovid19)
[![R build
status](https://github.com/como-ph/oxcovid19/workflows/test-coverage/badge.svg)](https://github.com/como-ph/oxcovid19/actions)
[![Codecov test
coverage](https://codecov.io/gh/como-ph/oxcovid19/branch/master/graph/badge.svg)](https://codecov.io/gh/como-ph/oxcovid19?branch=master)
[![CodeFactor](https://www.codefactor.io/repository/github/como-ph/oxcovid19/badge)](https://www.codefactor.io/repository/github/como-ph/oxcovid19)
[![DOI](https://zenodo.org/badge/276818770.svg)](https://zenodo.org/badge/latestdoi/276818770)
<!-- badges: end -->

The [OxCOVID19 Project](https://covid19.eng.ox.ac.uk) aims to increase
our understanding of the COVID-19 pandemic and elaborate possible
strategies to reduce the impact on the society through the combined
power of statistical, mathematical modelling, and machine learning
techniques. The [OxCOVID19 Database](https://covid19.eng.ox.ac.uk) is a
large, single-centre, multimodal relational database consisting of
information (using acknowledged sources) related to COVID-19 pandemic.
This package provides an [R](https://www.r-project.org)-specific
interface to the [OxCOVID19 Database](https://covid19.eng.ox.ac.uk)
based on widely-used data handling and manipulation approaches in
[R](https://www.r-project.org).

## Motivation

The [OxCOVID19 Project](https://covid19.eng.ox.ac.uk) team presented to
the [CoMo
Consortium](https://www.tropicalmedicine.ox.ac.uk/news/como-consortium-the-covid-19-pandemic-modelling-in-context)
during its weekly meeting on the 1st of July 2020. During this meeting,
the [CoMo
Consortium](https://www.tropicalmedicine.ox.ac.uk/news/como-consortium-the-covid-19-pandemic-modelling-in-context)
considered the use of the [OxCOVID19
Database](https://covid19.eng.ox.ac.uk/) for use in filling data and
information for country-specific parameters required in the [CoMo
Consortium](https://www.tropicalmedicine.ox.ac.uk/news/como-consortium-the-covid-19-pandemic-modelling-in-context)
model. Given that the [CoMo
Consortium](https://www.tropicalmedicine.ox.ac.uk/news/como-consortium-the-covid-19-pandemic-modelling-in-context)
model is [R](https://www.r-project.org)-centric, it makes logical sense
to build an [R](https://www.r-project.org)-specific API to connect with
the [OxCOVID19](https://covid19.eng.ox.ac.uk)
[PostgreSQL](https://www.postgresql.org) database. This package aims to
facilitate the possible use of the
[OxCOVID19](https://covid19.eng.ox.ac.uk) database for this purpose
through purposefully-written functions that connects an R user to the
database directly from [R](https://www.r-project.org) (as opposed to
doing a manual download of the data or using separate tools to access
[PostgreSQL](https://www.postgresql.org)) and processes and structures
the available datasets into country-specific tables structured for the
requirements of the [CoMo
Consortium](https://www.tropicalmedicine.ox.ac.uk/news/como-consortium-the-covid-19-pandemic-modelling-in-context)
model. A direct link to the [PostgreSQL](https://www.postgresql.org) via
[R](https://www.r-project.org) is also advantageous as this is updated
more frequently than the CSV datasets made available via
[GitHub](https://github.com/covid19db/data).

## Installation

You can install `oxcovid19` from [CRAN](https://cran.r-project.org)
with:

``` r
install.packages("oxcovid19")
```

You can install the development version of `oxcovid19` from
[GitHub](https://github.com/como-ph/oxcovid19) with:

``` r
if(!require(remotes)) install.packages("remotes")
remotes::install_github("como-ph/oxcovid19")
```

## Usage

The primary use case for the `oxcovid19` package is for facilitating a
simplified, [R](https://www.r-project.org)-based workflow for 1)
connecting to the [OxCOVID19](https://covid19.eng.ox.ac.uk)
[PostgreSQL](https://www.postgresql.org) server; 2) accessing table/s
available from the [PostgreSQL](https://www.postgresql.org) server; and,
3) querying the [PostgreSQL](https://www.postgresql.org) server with
specific parameters to customise table/s output for intended use.

The following code demonstrates this workflow:

``` r
library(oxcovid19)
#> 
#>   ___          ____  ___ __     __ ___  ____   _   ___
#>  / _ \ __  __ / ___|/ _ \\ \   / /|_ _||  _ \ / | / _ \
#> | | | |\ \/ /| |   | | | |\ \ / /  | | | | | || || (_) |
#> | |_| | >  < | |___| |_| | \ V /   | | | |_| || | \__, |
#>  \___/ /_/\_\ \____|\___/   \_/   |___||____/ |_|   /_/
#>     ___           _          _
#>    |  _ \   __ _ | |_  __ _ | |__    __ _  ___   ___
#>    | | | | / _` || __|/ _` || '_ \  / _` |/ __| / _ \
#>    | |_| || (_| || |_| (_| || |_) || (_| |\__ \|  __/
#>    |____/  \__,_| \__|\__,_||_.__/  \__,_||___/ \___|
#> 
#> The OxCOVID19 Database makes use of several datasets. If you
#> use any of the data provided by this package, please include
#> the appropriate citation as described at the following
#> website:
#> 
#> https://covid19.eng.ox.ac.uk/data_sources.html

## Step 1: Create a connection to OxCOVID19 PostgreSQL server
con <- connect_oxcovid19()

## Step 2: Access epidemiology table from OxCOVID19 PostgreSQL server
epi_tab <- get_table(con = con, tbl_name = "epidemiology")

## Step 3: Query the epidemiology table to show data for Great Britain
gbr_epi_tab <- dplyr::filter(.data = epi_tab, countrycode == "GBR")
```

**Step 1** and **Step 2** above are facilitated by the
`connect_oxcovid19` and the `get_table` functions provided by the
`oxcovid19` package. These functions are basically low-level wrappers to
functions in the [`DBI`](https://db.rstudio.com/dbi/) and
[`RPostgres`](https://rpostgres.r-dbi.org) packages applied specifically
to work with the [OxCOVID19](https://covid19.eng.ox.ac.uk)
[PostgreSQL](https://www.postgresql.org). These functions facilitate
convenient access to the server for general
[R](https://www.r-project.org) users without having to learn to use the
`DBI` and `RPostgres` packages.

**Step 3**, on the other hand, is facilitated by the `dplyr` package
functions which were designed to work with different types of tables
including those from various database server connections such as
[PostgreSQL](https://www.postgresql.org).

The output of the workflow shown above is:

    #> # Source:   lazy query [?? x 15]
    #> # Database: postgres [covid19@covid19db.org:5432/covid19]
    #>    source date       country countrycode adm_area_1 adm_area_2 adm_area_3 tested
    #>    <chr>  <date>     <chr>   <chr>       <chr>      <chr>      <chr>       <int>
    #>  1 GBR_P… 2020-05-23 United… GBR         England    Hampshire  <NA>           NA
    #>  2 GBR_P… 2020-05-23 United… GBR         England    Kent       <NA>           NA
    #>  3 GBR_P… 2020-05-23 United… GBR         England    Essex      <NA>           NA
    #>  4 GBR_P… 2020-05-23 United… GBR         England    Hertfords… <NA>           NA
    #>  5 GBR_P… 2020-05-23 United… GBR         England    Leicester… <NA>           NA
    #>  6 GBR_P… 2020-05-23 United… GBR         England    Norfolk    <NA>           NA
    #>  7 GBR_P… 2020-05-23 United… GBR         England    Glouceste… <NA>           NA
    #>  8 GBR_P… 2020-05-23 United… GBR         England    Cambridge… <NA>           NA
    #>  9 GBR_P… 2020-05-23 United… GBR         England    Derbyshire <NA>           NA
    #> 10 GBR_P… 2020-05-23 United… GBR         England    Westminst… <NA>           NA
    #> # … with more rows, and 7 more variables: confirmed <int>, recovered <int>,
    #> #   dead <int>, hospitalised <int>, hospitalised_icu <int>, quarantined <int>,
    #> #   gid <chr>

Note that the output of this workflow looks like a `tibble` (which it
partly is) but it is also more than that. Annotation shows some of the
metadata about this table. Specifically it shows the *source* and the
*database* from which this table is from. This output table has the
following classes:

``` r
class(gbr_epi_tab)
#> [1] "tbl_PqConnection" "tbl_dbi"          "tbl_sql"          "tbl_lazy"        
#> [5] "tbl"
```

Other than being a `tibble`, the output is also a what is called a
*“lazy”* table (`tbl_lazy`) or a *dbi* (database) table (`tbl_dib`).
What this means is that the output table shown is not actually retrieved
and the basic query (which in this case is selecting a specific table
named `epidemiology`) is not actually run. This has its advantageous in
that the data is not yet in memory in [R](https://www.r-project.org)
which can save computing time particularly if only a subset of the table
in the remote server is required, and further queries to the remote
server can be declared to customise the data output. These further
queries can be facilitated using `dplyr` verbs such as `filter`,
`mutate`, `arrange` which also operates *lazily* when applied to
`tbl_lazy` or `tbl_dbi` objects.

One can review the query parameter/s or the query plan applied to a
`tbl_lazy` object by using the `get_metadata` function provided in
`oxcovid19`:

``` r
get_metadata(gbr_epi_tab)
#> $Name
#> NULL
#> 
#> $Source
#> src:  postgres  [covid19@covid19db.org:5432/covid19]
#> tbls: administrative_division, baseline_mortality, diagnostics, epidemiology,
#>   epidemiology_england_msoa, geography_columns, geometry_columns,
#>   government_response, mobility, spatial_ref_sys, surveys, weather, world_bank,
#>   world_bank_time_series
#> 
#> $`DBI connection`
#> <PqConnection> covid19@covid19db.org:5432
#> 
#> $`Query text`
#> <SQL> SELECT *
#> FROM "epidemiology"
#> WHERE ("countrycode" = 'GBR')
#> 
#> $`Query plan`
#> [1] "Seq Scan on epidemiology  (cost=0.00..42709.26 rows=180167 width=121)\n  Filter: ((countrycode)::text = 'GBR'::text)"
```

The result is a list showing information on the remote table’s `name`,
`source`, `DBI connection`, `query text` and `query plan`.

It should also be noted that other [R](https://www.r-project.org)
operations and functions will not work on `tbl_lazy` objects. For
example, getting the number of rows of a `tbl_lazy` using `nrow` will
result in `NA`:

``` r
nrow(gbr_epi_tab)
#> [1] NA
```

These operations require for the table to be retrieved into
[R](https://www.r-project.org) (discussed below).

The `oxcovid19` package functions are also designed to allow *pipe
operations* using the `magrittr` package. The workflow above can be done
using piped operations as follows:

``` r
## Load magrittr to use pipe operator %>%
library(magrittr)

connect_oxcovid19() %>%
  get_table(tbl_name = "epidemiology") %>%
  dplyr::filter(countrycode == "GBR")
#> # Source:   lazy query [?? x 15]
#> # Database: postgres [covid19@covid19db.org:5432/covid19]
#>    source date       country countrycode adm_area_1 adm_area_2 adm_area_3 tested
#>    <chr>  <date>     <chr>   <chr>       <chr>      <chr>      <chr>       <int>
#>  1 GBR_P… 2020-05-23 United… GBR         England    Hampshire  <NA>           NA
#>  2 GBR_P… 2020-05-23 United… GBR         England    Kent       <NA>           NA
#>  3 GBR_P… 2020-05-23 United… GBR         England    Essex      <NA>           NA
#>  4 GBR_P… 2020-05-23 United… GBR         England    Hertfords… <NA>           NA
#>  5 GBR_P… 2020-05-23 United… GBR         England    Leicester… <NA>           NA
#>  6 GBR_P… 2020-05-23 United… GBR         England    Norfolk    <NA>           NA
#>  7 GBR_P… 2020-05-23 United… GBR         England    Glouceste… <NA>           NA
#>  8 GBR_P… 2020-05-23 United… GBR         England    Cambridge… <NA>           NA
#>  9 GBR_P… 2020-05-23 United… GBR         England    Derbyshire <NA>           NA
#> 10 GBR_P… 2020-05-23 United… GBR         England    Westminst… <NA>           NA
#> # … with more rows, and 7 more variables: confirmed <int>, recovered <int>,
#> #   dead <int>, hospitalised <int>, hospitalised_icu <int>, quarantined <int>,
#> #   gid <chr>
```

The workflow using the piped workflow outputs the same result as the
earlier workflow but with a much streamlined use of code.

Once all query parameters have been set to what is required, the actual
data from the remote table can be retrieved into
[R](https://www.r-project.org) by using the `collect` function:

``` r
dplyr::collect(gbr_epi_tab)
#> # A tibble: 177,735 x 15
#>    source date       country countrycode adm_area_1 adm_area_2 adm_area_3 tested
#>    <chr>  <date>     <chr>   <chr>       <chr>      <chr>      <chr>       <int>
#>  1 GBR_P… 2020-05-23 United… GBR         England    Hampshire  <NA>           NA
#>  2 GBR_P… 2020-05-23 United… GBR         England    Kent       <NA>           NA
#>  3 GBR_P… 2020-05-23 United… GBR         England    Essex      <NA>           NA
#>  4 GBR_P… 2020-05-23 United… GBR         England    Hertfords… <NA>           NA
#>  5 GBR_P… 2020-05-23 United… GBR         England    Leicester… <NA>           NA
#>  6 GBR_P… 2020-05-23 United… GBR         England    Norfolk    <NA>           NA
#>  7 GBR_P… 2020-05-23 United… GBR         England    Glouceste… <NA>           NA
#>  8 GBR_P… 2020-05-23 United… GBR         England    Cambridge… <NA>           NA
#>  9 GBR_P… 2020-05-23 United… GBR         England    Derbyshire <NA>           NA
#> 10 GBR_P… 2020-05-23 United… GBR         England    Westminst… <NA>           NA
#> # … with 177,725 more rows, and 7 more variables: confirmed <int>,
#> #   recovered <int>, dead <int>, hospitalised <int>, hospitalised_icu <int>,
#> #   quarantined <int>, gid <pq__text>
```

    #> [1] "tbl_df"     "tbl"        "data.frame"

The resulting output is a `tbl` but is now retrieved into
[R](https://www.r-project.org). Now, further
[R](https://www.r-project.org) operations can be used:

``` r
nrow(dplyr::collect(gbr_epi_tab))
#> [1] 177735
```

It should be noted that the use of `collect` should be well-planned and
ideally should be implemented once all required queries that can be
issued lazily have been specified. Depending on the size of the remote
database being accessed, using `collect` too early to retrieve data can
cause significant computing overheads.

### Querying spatial layers

The [OxCOVID19 Database](https://covid19.eng.ox.ac.uk/) includes a table
named `administrative_division` which contains some spatial information.
This table can be accessed via `oxcovid19` using the same approach
described above:

``` r
connect_oxcovid19() %>% get_table(tbl_name = "administrative_division")
#> # Source:   table<administrative_division> [?? x 15]
#> # Database: postgres [covid19@covid19db.org:5432/covid19]
#>    country countrycode countrycode_alp… adm_level adm_area_1 adm_area_1_code
#>    <chr>   <chr>       <chr>                <int> <chr>      <chr>          
#>  1 South … ZAF         ZA                       3 Mpumalanga ZAF.6_1        
#>  2 South … ZAF         ZA                       3 North West ZAF.7_1        
#>  3 South … ZAF         ZA                       3 North West ZAF.7_1        
#>  4 South … ZAF         ZA                       3 North West ZAF.7_1        
#>  5 South … ZAF         ZA                       3 North West ZAF.7_1        
#>  6 South … ZAF         ZA                       3 North West ZAF.7_1        
#>  7 South … ZAF         ZA                       3 Northern … ZAF.8_1        
#>  8 South … ZAF         ZA                       3 Northern … ZAF.8_1        
#>  9 South … ZAF         ZA                       3 Northern … ZAF.8_1        
#> 10 South … ZAF         ZA                       3 Northern … ZAF.8_1        
#> # … with more rows, and 9 more variables: adm_area_2 <chr>,
#> #   adm_area_2_code <chr>, adm_area_3 <chr>, adm_area_3_code <chr>, gid <chr>,
#> #   latitude <dbl>, longitude <dbl>, properties <chr>, geometry <chr>
```

The `administrative_division` table contains rows of information on
**longitude** and **latitude** for several countries and for
administrative divisions (up to level 3) within some of these countries.
In addition, each row of geographical area available in this table has
area borders information in [simple
features](https://en.wikipedia.org/wiki/Simple_Features) format.

The **longitude** and **latitude** information can be easily accessed
and utilised for mapping point locations using the `get_table` function.
However, the area borders information in [simple
features](https://en.wikipedia.org/wiki/Simple_Features) format require
specific parsing to be usable in [R](https://www.r-project.org). This is
facilitated using the `sf` package. The `oxcovid19` package provides the
`get_layer` function which is a wrapper function around the `st_read`
function in the `sf` package to read [simple
features](https://en.wikipedia.org/wiki/Simple_Features) format data
into [R](https://www.r-project.org).

To query the `administrative_division` table for the area borders data,
the function `get_layer` is used as follows:

``` r
connect_oxcovid19() %>% get_layer(ccode = "GBR", adm = 0)
#> Simple feature collection with 1 feature and 14 fields
#> geometry type:  MULTIPOLYGON
#> dimension:      XY
#> bbox:           xmin: -8.151357 ymin: 49.95847 xmax: 1.764168 ymax: 60.84583
#> geographic CRS: WGS 84
#>          country countrycode countrycode_alpha2 adm_level adm_area_1
#> 1 United Kingdom         GBR                 GB         0       <NA>
#>   adm_area_1_code adm_area_2 adm_area_2_code adm_area_3 adm_area_3_code gid
#> 1            <NA>       <NA>            <NA>       <NA>            <NA> GBR
#>   latitude longitude                                   properties
#> 1 54.16473 -2.895751 {"GID_0": "GBR", "NAME_0": "United Kingdom"}
#>                         geometry
#> 1 MULTIPOLYGON (((-5.867211 5...
```

The `get_layer` function requires two main parameters. First, the
country from which area borders are required need to be specified using
its three-letter ISO code. In the example above, the ISO code `GBR` is
used to specify the country United Kingdom. Second, the administrative
division level should be indicated. This should be specified as a
numeric value from 0 to 3 corresponding to country level borders (0),
administrative level 1 borders such as regions or provinces (1),
administrative level 2 borders such as districts or communes (2), and
administrative level 3 borders such as sub-districts or sub-communes
(3). In the example above, 0 is specified for country borders.

Once the area borders have been read into [R](https://www.r-project.org)
using the `get_layer` function, further spatial data manipulation and
processing can be done using other `sf` package functions. Further
information on the `sf` package can be found
[here](https://r-spatial.github.io/sf/).

### Specialised functions

`oxcovid19` includes four specialised wrapper functions that facilitate
easy access and query of specific tables available in the [OxCOVID19
Database](https://covid19.eng.ox.ac.uk/) and reads the data into
[R](https://www.r-project.org). These functions start with the
`get_data_` prefix followed by the respective table descriptor.

| **Function**            | **Description**                         |
| :---------------------- | :-------------------------------------- |
| `get_data_epidemiology` | Get data from epidemiology table        |
| `get_data_weather`      | Get data from weather table             |
| `get_data_mobility`     | Get data from mobility table            |
| `get_data_response`     | Get data from government response table |

Each of these `get_data_` functions can be supplied with specific query
parameters to further refine the data to retrieve from the remote table.

| **Query parameters** | **Description**                                                            |
| :------------------- | :------------------------------------------------------------------------- |
| `.source`            | Query the table via the `source` field                                     |
| `ccode`              | Query the table via the `countrycode` field                                |
| `start`, `end`       | Query the table via the `date` field                                       |
| `adm`                | Query the table via the `adm_area_1`, `adm_area_2` and `adm_area_3` fields |

## Limitations

The `oxcovid19` package is in active development which will be dictated
by the evolution of the [OxCOVID19
Database](https://covid19.eng.ox.ac.uk/) over time. Whilst every attempt
will be employed to maintain syntax of current functions, it is possible
that current functions may change syntax or operability in order to
ensure relevance or maybe deprecated in lieu of a more appropriate
and/or more performant function. In either of these cases, any change
will be well-documented and explained to users and deprecation will be
staged in such a way that users will be informed in good time to allow
for transition to using the new functions.

## Citations

If you find [OxCOVID19 Database](https://covid19.eng.ox.ac.uk/) useful
please cite:

Adam Mahdi, Piotr Błaszczyk, Paweł Dłotko, Dario Salvi, Tak-Shing Chan,
John Harvey, Davide Gurnari, Yue Wu, Ahmad Farhat, Niklas Hellmer,
Alexander Zarebski, Bernie Hogan, Lionel Tarassenko, **Oxford COVID-19
Database: a multimodal data repository for better understanding the
global impact of COVID-19**. University of Oxford, 2020. medRxiv (doi:
<https://doi.org/10.1101/2020.08.18.20177147>).

The [OxCOVID19 Database](https://covid19.eng.ox.ac.uk/) is the result of
many hours of volunteer efforts and generous contributions of many
organisations. If you use a specific table please also cite the
underlying source as described
[here](https://covid19.eng.ox.ac.uk/data_sources.html). Sources of
specific tables can also be accessed via the `oxcovid19` package through
the `data_sources` dataset. For example, if you have accessed the
**Epidemiology** table from the database, you can access the sources for
this table with:

``` r
data_sources[["epidemiology"]]
```

which gives the following result:

    #> # A tibble: 63 x 5
    #>    Country   `Source code` Source        Features           `Terms of Use`      
    #>    <chr>     <chr>         <chr>         <chr>              <chr>               
    #>  1 Australia AUS_C1A       covid-19-au.… "tested, confirme… "Strictly for educa…
    #>  2 Belgium   BEL_LE        Laurent Esch… "confirmed (count… "CC0 1.0 Universal …
    #>  3 Belgium   BEL_SCI       Epistat       ""                 ""                  
    #>  4 Brazil    BRA_MSHM      Ministerio d… "confirmed (count… "CC0 1.0 Universal" 
    #>  5 Canada    CAN_GOV       Government o… "tested, confirme… "Attribution requir…
    #>  6 Switzerl… CHE_OPGOV     Swiss Canton… ""                 "CC 4.0"            
    #>  7 Mainland… CHN_ICL       MRC Centre f… "confirmed (both … "CC BY NC ND 4.0"   
    #>  8 Germany   DEU_JPGG      Jan-Philip G… "confirmed, dead"  "MIT"               
    #>  9 Spain     ESP_MS        Ministerio d… "confirmed, dead,… "\"Desnaturalizacio…
    #> 10 Spain     ESP_MSVP      Ministerio d… "confirmed, recov… "Apache License 2.0"
    #> # … with 53 more rows

A utility function called `cite_sources` is also available. This
function is applied to a dataset extracted from the [OxCOVID19
Database](https://covid19.eng.ox.ac.uk/) using the `get_data` functions
or a dataset that has been collected after using `get_table` function.
For example:

``` r
## Get epidemiology data for UK
gbr_epi_tab <- get_data_epidemiology(ccode = "UK")

## Cite sources for UK epidemiology data
cite_sources(gbr_epi_tab)
```

This results in:

    #> Please cite the following source/s and follow respective Terms of Use:
    #> # A tibble: 8 x 3
    #>   Table      Source                                      `Terms of Use`         
    #>   <chr>      <chr>                                       <chr>                  
    #> 1 Epidemiol… Department of Health (Northern Ireland)     ""                     
    #> 2 Epidemiol… Public Health England                       "Open Government Licen…
    #> 3 Epidemiol… Scottish Government                         "GPL 3.0"              
    #> 4 Epidemiol… Tom White                                   "The Unlicense"        
    #> 5 Epidemiol… Public Health Wales                         "Open Government Licen…
    #> 6 Epidemiol… European Centre for Disease Prevention and… "Attribution required" 
    #> 7 Epidemiol… World Health Organization                   ""                     
    #> 8 Epidemiol… Center for Systems Science and Engineering… "CC BY 4.0"
