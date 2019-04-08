#' Confirm formatting for user supplied Codon Frequency Table.
#'
#' @param codon_tbl A Codon Frequency Table with the following column names,
#'  c("codon", "aa", "prop"). Capitlliation of column names should not matter.
#'  The prop column must be of type numeric and all proportions between 0 and 1.
#'  The sum of each codons proportion per amino acid must total roughly to 1
#'  (0.98 to 1.02 allowed).
#'
#' @format codon_tbl (A Codon Frequency Table):
#' \describe{
#'   \item{codon}{Three DNA nucletodies representing the amino acid.}
#'   \item{aa}{One letter abbreviation of the amino acid or * for Stop}
#'   \item{prop}{The proportion the specific codon is present in the genome}
#' }
#' @return An updated Codon Frequency Table with all column names lower case for
#' downstream use.
#'
#' @export
#'
#'
check_codon_table <- function(codon_tbl) {
  colnames(codon_tbl) <- tolower(colnames(codon_tbl))

  # check codon tbl has proper column names
  if(all(c("codon", "aa", "prop") %in% colnames(codon_tbl)) == FALSE) {
    stop("Codon Frequency Table is improperly formated. The table must contain the following
         column names : Codon, Prop, AA")
  }

  # check codon tbl props are of class numeric
  if(is.numeric(codon_tbl$prop) != TRUE) {
    stop("Codon proportions must be numeric")
  }

  # check codon tbl props between 0 and 1
  if(max(codon_tbl$prop) > 1 | min(codon_tbl$prop) < 0) {
    stop("Codon proportions must be between 0 and 1")
  }

  # check the sum of props by aa sum to 0.98 to 1.02
  total_props <- codon_tbl %>%
    dplyr::group_by(aa) %>%
    dplyr::summarise(total_prop = sum(prop)) %>%
    dplyr::select(total_prop) %>%
    unlist()

  if(all(total_props >= 0.98 & total_props <= 1.02) != TRUE) {
    stop("Codon proportions per amino acid, must sum to 1 +/- 0.02")
  }

  else(message("Properly formated Codon Frequency Table"))

  return(codon_tbl)

}
