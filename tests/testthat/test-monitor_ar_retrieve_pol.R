test_that("monitor_ar_retrieve_pol works!", {
  start_date <- "01/01/2020"
  end_date <- "07/01/2020"
  ca_pol <- monitor_ar_retrieve_pol(start_date, end_date, "CA")

  # Testing data.frame dims
  expect_equal(ncol(ca_pol), 9)
  expect_equal(TRUE, nrow(ca_pol) >= 144)

  # Testing data.frame values
  pol_means <- colMeans(ca_pol[, 2:8], na.rm = TRUE)
  expect_gt(pol_means["o3"], 33)
  expect_lt(pol_means["o3"], 35)
  expect_gt(pol_means["co"], 0.5)
  expect_lt(pol_means["co"], 0.6)
  expect_gt(pol_means["pm10"], 21)
  expect_lt(pol_means["pm10"], 23)

  # Testing data.frame classes
  expect_s3_class(ca_pol, "data.frame")
  expect_s3_class(ca_pol$date, "POSIXct")
  expect_type(ca_pol$o3, "double")
  expect_type(ca_pol$no, "double")
  expect_type(ca_pol$no2, "double")
  expect_type(ca_pol$nox, "double")
  expect_type(ca_pol$co, "double")
  expect_type(ca_pol$pm10, "double")
  expect_type(ca_pol$pm25, "double")
  expect_type(ca_pol$aqs, "character")
})
