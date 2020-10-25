x <- get_data(tbl_name = "epidemiology",
              .source = "WRD_ECDC",
              ccode = "GBR",
              adm = 0)

test_that("get_data output is tbl", {
  expect_is(x, "tbl")
})

test_that("get_data retrieves correct country data", {
  expect_equal(unique(x$countrycode), "GBR")
})

x <- get_data_epidemiology(.source = "WRD_ECDC",
                           ccode = "UK",
                           adm = 0)

test_that("get_data output is tbl", {
  expect_is(x, "tbl")
})

test_that("get_data retrieves correct country data", {
  expect_equal(unique(x$countrycode), "GBR")
})


x <- get_data_weather(ccode = "Spain", adm = 1)

test_that("get_data output is tbl", {
  expect_is(x, "tbl")
})

test_that("get_data retrieves correct country data", {
  expect_equal(unique(x$countrycode), "ESP")
})


x <- get_data_mobility(.source = "APPLE_MOBILITY", ccode = "FR", adm = 0)

test_that("get_data output is tbl", {
  expect_is(x, "tbl")
})

test_that("get_data retrieves correct country data", {
  expect_equal(unique(x$countrycode), "FRA")
})


x <- get_data_response(ccode = "Philippines", adm = 0)

test_that("get_data output is tbl", {
  expect_is(x, "tbl")
})

test_that("get_data retrieves correct country data", {
  expect_equal(unique(x$countrycode), "PHL")
})
