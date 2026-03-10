test_that("monitor_ar_retrieve works!", {
  csv_folder <- withr::local_tempdir()

  ca_o3 <- monitor_ar_retrieve_param(
    start_date = "01/02/2015",
    end_date = "01/03/2015",
    aqs_code = "CA",
    parameters = "O3",
    to_csv = TRUE,
    csv_path = csv_folder
  )
  # Testing writing output
  expect_equal(
    TRUE,
    file.exists(
      paste0(
        csv_folder,
        "/ESTACAO CENTRO_O3_01-02-2015_01-03-2015.csv"
      )
    )
  )

  # Testing data.frame output
  expect_equal(ncol(ca_o3), 3)
  expect_equal(TRUE, nrow(ca_o3) >= 672)

  # Testing data.frame values
  o3_mean <- mean(ca_o3$o3, na.rm = TRUE)
  expect_gt(o3_mean, 22)
  expect_lt(o3_mean, 23)

  # Testing data.frame classes
  expect_s3_class(ca_o3, "data.frame")
  expect_s3_class(ca_o3$date, "POSIXct")
  expect_type(ca_o3$aqs, "character")
  expect_type(ca_o3$o3, "double")
})
