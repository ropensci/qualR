test_that("MonitorArRetrieve works", {

  # current_folder <- getwd()
  # on.exit(setwd(current_folder), add = T)

  csv_path <- dir.create(file.path(tempdir(), "cetesb-data"))
  # setwd(file.path(tempdir(), "cetesb-data"))

  ca_o3 <- MonitorArRetrieveParam(start_date = "01/02/2015",
                                  end_date   = "01/03/2015",
                                  aqs_code   = "CA",
                                  parameters = "O3",
                                  to_csv     = TRUE, csv_path = csv_path)

  expect_equal(ncol(ca_o3),3)
})
