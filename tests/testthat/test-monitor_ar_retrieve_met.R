test_that("monitor_ar_retrieve_met works!", {

  start_date <- "01/01/2020"
  end_date   <- "07/01/2020"
  ca_met     <- monitor_ar_retrieve_met(start_date, end_date, "CA")

  # Testing data.frame dims
  expect_equal(ncol(ca_met), 7)
  expect_equal(TRUE, ncol(ca_met) <= 145)

  # Testing data.frame values
  met_means<- colMeans(ca_met[, 2:6], na.rm = TRUE)
  expect_equal(met_means["tc"] > 28, met_means["tc"] < 29)
  expect_equal(met_means["rh"] > 74, met_means["rh"] < 75)
  expect_equal(met_means["ws"] > 0.8, met_means["ws"] < 0.9)
  expect_equal(met_means["wd"] > 157, met_means["wd"] < 158)
  expect_equal(met_means["p"] > 1007, met_means["p"] < 1008)

  # Testing data.frame classes
  expect_s3_class(ca_met, 'data.frame')
  expect_s3_class(ca_met$date, 'POSIXct')
  expect_type(ca_met$tc, 'double')
  expect_type(ca_met$rh, 'double')
  expect_type(ca_met$ws, 'double')
  expect_type(ca_met$wd, 'double')
  expect_type(ca_met$p, 'double')
  expect_type(ca_met$aqs, 'character')
})
