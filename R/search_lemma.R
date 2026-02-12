#' Search for Lemma Occurrences
#'
#' Finds all text units containing a specific lemma, sorted by frequency
#' (most frequent first).
#'
#' @param lemma Character string of the lemma to search for.
#' @return A data frame of occurrences with columns: word, n, total, freq,
#'   id, collection, pitaka. Returns an empty data frame if the lemma is
#'   not found.
#' @export
#'
#' @examples
#' \donttest{
#' # Find texts mentioning "nibbana"
#' nibbana <- search_lemma("nibbana")
#' head(nibbana)
#'
#' # Find texts mentioning "dhamma"
#' dhamma <- search_lemma("dhamma")
#' head(dhamma[, c("id", "collection", "n", "freq")])
#' }
#'
search_lemma <- function(lemma) {
  l <- lemmas
  result <- l[l$word == lemma, ]
  result[order(-result$freq), ]
}
