

test_that("list_tables produces list", {
  expect_is(list_tables(), "character")
})

test_that("list_fields produces list", {
  expect_is(list_fields(), "list")
})
