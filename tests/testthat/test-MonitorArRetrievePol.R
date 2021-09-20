test_that("multiplication works", {

  start_date <- "01/01/2020"
  end_date   <- "07/01/2020"
  ca_pol     <- MonitorArRetrievePol(start_date, end_date, "CA")

  expect_equal(ncol(ca_pol), 9)
})
