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
  expect_equal(TRUE,  "data.frame" %in% class(ca_met))
  expect_equal(TRUE,  "character" %in% class(ca_met$aqs))
  expect_equal(TRUE,  "POSIXct" %in% class(ca_met$date))
  expect_equal(TRUE,  "numeric" %in% class(ca_met$tc))
  expect_equal(TRUE,  "numeric" %in% class(ca_met$rh))
  expect_equal(TRUE,  "numeric" %in% class(ca_met$ws))
  expect_equal(TRUE,  "numeric" %in% class(ca_met$wd))
  expect_equal(TRUE,  "numeric" %in% class(ca_met$p))

})
