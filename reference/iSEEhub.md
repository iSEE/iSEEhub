# iSEEhub app

iSEEhub app

## Usage

``` r
iSEEhub(ehub, runtime_install = FALSE)
```

## Arguments

- ehub:

  An
  [`ExperimentHub()`](https://rdrr.io/pkg/ExperimentHub/man/ExperimentHub-class.html)
  object.

- runtime_install:

  A logical scalar indicating whether the app may allow users whether to
  install data set dependencies at runtime using
  [`BiocManager::install()`](https://bioconductor.github.io/BiocManager/reference/install.html)
  through a modal prompt.

## Value

An `iSEE()` app with a custom landing page interfacing with `ehub`.

## Examples

``` r
library(ExperimentHub)
ehub <- ExperimentHub()

app <- iSEEhub(ehub)

if (interactive()) {
  shiny::runApp(app, port = 1234)
}
```
