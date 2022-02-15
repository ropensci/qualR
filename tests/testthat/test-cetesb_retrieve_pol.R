test_that("cetesb_retrieve_pol works!", {

  load("sysdata.rda")

  pin_pol <- cetesb_retrieve_pol(u,p,aqs_code = "Pinheiros",
                                 start_date   = "01/01/2020",
                                 end_date     = "07/01/2020")
  # Testing data.frame dims
  expect_equal(ncol(pin_pol), 9)
  expect_equal(nrow(pin_pol), 169)

  # Testing data.frame values
  pol_means<- colMeans(pin_pol[, 2:8], na.rm = TRUE)
  expect_equal(pol_means["o3"] > 27, pol_means["o3"] < 28)
  expect_equal(pol_means["no"] > 8, pol_means["no"] < 9)
  expect_equal(pol_means["no2"] > 26, pol_means["no2"] < 27)
  expect_equal(pol_means["nox"] > 20, pol_means["nox"] < 21)
  expect_equal(pol_means["co"] > 0.3, pol_means["co"] < 0.4)
  expect_equal(pol_means["pm10"] > 19, pol_means["pm10"] < 20)
  expect_equal(pol_means["pm25"] > 5, pol_means["pm25"] < 6)

  # Testing data.frame classes
  expect_equal(TRUE,  "data.frame" %in% class(pin_pol))
  expect_equal(TRUE,  "POSIXct" %in% class(pin_pol$date))
  expect_equal(TRUE,  "numeric" %in% class(pin_pol$o3))
  expect_equal(TRUE,  "numeric" %in% class(pin_pol$no))
  expect_equal(TRUE,  "numeric" %in% class(pin_pol$no2))
  expect_equal(TRUE,  "numeric" %in% class(pin_pol$nox))
  expect_equal(TRUE,  "numeric" %in% class(pin_pol$co))
  expect_equal(TRUE,  "numeric" %in% class(pin_pol$pm10))
  expect_equal(TRUE,  "numeric" %in% class(pin_pol$pm25))
  expect_equal(TRUE,  "character" %in% class(pin_pol$aqs))
})
