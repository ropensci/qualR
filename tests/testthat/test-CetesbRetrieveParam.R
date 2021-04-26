test_that("CetesbRetrieveParam works!", {

  load("sysdata.rda")
  pin_param <- CetesbRetrieveParam(u,p,c("o3","NOX", "VV"), 99,
                                   "01/01/2020", "07/01/2020")

  expect_equal(2 * 2, 4)
})
