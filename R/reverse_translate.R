#' Reverse translate amino acid Sequence to DNA nucleotides
#'
#' @param AA A character string for an amino acid(s).
#' @param codon_tbl A propoerly formated Codon Frequency Table with the following
#'  collumn names, c("Codon", "AA", "Prop"). The Prop column must be of type
#'  numberic and all proportiosn between 0 and 1. The sum of each codons
#'  proportion per amino acid equal roughly 1 (0.98 to 1.02 allowed).
#' @param limit Numerical value set to restrict codons to proportions greater
#' then the set limit. Must be between 0 and 0.49. Defaults to 0, no limit if
#' not set. When limiting rare codons, the residual proportions are split
#' equally amongst the remaining codon options.
#' @param model Either proportional, equal or gc_bias. if a limit is applied,
#' the limit parameter will first be chosen over the gc correction
#'
#' @return character
#' @export
#'
#' @examples
#'
reverse_translate <- function(aa, codon_tbl, limit = 0, model = "proportional") {

  # check amino acid sequence is a character string
  if(typeof(aa) != "character") {
    stop("Amino acid sequence must be of type character")
  }

  # check if single aa or string
  if(nchar(aa) == 1) {
    string <- "single"
  }
  else{string <- "multi"}

  # check codon table
  check_codon_table(codon_tbl = codon_tbl)

  # check limit
  check_limit(codon_tbl = codon_tbl, limit = limit)

  # check if model is appropriate
  if(!model %in% c("proportional", "equal", "gc_biased")) {
    stop("Model must be one of the following options: proportional, equal, gc_biased")
  }

  # reverse translate single character
  if(string == "single") {

    # check amino acid in freq table
    if((aa %in% codon_tbl$AA) == FALSE) {
      stop("Amino acid not found in selected codon table")
    }

    # define codon options
    options <- codon_tbl %>%
      dplyr::filter(Prop >= limit) %>%
      dplyr::filter(AA == aa)

    select_codon(options = options, model = model)

  }

  # reverse translate multi character
  if(string == "multi") {

    # break apart string into individual aa
    amino_acids <- tokenizers::tokenize_characters(aa, lowercase = FALSE)[[1]]

    # check all aa in table
    if(!all(unique(amino_acids) %in% unique(codon_tbl$AA))) {
      stop("Not all amino acids found in selected codon table")
    }

    codons <- lapply(amino_acids, function(x) {
      options <- codon_tbl %>%
        dplyr::filter(Prop >= limit) %>%
        dplyr::filter(AA == x)

      select_codon(options = options, model = model)
    })
    paste0(unlist(codons), collapse = "")
  }
}

select_codon <- function(options, model) {

  # proportional model
  if(model == "proportional") {
    ## calcualte missing prop and add equally
    ## rmultionom distribution based on provided prop
    ## select 1 row

    missing_prop <- (1 - sum(options$Prop))/nrow(options)
    options <- options %>%
      dplyr::mutate(updated_prop = Prop + missing_prop) %>%
      dplyr::mutate(select = c(rmultinom(n = 1, size = 1, prob = updated_prop))) %>%
      dplyr::filter(select == 1) %>%
      dplyr::select(Codon) %>%
      unlist() %>%
      as.character()

    return(options)

  }

  if(model == "equal") {
    ## assign each remaining codon option equal prop
    options <- options %>%
      dplyr::mutate(updated_prop = 1/nrow(options)) %>%
      dplyr::mutate(select = c(rmultinom(n = 1, size = 1, prob = updated_prop))) %>%
      dplyr::filter(select == 1) %>%
      dplyr::select(Codon) %>%
      unlist() %>%
      as.character()

    return(options)
  }

  if(model == "gc_biased") {
    options <- options %>%
      dplyr::mutate(gc_count = stringr::str_count(Codon, "G|C")) %>%
      dplyr::group_by(AA) %>%
      dplyr::mutate(gc_content = if_else(gc_count == min(gc_count), "min",
                                         if_else(gc_count == max(gc_count), "max", "med"))) %>%
      dplyr::ungroup() %>%
      dplyr::filter(gc_content == "min")

    missing_prop <- (1 - sum(options$Prop))/nrow(options)

    options <- options %>%
      dplyr::mutate(updated_prop = Prop + missing_prop) %>%
      dplyr::mutate(select = c(rmultinom(n = 1, size = 1, prob = updated_prop))) %>%
      dplyr::filter(select == 1) %>%
      dplyr::select(Codon) %>%
      unlist() %>%
      as.character()

    return(options)
  }
}

