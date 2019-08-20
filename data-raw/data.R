library(dplyr)

# amino acid naming
aa_names <- utils::read.csv("data-raw/aa_naming.txt", comment.char = "#",
                            header = FALSE, col.names = c("name", "abr", "aa", "codon"),
                            stringsAsFactors = FALSE)

usethis::use_data(aa_names, overwrite = TRUE)

# prepare human codon table HIVE
# Assembly GCF_000001405.38
# refseq codon usage table by species downloaded from HIVE
# https://hive.biochemistry.gwu.edu on 20-Aug-2019
# 78581299 codons across 1 asssembly

hsapien_tbl <- readr::read_tsv("data-raw/o576245-Refseq_species.tsv")
colnames(hsapien_tbl) <- make.names(colnames(hsapien_tbl))

hsapien_tbl <- hsapien_tbl %>%
  dplyr::filter(.data$Organelle == "genomic") %>%
  dplyr::filter(.data$Taxid == 9606) %>%
  dplyr::select(-Division, -Assembly, -Taxid, -Species, -Organelle, -Translation.Table,
                -X..CDS, -GC., -GC1., -GC2., -GC3.) %>%
  tidyr::gather(key = "codon", value = "n_codons", -X..Codons) %>%
  dplyr::mutate(prop = n_codons/X..Codons) %>%
  dplyr::inner_join(., aa_names, by = "codon") %>%
  dplyr::select(codon, aa, prop)

usethis::use_data(hsapien_tbl, overwrite = TRUE)

# prepare E coli table HIVE
# refseq codon usage table by species downloaded from HIVE
# https://hive.biochemistry.gwu.edu on 20-Aug-2019
# 16107182956 codons across 10,957 assemblies

ecoli_tbl <- readr::read_tsv("data-raw/o576245-Refseq_species.tsv")
colnames(ecoli_tbl) <- make.names(colnames(ecoli_tbl))

ecoli_tbl <- ecoli_tbl %>%
  dplyr::filter(.data$Organelle == "genomic") %>%
  dplyr::filter(.data$Taxid == 562) %>%
  dplyr::select(-Division, -Assembly, -Taxid, -Species, -Organelle, -Translation.Table,
                -X..CDS, -GC., -GC1., -GC2., -GC3.) %>%
  tidyr::gather(key = "codon", value = "n_codons_per_assembly", -X..Codons) %>%
  dplyr::group_by(codon) %>%
  dplyr::summarise(n_codons = sum(n_codons_per_assembly),
                   total_codons = sum(X..Codons)) %>%
  dplyr::mutate(prop = n_codons/total_codons) %>%
  dplyr::inner_join(., aa_names, by = "codon") %>%
  dplyr::select(codon, aa, prop)

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
