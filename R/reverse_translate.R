#' Reverse translate amino acid Sequence to DNA nucleotides
#'
#' @param amino_acid_seq A character vector of representing amino acid(s).
#' @param codon_tbl A properly formatted Codon Frequency Table with the following
#'  column names, c("codon", "aa", "prop"). The Prop column must be of type
#'  numeric and all proportions between 0 and 1. The sum of each codons
#'  proportion per amino acid equal roughly 1 (0.98 to 1.02 allowed). Please see
#'  check_codon_table for more information.
#' @param limit Numerical value set to restrict codons to proportions greater
#' then the set limit. Must be between 0 and 0.49. Defaults to 0, no limit if
#' not set. When limiting rare codons, the residual proportions are split
#' equally amongst the remaining codon options.
#' @param model Either proportional, equal or gc_bias. if a limit is applied,
#' the limit parameter will first be chosen over the GC correction
#'
#' @return character vector representing reverse translated DNA nucleotide codons.
#' @export
reverse_translate <- function(amino_acid_seq, codon_tbl, limit = 0, model = "proportional") {

  # check amino acid sequence is a character string
  if(typeof(amino_acid_seq) != "character") {
    stop("Amino acid sequence must be of type character")
  }

  # convert amino acid sequence to upper
  amino_acid_seq <- toupper(amino_acid_seq)

  # check if single amino_acid_seq or string
  if(nchar(amino_acid_seq) == 1) {
    string <- "single"
  }
  else{string <- "multi"}

  # check codon table
  codon_tbl <- check_codon_table(codon_tbl = codon_tbl)

  # check limit
  check_limit(codon_tbl = codon_tbl, limit = limit)

  # check if model is appropriate
  if(!model %in% c("proportional", "equal", "gc_biased")) {
    stop("Model must be one of the following options: proportional, equal, gc_biased")
  }

  # reverse translate single character
  if(string == "single") {

    # check amino acid in freq table
    if((amino_acid_seq %in% codon_tbl$aa) == FALSE) {
      stop("Amino acid not found in selected codon table")
    }

    # define codon options
    options <- codon_tbl %>%
      dplyr::filter(prop >= limit) %>%
      dplyr::filter(aa == amino_acid_seq)


    result <- select_codon(options = options, model = model)
    return(result)

  }

  # reverse translate multi character
  if(string == "multi") {

    # break apart string into individual amino_acid_seq
    amino_acids <- strsplit(amino_acid_seq, "")[[1]]

    # check all amino_acid_seq in table
    if(!all(unique(amino_acids) %in% unique(codon_tbl$aa))) {
      stop("Not all amino acids found in selected codon table")
    }

    selected_codons <- vapply(amino_acids, function(x) {
      options <- codon_tbl %>%
        dplyr::filter(prop >= limit) %>%
        dplyr::filter(aa == x)

      select_codon(options = options, model = model)
    }, FUN.VALUE = character(1))
    result <- paste0(unlist(selected_codons), collapse = "")
    return(result)
  }
}

select_codon <- function(options, model) {

  # proportional model
  if(model == "proportional") {

    ## calcualte missing prop and add equally
    ## rmultionom distribution based on provided prop
    ## select 1 row

    missing_prop <- (1 - sum(options$prop))

    selected_codon <- options %>%
      dplyr::mutate(updated_prop = prop/sum(options$prop))%>%
      dplyr::mutate(select = c(stats::rmultinom(n = 1, size = 1, prob = updated_prop))) %>%
      dplyr::filter(select == 1) %>%
      dplyr::select(codon) %>%
      unlist() %>%
      as.character()

    return(selected_codon)

  }

  if(model == "equal") {
    ## assign each remaining codon option equal prop
    selected_codon <- options %>%
      dplyr::mutate(updated_prop = 1/nrow(options)) %>%
      dplyr::mutate(select = c(stats::rmultinom(n = 1, size = 1, prob = updated_prop))) %>%
      dplyr::filter(select == 1) %>%
      dplyr::select(codon) %>%
      unlist() %>%
      as.character()

    return(selected_codon)

  }

  if(model == "gc_biased") {
    options <- options %>%
      dplyr::mutate(gc_count = stringr::str_count(codon, "G|C")) %>%
      dplyr::group_by(aa) %>%
      dplyr::mutate(gc_content = dplyr::if_else(gc_count == min(gc_count), "min",
                                         dplyr::if_else(gc_count == max(gc_count), "max", "med"))) %>%
      dplyr::ungroup() %>%
      dplyr::filter(gc_content == "min")

    missing_prop <- (1 - sum(options$prop))

    selected_codon <- options %>%
      dplyr::mutate(updated_prop = prop/sum(options$prop))%>%
      dplyr::mutate(select = c(stats::rmultinom(n = 1, size = 1, prob = updated_prop))) %>%
      dplyr::filter(select == 1) %>%
      dplyr::select(codon) %>%
      unlist() %>%
      as.character()

    return(selected_codon)

  }
}

