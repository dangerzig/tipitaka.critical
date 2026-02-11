#' tipitaka.critical: Lemmatized Critical Edition of the Pali Canon
#'
#' A lemmatized critical edition of the complete Pali Canon (Tipitaka)
#' based on a five-witness collation with the Digital Pali Dictionary.
#'
#' This package ships the full text data (\code{\link{texts}}) and
#' provides functions to compute derived data on demand:
#' \itemize{
#'   \item \code{\link{lemmas}}: lemma frequency table
#'   \item \code{\link{dtm}}: sparse document-term matrix
#'   \item \code{\link{search_lemma}}: search for a lemma across all texts
#' }
#'
#' For the original VRI edition and Pali text tools, see the companion
#' package \pkg{tipitaka}.
#'
#' @import Matrix
#' @name tipitaka.critical
"_PACKAGE"

# Internal cache for computed data
.cache <- new.env(parent = emptyenv())

# Suppress R CMD check NOTE for LazyData globals
utils::globalVariables("texts")
