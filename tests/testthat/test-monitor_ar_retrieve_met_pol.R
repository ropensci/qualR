test_that("multiplication works", {

  start_date <- "01/01/2020"
  end_date   <- "07/01/2020"
  ca_all     <- monitor_ar_retrieve_met_pol(start_date, end_date, "CA")

  expect_equal(ncol(ca_all), 14)
  expect_equal(TRUE,  "data.frame" %in% class(ca_all))
  expect_equal(TRUE,  "numeric" %in% class(ca_all$tc))
  expect_equal(TRUE,  "numeric" %in% class(ca_all$rh))
  expect_equal(TRUE,  "numeric" %in% class(ca_all$ws))
  expect_equal(TRUE,  "numeric" %in% class(ca_all$wd))
  expect_equal(TRUE,  "numeric" %in% class(ca_all$p))
  expect_equal(TRUE,  "numeric" %in% class(ca_all$o3))
  expect_equal(TRUE,  "numeric" %in% class(ca_all$no))
  expect_equal(TRUE,  "numeric" %in% class(ca_all$no2))
  expect_equal(TRUE,  "numeric" %in% class(ca_all$nox))
  expect_equal(TRUE,  "numeric" %in% class(ca_all$co))
  expect_equal(TRUE,  "numeric" %in% class(ca_all$pm10))
  expect_equal(TRUE,  "numeric" %in% class(ca_all$pm25))
  expect_equal(TRUE,  "character" %in% class(ca_all$aqs))
})
