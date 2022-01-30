test_that("CetesbRetrievePol.R works", {

  load("sysdata.rda")

  pin_pol <- cetesb_retrieve_pol(u,p,aqs_code = "Pinheiros",
                                 start_date   = "01/01/2020",
                                 end_date     = "07/01/2020")

  co_mean <- mean(pin_pol$co, na.rm = TRUE)
  expect_equal(co_mean > 0.3, co_mean < 0.4)
})
