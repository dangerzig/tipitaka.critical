#' Document-Term Matrix (Sparse)
#'
#' Computes and caches a sparse document-term matrix from \code{\link{lemmas}}.
#' Each row is a text unit, each column is a lemma, and values are
#' frequencies (proportions). Stored as a \code{dgCMatrix} from the
#' Matrix package.
#'
#' @return A sparse matrix of class \code{\link[Matrix:dgCMatrix-class]{dgCMatrix}}
#'   with text unit IDs as row names and lemma headwords as column names.
#' @export
#'
#' @examples
#' \donttest{
#' # Get the document-term matrix
#' m <- dtm()
#' dim(m)
#'
#' # Cluster Digha Nikaya suttas
#' dn <- m[grep("^dn", rownames(m)), ]
#' hc <- hclust(dist(dn))
#' plot(hc, main = "DN Sutta Clustering")
#' }
#'
dtm <- function() {
  if (is.null(.cache$dtm)) {
    .cache$dtm <- .compute_dtm()
  }
  .cache$dtm
}

.compute_dtm <- function() {
  l <- lemmas()

  # Build vocabulary
  vocab <- sort(unique(l$word))
  word_idx <- match(l$word, vocab)

  # Build document list
  docs <- unique(l$id)
  doc_idx <- match(l$id, docs)

  # Build sparse matrix
  m <- sparseMatrix(
    i = doc_idx,
    j = word_idx,
    x = l$freq,
    dims = c(length(docs), length(vocab)),
    dimnames = list(docs, vocab)
  )

  m
}
