#' Lemma Frequency Table
#'
#' Computes and caches a lemma frequency table from the lemmatized text.
#' On first call this tokenizes \code{\link{texts}$text_lemmatized} and
#' counts word frequencies per text unit (takes ~5 seconds). Subsequent
#' calls return the cached result instantly.
#'
#' @return A data frame with columns:
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
#' # Get lemma frequencies (first call computes; subsequent calls are instant)
#' l <- lemmas()
#' head(l)
#'
#' # Top lemmas across the entire canon
#' total_counts <- tapply(l$n, l$word, sum)
#' head(sort(total_counts, decreasing = TRUE), 20)
#'
lemmas <- function() {
  if (is.null(.cache$lemmas)) {
    .cache$lemmas <- .compute_lemmas()
  }
  .cache$lemmas
}

.compute_lemmas <- function() {
  rows <- vector("list", nrow(texts))

  for (i in seq_len(nrow(texts))) {
    words <- strsplit(texts$text_lemmatized[i], "\\s+")[[1]]
    words <- words[nzchar(words)]
    if (length(words) == 0) next

    counts <- table(words)
    total <- sum(counts)

    rows[[i]] <- data.frame(
      word = names(counts),
      n = as.integer(counts),
      total = total,
      freq = as.numeric(counts) / total,
      id = texts$id[i],
      collection = texts$collection[i],
      pitaka = texts$pitaka[i],
      stringsAsFactors = FALSE
    )
  }

  do.call(rbind, rows)
}
