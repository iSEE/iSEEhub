
<!-- README.md is generated from README.Rmd. Please edit that file -->

# iSEEhub

<!-- badges: start -->

[![GitHub
issues](https://img.shields.io/github/issues/kevinrue/iSEEhub)](https://github.com/kevinrue/iSEEhub/issues)
[![GitHub
pulls](https://img.shields.io/github/issues-pr/kevinrue/iSEEhub)](https://github.com/kevinrue/iSEEhub/pulls)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check-bioc](https://github.com/kevinrue/iSEEhub/workflows/R-CMD-check-bioc/badge.svg)](https://github.com/kevinrue/iSEEhub/actions)
[![Codecov test
coverage](https://codecov.io/gh/kevinrue/iSEEhub/branch/main/graph/badge.svg)](https://app.codecov.io/gh/kevinrue/iSEEhub?branch=main)
<!-- badges: end -->

The goal of `iSEEhub` is to provide an interface to the Bioconductor
*[ExperimentHub](https://bioconductor.org/packages/3.16/ExperimentHub)*
directly within an *[iSEE](https://bioconductor.org/packages/3.16/iSEE)*
web-application.

The main functionality of this package is to define a custom landing
page allowing users to browse the Bioconductor
*[ExperimentHub](https://bioconductor.org/packages/3.16/ExperimentHub)*
and directly load objects into an
*[iSEE](https://bioconductor.org/packages/3.16/iSEE)* web-application.

## Installation instructions

Get the latest stable `R` release from
[CRAN](http://cran.r-project.org/). Then install `iSEEhub` from
[Bioconductor](http://bioconductor.org/) using the following code:

``` r
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install("iSEEhub")
```

And the development version from
[GitHub](https://github.com/kevinrue/iSEEhub) with:

``` r
BiocManager::install("kevinrue/iSEEhub")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library("iSEEhub")
#> Loading required package: SingleCellExperiment
#> Loading required package: SummarizedExperiment
#> Loading required package: MatrixGenerics
#> Loading required package: matrixStats
#> 
#> Attaching package: 'MatrixGenerics'
#> The following objects are masked from 'package:matrixStats':
#> 
#>     colAlls, colAnyNAs, colAnys, colAvgsPerRowSet, colCollapse,
#>     colCounts, colCummaxs, colCummins, colCumprods, colCumsums,
#>     colDiffs, colIQRDiffs, colIQRs, colLogSumExps, colMadDiffs,
#>     colMads, colMaxs, colMeans2, colMedians, colMins, colOrderStats,
#>     colProds, colQuantiles, colRanges, colRanks, colSdDiffs, colSds,
#>     colSums2, colTabulates, colVarDiffs, colVars, colWeightedMads,
#>     colWeightedMeans, colWeightedMedians, colWeightedSds,
#>     colWeightedVars, rowAlls, rowAnyNAs, rowAnys, rowAvgsPerColSet,
#>     rowCollapse, rowCounts, rowCummaxs, rowCummins, rowCumprods,
#>     rowCumsums, rowDiffs, rowIQRDiffs, rowIQRs, rowLogSumExps,
#>     rowMadDiffs, rowMads, rowMaxs, rowMeans2, rowMedians, rowMins,
#>     rowOrderStats, rowProds, rowQuantiles, rowRanges, rowRanks,
#>     rowSdDiffs, rowSds, rowSums2, rowTabulates, rowVarDiffs, rowVars,
#>     rowWeightedMads, rowWeightedMeans, rowWeightedMedians,
#>     rowWeightedSds, rowWeightedVars
#> Loading required package: GenomicRanges
#> Loading required package: stats4
#> Loading required package: BiocGenerics
#> Warning: package 'BiocGenerics' was built under R version 4.2.1
#> 
#> Attaching package: 'BiocGenerics'
#> The following objects are masked from 'package:stats':
#> 
#>     IQR, mad, sd, var, xtabs
#> The following objects are masked from 'package:base':
#> 
#>     anyDuplicated, append, as.data.frame, basename, cbind, colnames,
#>     dirname, do.call, duplicated, eval, evalq, Filter, Find, get, grep,
#>     grepl, intersect, is.unsorted, lapply, Map, mapply, match, mget,
#>     order, paste, pmax, pmax.int, pmin, pmin.int, Position, rank,
#>     rbind, Reduce, rownames, sapply, setdiff, sort, table, tapply,
#>     union, unique, unsplit, which.max, which.min
#> Loading required package: S4Vectors
#> 
#> Attaching package: 'S4Vectors'
#> The following objects are masked from 'package:base':
#> 
#>     expand.grid, I, unname
#> Loading required package: IRanges
#> Loading required package: GenomeInfoDb
#> Loading required package: Biobase
#> Welcome to Bioconductor
#> 
#>     Vignettes contain introductory material; view with
#>     'browseVignettes()'. To cite Bioconductor, see
#>     'citation("Biobase")', and for packages 'citation("pkgname")'.
#> 
#> Attaching package: 'Biobase'
#> The following object is masked from 'package:MatrixGenerics':
#> 
#>     rowMedians
#> The following objects are masked from 'package:matrixStats':
#> 
#>     anyMissing, rowMedians
#> Loading required package: ExperimentHub
#> Loading required package: AnnotationHub
#> Loading required package: BiocFileCache
#> Loading required package: dbplyr
#> 
#> Attaching package: 'AnnotationHub'
#> The following object is masked from 'package:Biobase':
#> 
#>     cache
library(ExperimentHub)
ehub <- ExperimentHub()
#> snapshotDate(): 2022-07-22

app <- iSEEhub(ehub)

if (interactive()) {
  shiny::runApp(app, port = 1234)
}
```

<img src="man/figures/landing_page.png" width="100%" />

## Citation

Below is the citation output from using `citation('iSEEhub')` in R.
Please run this yourself to check for any updates on how to cite
**iSEEhub**.

``` r
print(citation('iSEEhub'), bibtex = TRUE)
#> 
#> kevinrue (2022). _Demonstration of a Bioconductor Package_. doi:
#> 10.18129/B9.bioc.iSEEExperimentHub (URL:
#> https://doi.org/10.18129/B9.bioc.iSEEExperimentHub),
#> https://github.com/kevinrue/iSEEExperimentHub/iSEEExperimentHub - R
#> package version 0.99.0, <URL:
#> http://www.bioconductor.org/packages/iSEEExperimentHub>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {Demonstration of a Bioconductor Package},
#>     author = {{kevinrue}},
#>     year = {2022},
#>     url = {http://www.bioconductor.org/packages/iSEEExperimentHub},
#>     note = {https://github.com/kevinrue/iSEEExperimentHub/iSEEExperimentHub - R package version 0.99.0},
#>     doi = {10.18129/B9.bioc.iSEEExperimentHub},
#>   }
#> 
#> kevinrue (2022). "Demonstration of a Bioconductor Package." _bioRxiv_.
#> doi: 10.1101/TODO (URL: https://doi.org/10.1101/TODO), <URL:
#> https://www.biorxiv.org/content/10.1101/TODO>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Article{,
#>     title = {Demonstration of a Bioconductor Package},
#>     author = {{kevinrue}},
#>     year = {2022},
#>     journal = {bioRxiv},
#>     doi = {10.1101/TODO},
#>     url = {https://www.biorxiv.org/content/10.1101/TODO},
#>   }
```

Please note that the `iSEEhub` was only made possible thanks to many
other R and bioinformatics software authors, which are cited either in
the vignettes and/or the paper(s) describing this package.

## Code of Conduct

Please note that the `iSEEhub` project is released with a [Contributor
Code of Conduct](http://bioconductor.org/about/code-of-conduct/). By
contributing to this project, you agree to abide by its terms.

## Development tools

-   Continuous code testing is possible thanks to [GitHub
    actions](https://www.tidyverse.org/blog/2020/04/usethis-1-6-0/)
    through *[usethis](https://CRAN.R-project.org/package=usethis)*,
    *[remotes](https://CRAN.R-project.org/package=remotes)*, and
    *[rcmdcheck](https://CRAN.R-project.org/package=rcmdcheck)*
    customized to use [Bioconductor’s docker
    containers](https://www.bioconductor.org/help/docker/) and
    *[BiocCheck](https://bioconductor.org/packages/3.16/BiocCheck)*.
-   Code coverage assessment is possible thanks to
    [codecov](https://codecov.io/gh) and
    *[covr](https://CRAN.R-project.org/package=covr)*.
-   The [documentation website](http://kevinrue.github.io/iSEEhub) is
    automatically updated thanks to
    *[pkgdown](https://CRAN.R-project.org/package=pkgdown)*.
-   The code is styled automatically thanks to
    *[styler](https://CRAN.R-project.org/package=styler)*.
-   The documentation is formatted thanks to
    *[devtools](https://CRAN.R-project.org/package=devtools)* and
    *[roxygen2](https://CRAN.R-project.org/package=roxygen2)*.

For more details, check the `dev` directory.

This package was developed using
*[biocthis](https://bioconductor.org/packages/3.16/biocthis)*.

## Code of Conduct

Please note that the iSEEhub project is released with a [Contributor
Code of Conduct](http://bioconductor.org/about/code-of-conduct/). By
contributing to this project, you agree to abide by its terms.
