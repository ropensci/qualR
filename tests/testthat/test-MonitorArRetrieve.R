test_that("MonitorArRetrieve works", {
  ca_o3 <- MonitorArRetrieve(start_date = "01/02/2019",
                             end_date   = "01/03/2019",
                             aqs_code   = "CA",
                             param      = "O3")

  expect_equal(ncol(ca_o3),3)
})
