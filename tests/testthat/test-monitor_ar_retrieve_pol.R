test_that("monitor_ar_retrieve_pol works!", {

  start_date <- "01/01/2020"
  end_date   <- "07/01/2020"
  ca_pol     <- monitor_ar_retrieve_pol(start_date, end_date, "CA")

  # Testing data.frame dims
  expect_equal(ncol(ca_pol), 9)
  expect_equal(TRUE, nrow(ca_pol) >= 144)

  # Testing data.frame values
  pol_means<- colMeans(ca_pol[, 2:8], na.rm = TRUE)
  expect_equal(pol_means["o3"] > 33, pol_means["o3"] < 35)
  expect_equal(pol_means["co"] > 0.5, pol_means["co"] < 0.6)
  expect_equal(pol_means["pm10"] > 21, pol_means["pm10"] < 22)

  # Testind data.frame classes
  expect_equal(TRUE,  "data.frame" %in% class(ca_pol))
  expect_equal(TRUE,  "POSIXct" %in% class(ca_pol$date))
  expect_equal(TRUE,  "numeric" %in% class(ca_pol$o3))
  expect_equal(TRUE,  "numeric" %in% class(ca_pol$no))
  expect_equal(TRUE,  "numeric" %in% class(ca_pol$no2))
  expect_equal(TRUE,  "numeric" %in% class(ca_pol$nox))
  expect_equal(TRUE,  "numeric" %in% class(ca_pol$co))
  expect_equal(TRUE,  "numeric" %in% class(ca_pol$pm10))
  expect_equal(TRUE,  "numeric" %in% class(ca_pol$pm25))
  expect_equal(TRUE,  "character" %in% class(ca_pol$aqs))

})
