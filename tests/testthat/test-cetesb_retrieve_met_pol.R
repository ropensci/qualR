test_that("cetesb_retrieve_met_pol works!", {

  pinheiros <- cetesb_retrieve_met_pol(u,p,aqs_code = 99,
                                       start_date   = "01/01/2020",
                                       end_date     = "07/01/2020")

  # Testing data.frame dims
  expect_equal(ncol(pinheiros), 14)
  expect_equal(nrow(pinheiros), 169)

  # Testing data.frame values
  param_means<- colMeans(pinheiros[, 2:13], na.rm = TRUE)
  expect_equal(param_means["tc"] > 23, param_means["tc"] < 24)
  expect_equal(param_means["rh"] > 74, param_means["rh"] < 75)
  expect_equal(param_means["ws"] > 1, param_means["ws"] < 2)
  expect_equal(param_means["wd"] > 238, param_means["wd"] < 239)
  expect_equal(param_means["o3"] > 27, param_means["o3"] < 28)
  expect_equal(param_means["no"] > 8, param_means["no"] < 9)
  expect_equal(param_means["no2"] > 26, param_means["no2"] < 27)
  expect_equal(param_means["nox"] > 20, param_means["nox"] < 21)
  expect_equal(param_means["co"] > 0.3, param_means["co"] < 0.4)
  expect_equal(param_means["pm10"] > 19, param_means["pm10"] < 20)
  expect_equal(param_means["pm25"] > 5, param_means["pm25"] < 7)

  # Testing data.frame classes
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
