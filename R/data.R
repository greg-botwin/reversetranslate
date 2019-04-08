#' Names and abbreviations for the 20 standard proteinogenic amino acids plus stop codon.
#'
#' A dataset containing the full name, three letter abreviation, and single letter
#'  abbreviation for the 20 standard proteinogenic amino acids plus Stop.
#'
#' @format A data frame with 21 rows and 3 variables:
#' \describe{
#'   \item{Name}{Name of the amino acid or Stop}
#'   \item{Abr}{Three letter abbreviation of the amino acid or End for Stop}
#'   \item{AA}{One letter abbreviation of the amino acid or * for Stop}
#' }
#'
"aa_names"

#' A default Codon Frequency Table for translation in homo-sapiens.
#'
#' A dataset containing the human amino acid single letter abbreviations, each
#' amino acids respective codon, and the proportion that codon is present in the
#' indicated homo-sapien genome.
#'
#' @format A data frame with 64 rows and 3 variables:
#' \describe{
#'   \item{AA}{One letter abbreviation of the amino acid or * for Stop}
#'   \item{Codon}{Three DNA nucletodies representing the amino acid.}
#'   \item{AA}{The proportion the specific codon is present in the genome)}
#' }
#' @source \url{https://www.kazusa.or.jp/codon/cgi-bin/showcodon.cgi?species=9606}
#'
"hsapien_tbl"

#' A minimal Codon Frequency Table designed for tests.
#'
#' A minimal Codon Frequency Table made up for two test amino acids, called X
#' and Y which are coded for 3 and 1 codon sequence respectively.
#'
#' @format A data frame with 4 rows and 3 variables:
#' \describe{
#'   \item{AA}{One letter abbreviation of the amino acid or * for Stop}
#'   \item{Codon}{Three DNA nucletodies representing the amino acid.}
#'   \item{AA}{The proportion the specific codon is present in the genome)}
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

#' The amino acid sequence for the human protein Nucleotide-binding oligomerization
#' domain-containing protein 2 (NOD2).
#'
#' A cannonical amino acid sequence of the human protein Nucleotide-binding
#' oligomerization domain-containing protein 2 (NOD2), downloaded from the
#' UniProtKB/Swiss-Prot database.
#'
#' @format #' A character vector of the amino acid sequence for the NOD2 protein
#' protein sequence comprised of 1040 amino acids.
#'
#' @source \url{https://www.uniprot.org/uniprot/Q9HC29.fasta}
#'
"nod2_txt"
