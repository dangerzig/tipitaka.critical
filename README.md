# tipitaka.critical

A lemmatized critical edition of the complete Pali Canon (Tipitaka) for R.

## Overview

This package provides the full text of the Pali Canon based on a five-witness
collation of:

- **PTS** (Pali Text Society, via GRETIL)
- **SuttaCentral** (Mahasangiti edition)
- **VRI** (Chattha Sangayana, CST4)
- **BJT** (Buddha Jayanti Tipitaka)
- **Thai** (Syam Rattha Royal Edition)

All text is lemmatized using the Digital Pali Dictionary, grouping inflected
forms by dictionary headword. The package covers all three pitakas (Sutta,
Vinaya, Abhidhamma) with 5,777 individual text units and ~2.8 million tokens.

## Installation

```r
install.packages("tipitaka.critical")
```

Or install the development version:

```r
# install.packages("remotes")
remotes::install_github("dangerzig/tipitaka.critical")
```

## Usage

```r
library(tipitaka.critical)

# Full text data (5,777 text units)
head(texts)

# Lemma frequency table (computed on first access)
head(lemmas)

# Most frequent lemmas across the canon
totals <- tapply(lemmas$n, lemmas$word, sum)
head(sort(totals, decreasing = TRUE), 20)

# Sparse document-term matrix
dim(dtm)

# Search for a lemma across all texts
search_lemma("nibbana")
```

## Datasets

| Dataset | Description |
|---------|-------------|
| `texts` | Surface-form and lemmatized text for every text unit |
| `lemmas` | Lemma frequency table (computed on first access) |
| `dtm` | Sparse document-term matrix (computed on first access) |

## Related

The companion package [tipitaka](https://CRAN.R-project.org/package=tipitaka)
provides the original VRI edition data and Pali text tools including
Pali-alphabet sorting.

## License

CC0
