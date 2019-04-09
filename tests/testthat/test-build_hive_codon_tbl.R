context("test-build_hive_codon_tbl")

test_that("CDS sums check", {
  expect_error(build_hive_codon_tbl("hsapien_hive.txt", skip = 2,
                                    total_codons = NULL))
  expect_error(build_hive_codon_tbl("hsapien_hive.txt", skip = 2,
                                    total_codons = NA))
  expect_error(build_hive_codon_tbl("hsapien_hive.txt", skip = 2,
                                    total_codons = "A"))
  expect_error(build_hive_codon_tbl("hsapien_hive.txt", skip = 2,
                                    total_codons = 1))
  expect_length(build_hive_codon_tbl("hsapien_hive.txt", skip = 2,
                                     total_codons = 78580607), 3)
})
