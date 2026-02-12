test_that("dtm is a sparse matrix", {
  expect_s4_class(dtm, "dgCMatrix")
})

test_that("dtm has expected dimensions", {
  # Rows = text units, columns = unique lemmas
  expect_equal(nrow(dtm), 5777)
  expect_gt(ncol(dtm), 10000)
})

test_that("dtm has row names matching text IDs", {
  expect_equal(rownames(dtm), texts$id)
})

test_that("dtm values are non-negative frequencies", {
  expect_true(all(dtm@x >= 0))
  expect_true(all(dtm@x <= 1))
})
