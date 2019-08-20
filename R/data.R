#' Names, abbreviations and codons, for the 20 standard proteinogenic amino acids plus stop codon.
#'
#' A dataset containing the full name, three letter abbreviation, single letter
#'  abbreviation and codon for the 20 standard proteinogenic amino acids plus Stop.
#'
#' @format A data frame with 64 rows and 4 variables:
#' \describe{
#'   \item{name}{Name of the amino acid or Stop}
#'   \item{abr}{Three letter abbreviation of the amino acid or End for Stop}
#'   \item{aa}{One letter abbreviation of the amino acid or * for Stop}
#'   \item{codon}{Three nucleotide (A,G,C,T only) codon for the assigned amino acid.}
#' }
#'
"aa_names"

#' A minimal Codon Frequency Table designed for tests.
#'
#' A minimal Codon Frequency Table made up for three test amino acids, called X, Y
#' and Z which are coded by 3, 1 and 4 codons respectively.
#'
#' @format A data frame with 8 rows and 3 variables:
#' \describe{
#'   \item{aa}{One letter abbreviation of the amino acid or * for Stop}
#'   \item{codon}{Three DNA nucleotides representing the amino acid.}
#'   \item{prop}{The proportion the specific codon is present in the genome)}
#' }
#'
"minimal_freq_tbl"

#' A minimal amino acid sequence comprised of the made up amino acids X and Y
#' used for testing and display.
#'
#' @format #' A character vector designed to represent a minimal amino acid
#' sequence of 10 made up amino acids of X, Y and Z.
#'
"minimal_aa_seq"

#' An Homo Sapien Codon Frequency Table.
#'
#'Built from HIVE Homo sapiens (9606) Codon Usage Table
#'
#' @format A data frame with 64 rows and 3 variables:
#' \describe{
#'   \item{aa}{One letter abbreviation of the amino acid or * for Stop}
#'   \item{codon}{Three DNA nucleotides representing the amino acid.}
#'   \item{prop}{The proportion the specific codon is present in the genome)}
#' }
#'
"hsapien_tbl"

#' An Escherichia coli Codon Frequency Table.
#'
#' Built from HIVE Escherichia coli (562) Codon Usage Table
#'
#' @format A data frame with 64 rows and 3 variables:
#' \describe{
#'   \item{aa}{One letter abbreviation of the amino acid or * for Stop}
#'   \item{codon}{Three DNA nucleotides representing the amino acid.}
#'   \item{prop}{The proportion the specific codon is present in the genome)}
#' }
#'
"ecoli_tbl"

