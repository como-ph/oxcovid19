x <- connect_oxcovid19()

test_that("connection is a PqConnection class object", {
  expect_is(x, "PqConnection")
})
