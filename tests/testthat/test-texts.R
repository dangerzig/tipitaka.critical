test_that("texts has expected structure", {
  expect_s3_class(texts, "data.frame")
  expect_equal(ncol(texts), 6)
  expect_named(texts, c("id", "collection", "pitaka", "title", "text", "text_lemmatized"))
})

test_that("texts has expected row count", {
  expect_equal(nrow(texts), 5777)
})

test_that("texts covers all three pitakas", {
  pitakas <- sort(unique(texts$pitaka))
  expect_equal(pitakas, c("abhidhamma", "sutta", "vinaya"))
})

test_that("texts covers all seven collections", {
  collections <- sort(unique(texts$collection))
  expect_equal(collections, c("abhidhamma", "an", "dn", "kn", "mn", "sn", "vinaya"))
})

test_that("texts has no missing IDs", {
  expect_false(any(is.na(texts$id)))
  expect_false(any(texts$id == ""))
})

test_that("texts has no empty text fields", {
  expect_false(any(is.na(texts$text)))
  expect_false(any(texts$text == ""))
  expect_false(any(is.na(texts$text_lemmatized)))
  expect_false(any(texts$text_lemmatized == ""))
})

test_that("dn1 exists with expected content", {
  dn1 <- texts[texts$id == "dn1", ]
  expect_equal(nrow(dn1), 1)
  expect_equal(dn1$collection, "dn")
  expect_equal(dn1$pitaka, "sutta")
  expect_match(dn1$text, "eva.* me suta")
})
