check_codon_table <- function(codon_tbl) {
  # check codon tbl has proper column names
  if(all(c("Codon", "AA", "Prop") %in% colnames(codon_tbl)) == FALSE) {
    stop("Codon Frequency Table is improperly formated. The table must contain the following
         column names : Codon, Prop, AA")
  }

  # check codon tbl props are of class numeric
  if(is.numeric(codon_tbl$Prop) != TRUE) {
    stop("Codon proportions must be numeric")
  }

  # check codon tbl props between 0 and 1
  if(max(codon_tbl$Prop) > 1 | min(codon_tbl$Prop) < 0) {
    stop("Codon proportions must be between 0 and 1")
  }

  # check the sum of props by aa sum to 0.98 to 1.02
  total_props <- codon_tbl %>%
    dplyr::group_by(AA) %>%
    dplyr::summarise(total_prop = sum(Prop)) %>%
    dplyr::select(total_prop) %>%
    unlist()

  if(all(total_props >= 0.98 & total_props <= 1.02) != TRUE) {
    stop("Codon proportions per amino acid, must sum to 1 +/- 0.02")
  }

  else(sprintf("Properly formated Codon Frequency Table"))
}
