test_that("CetesbRetrieveMet works", {

  load("sysdata.rda")

  pin_met <- cetesb_retrieve_met(u,p,aqs_code = 99,
                                 start_date   = "01/01/2020",
                                 end_date     = "07/01/2020")

  # Testing data.frame dims
  expect_equal(ncol(pin_met), 7)
  expect_equal(nrow(pin_met), 169)

  # Testing data.frame values
  param_means<- colMeans(pin_met[, 2:6], na.rm = TRUE)
  expect_equal(param_means["tc"] > 23, param_means["tc"] < 24)
  expect_equal(param_means["rh"] > 74, param_means["rh"] < 75)
  expect_equal(param_means["ws"] > 1, param_means["ws"] < 2)
  expect_equal(param_means["wd"] > 238, param_means["wd"] < 239)

  # Testing data.frame classes
  expect_equal(TRUE,  "data.frame" %in% class(pin_met))
  expect_equal(TRUE,  "character" %in% class(pin_met$aqs))
  expect_equal(TRUE,  "POSIXct" %in% class(pin_met$date))
  expect_equal(TRUE,  "numeric" %in% class(pin_met$tc))
  expect_equal(TRUE,  "numeric" %in% class(pin_met$rh))
  expect_equal(TRUE,  "numeric" %in% class(pin_met$ws))
  expect_equal(TRUE,  "numeric" %in% class(pin_met$wd))
  expect_equal(TRUE,  "numeric" %in% class(pin_met$p))
})
