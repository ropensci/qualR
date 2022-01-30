test_that("CetesbRetrieveMetPol", {

  load("sysdata.rda")

  pinheiros <- cetesb_retrieve_met_pol(u,p,aqs_code = 99,
                                       start_date   = "01/01/2020",
                                       end_date     = "07/01/2020")

  expect_equal(ncol(pinheiros), 14)

  expect_equal(TRUE,  "data.frame" %in% class(pinheiros))
  expect_equal(TRUE,  "numeric" %in% class(pinheiros$tc))
  expect_equal(TRUE,  "numeric" %in% class(pinheiros$rh))
  expect_equal(TRUE,  "numeric" %in% class(pinheiros$ws))
  expect_equal(TRUE,  "numeric" %in% class(pinheiros$wd))
  expect_equal(TRUE,  "numeric" %in% class(pinheiros$p))
  expect_equal(TRUE,  "numeric" %in% class(pinheiros$o3))
  expect_equal(TRUE,  "numeric" %in% class(pinheiros$no))
  expect_equal(TRUE,  "numeric" %in% class(pinheiros$no2))
  expect_equal(TRUE,  "numeric" %in% class(pinheiros$nox))
  expect_equal(TRUE,  "numeric" %in% class(pinheiros$co))
  expect_equal(TRUE,  "numeric" %in% class(pinheiros$pm10))
  expect_equal(TRUE,  "numeric" %in% class(pinheiros$pm25))
  expect_equal(TRUE,  "character" %in% class(pinheiros$aqs))
})
