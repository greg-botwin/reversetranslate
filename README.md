
<!-- README.md is generated from README.Rmd. Please edit that file -->

# reversetranslate

<!-- badges: start -->

[![Travis build
status](https://travis-ci.org/greg-botwin/reversetranslate.svg?branch=master)](https://travis-ci.org/greg-botwin/reversetranslate)
[![Codecov test
coverage](https://codecov.io/gh/greg-botwin/reversetranslate/branch/master/graph/badge.svg)](https://codecov.io/gh/greg-botwin/reversetranslate?branch=master)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/reversetranslate)](https://cran.r-project.org/package=reversetranslate)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/greg-botwin/reversetranslate?branch=master&svg=true)](https://ci.appveyor.com/project/greg-botwin/reversetranslate)
<!-- badges: end -->

The goal of `reversetranslate` is to provide a set of R functions to
assist users in reverse translating an amino acid sequence to DNA
nucleotides.

## Installation

You can install the development version from
[GitHub](https://github.com/greg-botwin/reversetranslate) with:

``` r
# install.packages("devtools")
devtools::install_github("greg-botwin/reversetranslate")
```

## General Details

Users can supply their own Codon Frequency Table relevant to the
organism they are most interested in simulating the reverse translation
in or use one of the commonly desired options supplied. Users can also
select between the following three different models of reverse
translation depending on what assumptions you want to make regarding how
redundant codons are chosen and your intended application.

1.  proportional
2.  equal
3.  GC biased

The user may also choose to limit the inclusion of low frequency codons
into the reverse translated nucleotide sequence.

The package currently maintains Codon Frequency Tables for:

  - Homo sapiens
  - Escherichia coli

Additional details on package functionality can be found by viewing the
package vignette.

## Example

### Load Package

``` r
library(reversetranslate)
```

### Example Amino Acid Sequence

``` r
minimal_aa_seq
#> [1] "XXXYXXXYYZ"
```

### Example Codon Frequency Table

``` r
minimal_freq_tbl
#>   codon aa prop
#> 1   AAA  X  0.4
#> 2   GGG  X  0.4
#> 3   CCC  X  0.2
#> 4   TTT  Y  1.0
#> 5   GCT  Z  0.2
#> 6   ATG  Z  0.4
#> 7   AAC  Z  0.2
#> 8   CCC  Z  0.2
```

### Example Reverse Translation

``` r
reverse_translate(amino_acid_seq = minimal_aa_seq, codon_tbl = minimal_freq_tbl,
                  limit = 0, model = "proportional")
#> Properly formated Codon Frequency Table
#> [1] "AAAAAAAAATTTAAACCCCCCTTTTTTCCC"
```

### Support

This work was supported by Cedars-Sinai Precision Health.
