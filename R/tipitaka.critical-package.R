#' tipitaka.critical: Lemmatized Critical Edition of the Pali Canon
#'
#' A lemmatized critical edition of the complete Pali Canon (Tipitaka)
#' based on a five-witness collation with the Digital Pali Dictionary.
#'
#' This package ships the full text data (\code{\link{texts}}) and
#' computes derived data on first access:
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

# Suppress R CMD check NOTE for LazyData and delayedAssign globals
utils::globalVariables(c("texts", "lemmas", "dtm"))

.onLoad <- function(libname, pkgname) {
  ns <- parent.env(environment())
  delayedAssign("lemmas",
    tryCatch(.compute_lemmas(), error = function(e) NULL),
    eval.env = ns, assign.env = ns)
  delayedAssign("dtm",
    tryCatch(.compute_dtm(), error = function(e) NULL),
    eval.env = ns, assign.env = ns)
}
