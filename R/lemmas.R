#' Lemma Frequency Table
#'
#' Lemma frequency table computed from the lemmatized text.
#' Tokenizes \code{\link{texts}$text_lemmatized} and counts word
#' frequencies per text unit on first access (~5 seconds).
#'
#' @format A data frame with the variables:
#' \describe{
#'   \item{word}{Lemma (dictionary headword)}
#'   \item{n}{Count of this lemma in this text unit}
#'   \item{total}{Total lemma tokens in this text unit}
#'   \item{freq}{Frequency (n/total)}
#'   \item{id}{Text unit ID}
#'   \item{collection}{Collection code}
#'   \item{pitaka}{Pitaka name}
#' }
#' @export
#'
#' @examples
#' \donttest{
#' # First access triggers computation (~5 seconds)
#' head(lemmas)
#'
#' # Most frequent lemmas across the entire canon
#' totals <- tapply(lemmas$n, lemmas$word, sum)
#' head(sort(totals, decreasing = TRUE), 20)
#' }
#'
lemmas <- NULL

.compute_lemmas <- function() {
  txt <- get("texts", envir = asNamespace("tipitaka.critical"))
  rows <- vector("list", nrow(txt))

  for (i in seq_len(nrow(txt))) {
    words <- strsplit(txt$text_lemmatized[i], "\\s+")[[1]]
    words <- words[nzchar(words)]
    if (length(words) == 0) next

    counts <- table(words)
    total <- sum(counts)

    rows[[i]] <- data.frame(
      word = names(counts),
      n = as.integer(counts),
      total = total,
      freq = as.numeric(counts) / total,
      id = txt$id[i],
      collection = txt$collection[i],
      pitaka = txt$pitaka[i],
      stringsAsFactors = FALSE
    )
  }

  do.call(rbind, rows)
}
