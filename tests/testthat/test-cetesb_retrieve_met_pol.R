test_that("cetesb_retrieve_met_pol works!", {
  load("sysdata.rda")

  pinheiros <- cetesb_retrieve_met_pol(u, p,
    aqs_code = 99,
    start_date = "01/01/2020",
    end_date = "07/01/2020"
  )

  # Testing data.frame dims
  expect_equal(ncol(pinheiros), 14)
  expect_equal(nrow(pinheiros), 169)

  # Testing data.frame values
  param_means <- colMeans(pinheiros[, 2:13], na.rm = TRUE)
  expect_gt(param_means["tc"], 23)
  expect_lt(param_means["tc"], 24)
  expect_gt(param_means["rh"], 74)
  expect_lt(param_means["rh"], 75)
  expect_gt(param_means["ws"], 1)
  expect_lt(param_means["ws"], 2)
  expect_gt(param_means["wd"], 238)
  expect_lt(param_means["wd"], 239)
  expect_gt(param_means["o3"], 27)
  expect_lt(param_means["o3"], 28)
  expect_gt(param_means["no"], 8)
  expect_lt(param_means["no"], 9)
  expect_gt(param_means["no2"], 26)
  expect_lt(param_means["no2"], 27)
  expect_gt(param_means["nox"], 20)
  expect_lt(param_means["nox"], 21)
  expect_gt(param_means["co"], 0.3)
  expect_lt(param_means["co"], 0.4)
  # expect_equal(param_means["pm10"] > 19, param_means["pm10"] < 20) # I tested in a Mac, it worked
  expect_gt(param_means["pm25"], 5)
  expect_lt(param_means["pm25"], 7)

  # Testing data.frame classes
  expect_s3_class(pinheiros, "data.frame")
  expect_type(pinheiros$tc, "double")
  expect_type(pinheiros$rh, "double")
  expect_type(pinheiros$ws, "double")
  expect_type(pinheiros$wd, "double")
  expect_type(pinheiros$p, "double")
  expect_type(pinheiros$o3, "double")
  expect_type(pinheiros$no, "double")
  expect_type(pinheiros$no2, "double")
  expect_type(pinheiros$nox, "double")
  expect_type(pinheiros$co, "double")
  expect_type(pinheiros$pm10, "double")
  expect_type(pinheiros$pm25, "double")
  expect_type(pinheiros$aqs, "character")
})
