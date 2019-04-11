library(dplyr)

# amino acid naming
aa_names <- utils::read.csv("data-raw/aa_naming.txt", comment.char = "#",
                            header = FALSE, col.names = c("Name", "Abr", "AA", "Codon"),
                            stringsAsFactors = FALSE)

usethis::use_data(aa_names, overwrite = TRUE)

# prepare human codon table HIVE
hsapien_tbl <- reversetranslate::build_hive_codon_tbl("data-raw/hsapien_hive.txt",
                                                           skip = 2, 78580607)

usethis::use_data(hsapien_tbl, overwrite = TRUE)

# prepare E coli table HIVE
ecoli_tbl <- reversetranslate::build_hive_codon_tbl("data-raw/ecoli_hive.txt",
                                                      skip = 2, 17506389367)

usethis::use_data(ecoli_tbl, overwrite = TRUE)

# minimum codon freq table simple tests
minimal_freq_tbl <- data.frame("codon" = c("AAA", "GGG", "CCC", "TTT", "GCT", "ATG", "AAC", "CCC"),
                               "aa" = c("X", "X", "X", "Y", "Z", "Z", "Z", "Z"),
                               "prop" = c(0.4, 0.4, 0.2, 1, 0.2, 0.4, 0.2, 0.2),
                               stringsAsFactors = FALSE)

usethis::use_data(minimal_freq_tbl, overwrite = TRUE)

# mimimum amino acid sequence for simple tests
minimal_aa_seq <- c("XXXYXXXYYZ")

usethis::use_data(minimal_aa_seq, overwrite = TRUE)
