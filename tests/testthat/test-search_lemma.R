test_that("search_lemma returns data frame", {
  result <- search_lemma("dhamma")
  expect_s3_class(result, "data.frame")
  expect_named(result, c("word", "n", "total", "freq", "id", "collection", "pitaka"))
})

test_that("search_lemma finds common lemma", {
  result <- search_lemma("dhamma")
  expect_gt(nrow(result), 100)
  expect_true(all(result$word == "dhamma"))
})

test_that("search_lemma returns empty for nonexistent lemma", {
  result <- search_lemma("xyznonexistent")
  expect_equal(nrow(result), 0)
})

test_that("search_lemma results sorted by freq descending", {
  result <- search_lemma("buddha")
  if (nrow(result) > 1) {
    expect_true(all(diff(result$freq) <= 0))
  }
})
