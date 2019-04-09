#' Names, abbreviations and codons, for the 20 standard proteinogenic amino acids plus stop codon.
#'
#' A dataset containing the full name, three letter abreviation, single letter
#'  abbreviationand codon for the 20 standard proteinogenic amino acids plus Stop.
#'
#' @format A data frame with 64 rows and 4 variables:
#' \describe{
#'   \item{Name}{Name of the amino acid or Stop}
#'   \item{Abr}{Three letter abbreviation of the amino acid or End for Stop}
#'   \item{AA}{One letter abbreviation of the amino acid or * for Stop}
#'   \item{Codon}{Three nucleotide (A,G,C,T only) codon for the assigned amino acid.}
#' }
#'
"aa_names"

#' A minimal Codon Frequency Table designed for tests.
#'
#' A minimal Codon Frequency Table made up for two test amino acids, called X
#' and Y which are coded for 3 and 1 codon sequence respectively.
#'
#' @format A data frame with 4 rows and 3 variables:
#' \describe{
#'   \item{aa}{One letter abbreviation of the amino acid or * for Stop}
#'   \item{codon}{Three DNA nucletodies representing the amino acid.}
#'   \item{prop}{The proportion the specific codon is present in the genome)}
#' }
#'
"minimal_freq_tbl"

#' A minimal amino acid sequence comprised of the made up amino acids X and Y
#' used for testing and display.
#'
#' @format #' A character vector designed to represent a minimal amino acid
#' sequence of 9 made up amino acids of X and Y.
#'
"minimal_aa_seq"

#' An Homo Sapien Codon Frequency Table.
#'
#'Built from HIVE Homo sapiens (9606) Codon Usage Table
#'
#' @format A data frame with 4 rows and 3 variables:
#' \describe{
#'   \item{aa}{One letter abbreviation of the amino acid or * for Stop}
#'   \item{codon}{Three DNA nucletodies representing the amino acid.}
#'   \item{prop}{The proportion the specific codon is present in the genome)}
#' }
#'
"hsapien_tbl"

#' An Escherichia coli Codon Frequency Table.
#'
#' Built from HIVE Escherichia coli (562) Codon Usage Table
#'
#' @format A data frame with 4 rows and 3 variables:
#' \describe{
#'   \item{aa}{One letter abbreviation of the amino acid or * for Stop}
#'   \item{codon}{Three DNA nucletodies representing the amino acid.}
#'   \item{prop}{The proportion the specific codon is present in the genome)}
#' }
#'
"ecoli_tbl"

