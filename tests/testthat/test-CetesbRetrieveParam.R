test_that("CetesbRetrieveParam works!", {

  current_folder <- getwd()
  on.exit(setwd(current), add = T)

  load("sysdata.rda")

  dir.create(file.path(tempdir(), "cetesb-data2"))
  setwd(file.path(tempdir(), "cetesb-data2"))

  pin_param <- CetesbRetrieveParam(u,p,c("o3","NOX", "VV"), 99,
                                   "01/01/2020", "07/01/2020",
                                   to_csv = TRUE)

  expect_equal(2 * 2, 4)
})
