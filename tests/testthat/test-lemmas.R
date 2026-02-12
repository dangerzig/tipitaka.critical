test_that("lemmas has expected structure", {
  expect_s3_class(lemmas, "data.frame")
  expect_named(lemmas, c("word", "n", "total", "freq", "id", "collection", "pitaka"))
})

test_that("lemmas has reasonable size", {
  # Should have many rows (one per lemma-per-text-unit)
  expect_gt(nrow(lemmas), 100000)
})

test_that("lemmas counts are positive integers", {
  expect_true(all(lemmas$n > 0))
  expect_true(all(lemmas$n == as.integer(lemmas$n)))
})

test_that("lemmas freq is between 0 and 1", {
  expect_true(all(lemmas$freq > 0))
  expect_true(all(lemmas$freq <= 1))
})

test_that("lemmas freq equals n/total", {
  expect_equal(lemmas$freq, lemmas$n / lemmas$total, tolerance = 1e-10)
})

test_that("common lemmas are present", {
  totals <- tapply(lemmas$n, lemmas$word, sum)
  top10 <- names(sort(totals, decreasing = TRUE))[1:10]
  expect_true("dhamma" %in% top10)
  expect_true("ca" %in% top10)
})

test_that("lemmas covers all collections", {
  collections <- sort(unique(lemmas$collection))
  expect_equal(collections, c("abhidhamma", "an", "dn", "kn", "mn", "sn", "vinaya"))
})
