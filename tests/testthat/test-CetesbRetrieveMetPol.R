test_that("CetesbRetrieveMetPol", {

  load("sysdata.rda")

  pinheiros <- CetesbRetrieveMetPol(u,p,aqs_code = 99,
                                    start_date   = "01/01/2020",
                                    end_date     = "07/01/2020")

  expect_equal(ncol(pinheiros), 14)
})
