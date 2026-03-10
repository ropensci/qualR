test_that("cetesb_retrieve_param works!", {
  load("sysdata.rda")

  csv_path <- file.path(tempdir(), "cetesb-data2")
  dir.create(csv_path)

  pin_param <- cetesb_retrieve_param(u, p, c("o3", "NOX", "VV"), 99,
    "01/01/2020", "07/01/2020",
    to_csv = TRUE, csv_path = csv_path
  )
  # Testing writing output
  expect_equal(
    TRUE,
    file.exists(
      paste0(
        csv_path,
        "/Pinheiros_O3_NOX_VV_01-01-2020_07-01-2020.csv"
      )
    )
  )

  # Testing data.frame dims
  expect_equal(ncol(pin_param), 5)
  expect_equal(nrow(pin_param), 169)

  # Testing data.frame values
  param_means <- colMeans(pin_param[, 3:5], na.rm = TRUE)
  expect_gt(param_means["nox"], 20)
  expect_lt(param_means["nox"], 21)
  expect_gt(param_means["o3"], 27)
  expect_lt(param_means["o3"], 28)
  expect_gt(param_means["ws"], 1)
  expect_lt(param_means["ws"], 2)

  # Testing data.frame classes
  expect_s3_class(pin_param, "data.frame")
  expect_type(pin_param$aqs, "character")
  expect_type(pin_param$o3, "double")
  expect_type(pin_param$nox, "double")
  expect_type(pin_param$ws, "double")
})
