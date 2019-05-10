#' Converts an organism specific HIVE Codon Usage Table to a Codon Frequency Table
#'
#' For details on the Codon Frequency Table format please see
#' `reversetrasnalte::check_codon_table()`.
#'
#' @param file the name of the file which the data are to be read from
#' @param skip integer, the number of lines of the data file to skip before beginning to read data.
#' @param total_codons total number of codons analysed per organism as reported in HIVE Codon Usage Table
#'
#' @return data.frame
#' @export
#'
build_hive_codon_tbl <- function(file, skip = 2, total_codons){

  # check total_codons numeric
  if(!is.numeric(total_codons)){
    stop("total_codons must be a numeric value equal to the sums of all the counts")
  }

  hive_df <- utils::read.table(file = file, skip = skip)

  hive_df <- hive_df %>%
    tidyr::separate_rows(.data$V1, sep = "\\)") %>%
    dplyr::mutate(codon = stringr::str_extract(.data$V1, "[[:upper:]]{3}")) %>%
    dplyr::mutate(prop_1000 = as.double(stringr::str_extract(.data$V1, "[[:digit:]]+.[[:digit:]]{2}"))) %>%
    dplyr::mutate(count = as.double(stringr::str_extract(.data$V1, "[[:digit:]]{3,}"))) %>%
    dplyr::select(-.data$V1)

  hive_df <- hive_df[stats::complete.cases(hive_df), ]

  count_sum <- sum(hive_df$count)

  if(count_sum != total_codons) {
    stop("Sum of counts does not equal supplied total_cds (Total Coding Sequences (CDS))")
  }

  hive_df <- dplyr::left_join(hive_df, reversetranslate::aa_names, by = c("codon" = "Codon")) %>%
    dplyr::rename("aa" = .data$AA) %>%
    dplyr::group_by(.data$aa) %>%
    dplyr::mutate(aa_total = sum(.data$count)) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(prop = .data$count/.data$aa_total) %>%
    dplyr::select(.data$aa, .data$codon, .data$prop)


  return(hive_df)
}
