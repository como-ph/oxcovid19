
test_that("layer is sf class", {
  expect_is(get_layer(con = connect_oxcovid19(),
                      ccode = "CHN",
                      adm = 1),
            "sf")
})
