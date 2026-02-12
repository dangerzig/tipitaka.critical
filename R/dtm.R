#' Document-Term Matrix (Sparse)
#'
#' Sparse document-term matrix computed from \code{\link{lemmas}}.
#' Each row is a text unit, each column is a lemma, and values are
#' frequencies (proportions). Stored as a \code{dgCMatrix} from the
#' Matrix package. Computed on first access.
#'
#' @format A sparse matrix of class \code{\link[Matrix:dgCMatrix-class]{dgCMatrix}}
#'   with text unit IDs as row names and lemma headwords as column names.
#' @export
#'
#' @examples
#' \donttest{
#' # Sparse document-term matrix
#' dim(dtm)
#'
#' # Hierarchical clustering of text units
#' d <- dist(dtm[1:20, ])
#' plot(hclust(d))
#' }
#'
dtm <- NULL

.compute_dtm <- function() {
  l <- get("lemmas", envir = asNamespace("tipitaka.critical"))

  # Build vocabulary
  vocab <- sort(unique(l$word))
  word_idx <- match(l$word, vocab)

  # Build document list
  docs <- unique(l$id)
  doc_idx <- match(l$id, docs)

  # Build sparse matrix
  sparseMatrix(
    i = doc_idx,
    j = word_idx,
    x = l$freq,
    dims = c(length(docs), length(vocab)),
    dimnames = list(docs, vocab)
  )
}
