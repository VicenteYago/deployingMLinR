test_that("outputIsMatrix?", {
  pred = getPred.lm.boston(lstat = c(5,10,15), age = c(80, 90, 100))
  expect_identical(class(pred), "data.frame")
})




