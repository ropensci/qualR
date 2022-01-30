test_that("CetesbRetrieveParam works!", {

  load("sysdata.rda")

  csv_path <- file.path(tempdir(), "cetesb-data2")
  dir.create(csv_path)

  pin_param <- cetesb_retrieve_param(u,p,c("o3","NOX", "VV"), 99,
                                     "01/01/2020", "07/01/2020",
                                     to_csv = TRUE, csv_path = csv_path)

  expect_equal(TRUE,
               file.exists(
                 paste0(csv_path,
                        "/Pinheiros_O3_NOX_VV_01-01-2020_07-01-2020.csv")
    ))
})
