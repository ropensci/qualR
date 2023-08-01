test_that("monitor_ar_retrieve_met_pol works!", {

  start_date <- "01/01/2020"
  end_date   <- "07/01/2020"
  ca_all     <- monitor_ar_retrieve_met_pol(start_date, end_date, "CA")

  # Testing data.frame dims
  expect_equal(ncol(ca_all), 14)
  expect_equal(TRUE, ncol(ca_all) <= 145)

  # Testing data.frame values
  all_means<- colMeans(ca_all[, 2:13], na.rm = TRUE)
  expect_equal(all_means["tc"] > 28, all_means["tc"] < 29)
  expect_equal(all_means["rh"] > 74, all_means["rh"] < 75)
  expect_equal(all_means["ws"] > 0.8, all_means["ws"] < 0.9)
  expect_equal(all_means["wd"] > 157, all_means["wd"] < 159)
  expect_equal(all_means["p"] > 1007, all_means["p"] < 1008)
  expect_equal(all_means["o3"] > 33, all_means["o3"] < 35)
  expect_equal(all_means["co"] > 0.5, all_means["co"] < 0.6)
  expect_equal(all_means["pm10"] > 22, all_means["pm10"] < 23)

  # Testing data.frame classes
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
