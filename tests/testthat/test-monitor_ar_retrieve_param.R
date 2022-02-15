test_that("monitor_ar_retrieve works!", {

  csv_path <- file.path(tempdir(), "cetesb-data")
  dir.create(csv_path)

  ca_o3 <- monitor_ar_retrieve_param(start_date = "01/02/2015",
                                     end_date   = "01/03/2015",
                                     aqs_code   = "CA",
                                     parameters = "O3",
                                     to_csv     = TRUE,
                                     csv_path = csv_path)
  # Testing writing output
  expect_equal(TRUE,
               file.exists(
                 paste0(csv_path,
                        "/ESTACAO CENTRO_O3_01-02-2015_01-03-2015.csv")
               ))

  # Testing data.frame output
  expect_equal(ncol(ca_o3), 3)
  expect_equal(nrow(ca_o3), 672)

  # Testing data.frame values
  o3_mean <- mean(ca_o3$o3, na.rm = TRUE)
  expect_equal(o3_mean > 22, o3_mean < 23)

  # Testing data.frame classes
  expect_equal(TRUE,  "data.frame" %in% class(ca_o3))
  expect_equal(TRUE,  "character" %in% class(ca_o3$aqs))
  expect_equal(TRUE,  "POSIXct" %in% class(ca_o3$date))
  expect_equal(TRUE,  "numeric" %in% class(ca_o3$o3))
})
