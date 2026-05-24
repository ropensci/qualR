test_that("cetesb_retrieve_pol works!", {
  load("sysdata.rda")

  pin_pol <- cetesb_retrieve_pol(u, p,
    aqs_code = "Pinheiros",
    start_date = "01/01/2020",
    end_date = "07/01/2020"
  )
  # Testing data.frame dims
  expect_equal(ncol(pin_pol), 9)
  expect_equal(nrow(pin_pol), 169)

  # Testing data.frame values
  pol_means <- colMeans(pin_pol[, 2:8], na.rm = TRUE)
  expect_gt(pol_means["o3"], 27)
  expect_lt(pol_means["o3"], 28)
  expect_gt(pol_means["no"], 8)
  expect_lt(pol_means["no"], 9)
  expect_gt(pol_means["no2"], 26)
  expect_lt(pol_means["no2"], 27)
  expect_gt(pol_means["nox"], 20)
  expect_lt(pol_means["nox"], 21)
  expect_gt(pol_means["co"], 0.3)
  expect_lt(pol_means["co"], 0.4)
  expect_gt(pol_means["pm10"], 19)
  expect_lt(pol_means["pm10"], 20)
  expect_gt(pol_means["pm25"], 5)
  expect_lt(pol_means["pm25"], 6)

  # Testing data.frame classes
  expect_s3_class(pin_pol, "data.frame")
  expect_s3_class(pin_pol$date, "POSIXct")
  expect_type(pin_pol$o3, "double")
  expect_type(pin_pol$no, "double")
  expect_type(pin_pol$no2, "double")
  expect_type(pin_pol$nox, "double")
  expect_type(pin_pol$co, "double")
  expect_type(pin_pol$pm10, "double")
  expect_type(pin_pol$pm25, "double")
  expect_type(pin_pol$aqs, "character")
})
