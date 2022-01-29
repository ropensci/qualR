test_that("multiplication works", {

  start_date <- "01/01/2020"
  end_date   <- "07/01/2020"
  ca_met     <- MonitorArRetrieveMet(start_date, end_date, "CA")

  expect_equal(ncol(ca_met), 7)
  expect_equal(nrow(ca_met), 144)

})
