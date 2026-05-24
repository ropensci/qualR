test_that("cetesb_retrieve_met works!", {
  load("sysdata.rda")

  pin_met <- cetesb_retrieve_met(u, p,
    aqs_code = 99,
    start_date = "01/01/2020",
    end_date = "07/01/2020"
  )

  # Testing data.frame dims
  expect_equal(ncol(pin_met), 7)
  expect_equal(nrow(pin_met), 169)

  # Testing data.frame values
  param_means <- colMeans(pin_met[, 2:6], na.rm = TRUE)
  expect_gt(param_means["tc"], 23)
  expect_lt(param_means["tc"], 24)
  expect_gt(param_means["rh"], 74)
  expect_lt(param_means["rh"], 75)
  expect_gt(param_means["ws"], 1)
  expect_lt(param_means["ws"], 2)
  expect_gt(param_means["wd"], 238)
  expect_lt(param_means["wd"],239)

  # Testing data.frame classes
  expect_s3_class(pin_met, "data.frame")
  expect_type(pin_met$aqs, "character")
  expect_s3_class(pin_met$date, "POSIXct")
  expect_type(pin_met$tc, "double")
  expect_type(pin_met$rh, "double")
  expect_type(pin_met$ws, "double")
  expect_type(pin_met$wd, "double")
  expect_type(pin_met$p, "double")
})
