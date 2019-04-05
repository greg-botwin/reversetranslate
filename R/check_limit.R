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
    filter(Prop >= limit)

  if(!identical(sort(unique(aa_post_filter$AA)), sort(unique(codon_tbl$AA)))) {
    stop("Codon frequency limit is too high. Not all amino acids have at least 1 remaining codon option.")
  }
  return(aa_post_filter)
}

