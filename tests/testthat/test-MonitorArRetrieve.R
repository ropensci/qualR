test_that("MonitorArRetrieve works", {

  csv_path <- file.path(tempdir(), "cetesb-data")
  dir.create(csv_path)

  ca_o3 <- MonitorArRetrieveParam(start_date = "01/02/2015",
                                  end_date   = "01/03/2015",
                                  aqs_code   = "CA",
                                  parameters = "O3",
                                  to_csv     = TRUE, csv_path = csv_path)

  expect_equal(TRUE,
               file.exists(
                 paste0(csv_path,
                        "/ESTACAO CENTRO_O3_01-02-2015_01-03-2015.csv")
               ))
})
