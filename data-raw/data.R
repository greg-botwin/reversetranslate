library(dplyr)

# example text amino acid sequence for nod2
nod2_txt <- utils::read.delim("data-raw/Q9HC29.fasta", comment.char = ">",
                       stringsAsFactors = FALSE, header = FALSE)

nod2_txt <- nod2_txt$V1 %>%
  paste0(collapse = "")

usethis::use_data(nod2_txt, overwrite = TRUE)

# amino acid naming
aa_names <- utils::read.csv("data-raw/aa_naming.txt", comment.char = "#",
                            header = FALSE, col.names = c("Name", "Abr", "AA"),
                            stringsAsFactors = FALSE)

usethis::use_data(aa_names, overwrite = TRUE)

# prepare human codon table table
hsapien_tbl <- utils::read.table("data-raw/hsapien.txt", comment.char = "#",
                                 header = TRUE, stringsAsFactors = FALSE)

hsapien_tbl <- hsapien_tbl %>%
  dplyr::group_by(AmAcid) %>%
  dplyr::mutate(total = sum(Number)) %>%
  dplyr::ungroup() %>%
  dplyr::mutate(Prop = Number/total) %>%
  dplyr::left_join(., aa_names, by = c("AmAcid" = "Abr")) %>%
  dplyr::select(AA, Prop, Codon)

usethis::use_data(hsapien_tbl, overwrite = TRUE)

# minimum codon freq table simple tests
minimum_freq_tbl <- data.frame("Codon" = c("AAA", "GGG", "CCC", "TTT"),
                               "AA" = c("X", "X", "X", "Y"),
                               "Prop" = c(0.4, 0.4, 0.2, 1),
                               stringsAsFactors = FALSE)

usethis::use_data(minimum_freq_tbl, overwrite = TRUE)

# mimimum amino acid sequence for simple tests
minimum_aa_seq <- c("XXXYXXXYY")

usethis::use_data(minimum_aa_seq, overwrite = TRUE)
