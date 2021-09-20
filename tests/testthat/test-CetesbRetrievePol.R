test_that("CetesbRetrievePol.R works", {

  load("sysdata.rda")

  pin_pol <- CetesbRetrievePol(u,p,aqs_code = "Pinheiros",
                               start_date   = "01/01/2020",
                               end_date     = "07/01/2020")

  expect_equal(ncol(pin_pol), 9)
})
