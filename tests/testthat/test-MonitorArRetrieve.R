test_that("MonitorArRetrieve works", {
  ca_o3 <- MonitorArRetrieve(start_date = "01/02/2019",
                             end_date   = "01/03/2019",
                             aqs_code   = "CA",
                             param      = "O3")

  expect_equal(673,nrow(ca_o3))
})
