test_that("multiplication works", {

  start_date <- "01/01/2020"
  end_date   <- "07/01/2020"
  ca_pol     <- MonitorArRetrievePol(start_date, end_date, "CA")

  co_mean <- mean(ca_pol, na.rm = TRUE)
  expect_equal(co_mean > 0.5, co_mean < 0.52)
})
