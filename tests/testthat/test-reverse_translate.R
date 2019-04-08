context("test-reverse_translate")

test_that("length output 3 times input", {
  expect_equal(nchar(reverse_translate(amino_acid_seq = minimal_aa_seq, codon_tbl = minimal_freq_tbl)),
                3 * nchar(minimal_aa_seq))
  expect_equal(nchar(reverse_translate(amino_acid_seq = "X", codon_tbl = minimal_freq_tbl)),
               3 * nchar("X"))
})

