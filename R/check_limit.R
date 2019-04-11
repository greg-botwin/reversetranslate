#' Checks if user supplied amino acid proportion limit threshold is too restrictive.
#'
#' @param codon_tbl  A properly formatted Codon Frequency Table with the following
#'  column names, c("codon", "aa", "prop"). Capitalization of column names should
#'  not matter. The prop column must be of type numeric and all proportions
#'  between 0 and 1. The sum of each codons proportion per amino acid must total
#'  roughly to 1 (0.98 to 1.02 allowed).
#'
#' @param limit A numeric value greater than or equal to 0 and less than or equal
#' to 0.49. Codons with a proportion below specified value will be filtered and
#' will not be avaliable for selection through the reverse translation function.
#'
#' @return A filtered Codon Frequency Table removing all amino acids whose proportion
#' is less than the provided limit.
#' @export
#'
check_limit <- function(codon_tbl, limit) {

  # check limit is of class numeric
  if(is.numeric(limit) != TRUE) {
    stop("Limit must be of type be numeric")
  }

  # check limit between 0 and 0.49
  if(all(limit >= 0 & limit <= 0.49) == FALSE) {
    stop("Limit must be between 0 and 0.49")
  }

  # check to make sure all aa have >= 1 options after limit
  aa_post_filter <- codon_tbl %>%
    dplyr::filter(prop >= limit)

  if(!identical(sort(unique(aa_post_filter$aa)), sort(unique(codon_tbl$aa)))) {
    stop("Codon frequency limit is too high. Not all amino acids have at least 1 remaining codon option.")
  }
  return(aa_post_filter)
}

