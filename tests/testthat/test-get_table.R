x <- connect_oxcovid19() %>%
  get_table(tbl_name = "epidemiology")

test_that("get_table output is class tbl_PqConnection object", {
  expect_is(x, "tbl_PqConnection")
})

test_that("warning works", {
  expect_error(connect_oxcovid19() %>% get_table(tbl_name = "epi"))
})
