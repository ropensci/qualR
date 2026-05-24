test_that("monitor_ar_retrieve_met_pol works!", {
  start_date <- "01/01/2020"
  end_date <- "07/01/2020"
  ca_all <- monitor_ar_retrieve_met_pol(start_date, end_date, "CA")

  # Testing data.frame dims
  expect_equal(ncol(ca_all), 14)
  expect_equal(TRUE, ncol(ca_all) <= 145)

  # Testing data.frame values
  all_means <- colMeans(ca_all[, 2:13], na.rm = TRUE)
  expect_gt(all_means["tc"], 28)
  expect_lt(all_means["tc"], 29)
  expect_gt(all_means["rh"], 74)
  expect_lt(all_means["rh"], 75)
  expect_gt(all_means["ws"], 0.8)
  expect_lt(all_means["ws"], 0.9)
  expect_gt(all_means["p"], 1007)
  expect_lt(all_means["p"], 1008)
  expect_gt(all_means["o3"], 33)
  expect_lt(all_means["o3"], 35)
  expect_gt(all_means["co"], 0.5)
  expect_lt(all_means["co"], 0.6)
  expect_gt(all_means["pm10"], 21)
  expect_lt(all_means["pm10"], 22)


  # expect_equal(all_means["tc"] > 28, all_means["tc"] < 29)
  # expect_equal(all_means["rh"] > 74, all_means["rh"] < 75)
  # expect_equal(all_means["ws"] > 0.8, all_means["ws"] < 0.9)
  # expect_equal(all_means["wd"] > 157, all_means["wd"] < 159)
  # expect_equal(all_means["p"] > 1007, all_means["p"] < 1008)
  # expect_equal(all_means["o3"] > 33, all_means["o3"] < 35)
  # expect_equal(all_means["co"] > 0.5, all_means["co"] < 0.6)
  # expect_equal(all_means["pm10"] > 21, all_means["pm10"] < 23)

  # Testing data.frame classes
  expect_s3_class(ca_all, "data.frame")
  expect_s3_class(ca_all$date, "POSIXct")
  expect_type(ca_all$tc, "double")
  expect_type(ca_all$rh, "double")
  expect_type(ca_all$ws, "double")
  expect_type(ca_all$wd, "double")
  expect_type(ca_all$p, "double")
  expect_type(ca_all$o3, "double")
  expect_type(ca_all$no, "double")
  expect_type(ca_all$no2, "double")
  expect_type(ca_all$nox, "double")
  expect_type(ca_all$co, "double")
  expect_type(ca_all$pm10, "double")
  expect_type(ca_all$pm25, "double")
  expect_type(ca_all$aqs, "character")
})
