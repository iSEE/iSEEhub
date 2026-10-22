# Contributing to iSEEhub

## Initial app configurations

### Overview

Initial app configurations configure the set of panels and their
respective initial state when the main
*[iSEE](https://bioconductor.org/packages/3.24/iSEE)* app is launched.

Initial app configurations are implemented as *R* scripts that are
stored in the `inst/initial` subdirectory of the
*[iSEEhub](https://bioconductor.org/packages/3.24/iSEEhub)* package.
Within that directory, the app expects a subdirectory named exactly as
the `EH` identifier of each dataset for which additional configurations
are made available. Within each dataset-specific directory, the app
expects any number of *R* scripts, each script defining one
configuration.

Contributions to initial app configurations are welcome to the
*[iSEEhub](https://bioconductor.org/packages/3.24/iSEEhub)* as pull
requests, both as new configurations and edits to existing
configurations.

### Requirements

An initial configuration script must define at least one object called
`initial`, that contains a list of instances of panel classes defined in
the *[iSEE](https://bioconductor.org/packages/3.24/iSEE)* package –
so-called built-in panels – and other packages that extend
*[iSEE](https://bioconductor.org/packages/3.24/iSEE)* functionality.
That is, packages like
*[iSEEu](https://bioconductor.org/packages/3.24/iSEEu)* and
*[iSEEhex](https://bioconductor.org/packages/3.24/iSEEhex)*.

Other objects created by configuration scripts are ignored. We encourage
users to refrain from creating any other object than `initial`, to avoid
any unexpected behaviour in the app.

### Example

For demonstration, the package includes two configurations for the
dataset `EH1`.

The scripts that define those configurations are stored within the
directory `inst/initial/EH1`. Within that directory, the files are named
`config_1.R` and `config_error.R`.

The script `config_1.R` defines an initial app state that contains only
one panel, namely a `ComplexHeatmapPlot`, that is configured to span
half the width of the app (6 out of 12 units in
*[shiny](https://bioconductor.org/packages/3.24/shiny)* units), and
displays the metadata `gender` and `status` as color bars next to the
heat map.

    ## EH1/config_1.R
    library(iSEE)

    initial <- list(
        ComplexHeatmapPlot(
            PanelWidth = 6L,
            ColumnData = c("gender", "tumor_status")
        )
    )

Conversely, the script `config_error.R` provides a brutal example of an
invalid script that throws an error. This script is only included in the
package to test and demonstrate that the app fails elegantly when an
invalid configuration is supplied (which should never happen in the
first place).

    ## EH1/config_error.R
    # This script demonstrates how the app handles a bad configuration.

    stop("Bad config script!")

### Process for contributing

- Fork the GitHub repository for
  [iSEEhub](https://github.com/iSEE/iSEEhub/).
- Create and/or edit appropriate files and directories within the
  `inst/initial` directory.
- Test your new configuration(s) locally; install the updated
  *[iSEEhub](https://bioconductor.org/packages/3.24/iSEEhub)* package,
  launch the app, and load dataset(s) using the new configuration(s).
- Open a pull request on the GitHub repository
  [iSEEhub](https://github.com/iSEE/iSEEhub/).
- Wait for maintainers to review and approve the pull request.

## Reproducibility

The *[iSEEhub](https://bioconductor.org/packages/3.24/iSEEhub)* package
(Rue-Albrecht, 2024) was made possible thanks to:

- R (R Core Team, 2026)
- *[BiocStyle](https://bioconductor.org/packages/3.24/BiocStyle)* (Oleś,
  2026)
- *[knitr](https://CRAN.R-project.org/package=knitr)* (Xie, 2026)
- *[RefManageR](https://CRAN.R-project.org/package=RefManageR)* (McLean,
  2017)
- *[rmarkdown](https://CRAN.R-project.org/package=rmarkdown)* (Allaire,
  Xie, Dervieux, McPherson, Luraschi, Ushey, Atkins, Wickham, Cheng,
  Chang, and Iannone, 2026)
- *[sessioninfo](https://CRAN.R-project.org/package=sessioninfo)*
  (Wickham, Chang, Flight, Müller, and Hester, 2026)
- *[testthat](https://CRAN.R-project.org/package=testthat)* (Wickham,
  2011)

This package was developed using
*[biocthis](https://bioconductor.org/packages/3.24/biocthis)*.

Code for creating the vignette

\
`## Create the vignette`\
[`library`](https://rdrr.io/r/base/library.html)`(`[`"rmarkdown"`](https://github.com/rstudio/rmarkdown)`)`\
[`system.time`](https://rdrr.io/r/base/system.time.html)`(`[`render`](https://pkgs.rstudio.com/rmarkdown/reference/render.html)`(``"iSEEhub.Rmd"``, ``"BiocStyle::html_document"``)``)`\
\
`## Extract the R code`\
[`library`](https://rdrr.io/r/base/library.html)`(`[`"knitr"`](https://yihui.org/knitr/)`)`\
[`knit`](https://rdrr.io/pkg/knitr/man/knit.html)`(``"iSEEhub.Rmd"``, tangle ``=`` ``TRUE``)`

Date the vignette was generated.

    #> [1] "2026-10-22 13:57:27 UTC"

Wallclock time spent generating the vignette.

    #> Time difference of 0.512 secs

*R* session information.

    #> ─ Session info ───────────────────────────────────────────────────────────────────────────────────────────────────────
    #>  setting  value
    #>  version  R version 4.6.1 (2026-06-24)
    #>  os       Ubuntu 24.04.5 LTS
    #>  system   x86_64, linux-gnu
    #>  ui       X11
    #>  language en
    #>  collate  en_US.UTF-8
    #>  ctype    en_US.UTF-8
    #>  tz       UTC
    #>  date     2026-10-22
    #>  pandoc   3.12.1 @ /usr/bin/ (via rmarkdown)
    #>  quarto   1.10.18 @ /usr/local/bin/quarto
    #> 
    #> ─ Packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────
    #>  package     * version date (UTC) lib source
    #>  bibtex        0.5.3   2026-09-22 [1] RSPM (R 4.6.0)
    #>  BiocManager   1.30.27 2025-11-14 [2] CRAN (R 4.6.1)
    #>  BiocStyle   * 2.41.0  2026-04-28 [1] Bioconductor 3.24 (R 4.6.1)
    #>  bookdown      0.48    2026-08-28 [1] RSPM (R 4.6.0)
    #>  bslib         0.12.0  2026-08-04 [2] RSPM (R 4.6.0)
    #>  cachem        1.1.0   2024-05-16 [2] RSPM (R 4.6.0)
    #>  cli           3.6.6   2026-04-09 [2] RSPM (R 4.6.0)
    #>  desc          1.4.3   2023-12-10 [2] RSPM (R 4.6.0)
    #>  digest        0.6.39  2025-11-19 [2] RSPM (R 4.6.0)
    #>  evaluate      1.0.5   2025-08-27 [2] RSPM (R 4.6.0)
    #>  fastmap       1.2.0   2024-05-15 [2] RSPM (R 4.6.0)
    #>  fs            2.1.0   2026-04-18 [2] RSPM (R 4.6.0)
    #>  generics      0.1.4   2025-05-09 [1] RSPM (R 4.6.0)
    #>  glue          1.8.1   2026-04-17 [2] RSPM (R 4.6.0)
    #>  htmltools     0.5.9   2025-12-04 [2] RSPM (R 4.6.0)
    #>  htmlwidgets   1.6.4   2023-12-06 [2] RSPM (R 4.6.0)
    #>  httr          1.4.9   2026-09-01 [1] RSPM (R 4.6.0)
    #>  jquerylib     0.1.4   2021-04-26 [2] RSPM (R 4.6.0)
    #>  jsonlite      2.0.0   2025-03-27 [2] RSPM (R 4.6.0)
    #>  knitr         1.52    2026-09-06 [2] RSPM (R 4.6.0)
    #>  lifecycle     1.0.5   2026-01-08 [2] RSPM (R 4.6.0)
    #>  lubridate     1.9.5   2026-02-04 [1] RSPM (R 4.6.0)
    #>  magrittr      2.0.5   2026-04-04 [2] RSPM (R 4.6.0)
    #>  otel          0.2.0   2025-08-29 [2] RSPM (R 4.6.0)
    #>  pkgdown       2.2.1   2026-07-07 [2] RSPM (R 4.6.0)
    #>  plyr          1.8.9   2023-10-02 [1] RSPM (R 4.6.0)
    #>  R6            2.6.1   2025-02-15 [2] RSPM (R 4.6.0)
    #>  ragg          1.5.2   2026-03-23 [2] RSPM (R 4.6.0)
    #>  Rcpp          1.1.2   2026-07-05 [2] RSPM (R 4.6.0)
    #>  RefManageR  * 1.4.0   2022-09-30 [1] RSPM (R 4.6.0)
    #>  rlang         1.3.0   2026-07-05 [2] RSPM (R 4.6.0)
    #>  rmarkdown     2.32    2026-09-01 [2] RSPM (R 4.6.0)
    #>  sass          0.4.10  2025-04-11 [2] RSPM (R 4.6.0)
    #>  sessioninfo * 1.2.4   2026-06-04 [2] RSPM (R 4.6.0)
    #>  stringi       1.8.9   2026-08-04 [2] RSPM (R 4.6.0)
    #>  stringr       1.6.0   2025-11-04 [1] RSPM (R 4.6.0)
    #>  systemfonts   1.3.2   2026-03-05 [2] RSPM (R 4.6.0)
    #>  textshaping   1.0.5   2026-03-06 [2] RSPM (R 4.6.0)
    #>  timechange    0.4.0   2026-01-29 [1] RSPM (R 4.6.0)
    #>  xfun          0.62    2026-10-16 [2] RSPM (R 4.6.0)
    #>  xml2          1.6.0   2026-06-22 [2] RSPM (R 4.6.0)
    #>  yaml          2.3.12  2025-12-10 [2] RSPM (R 4.6.0)
    #> 
    #>  [1] /__w/_temp/Library
    #>  [2] /usr/local/lib/R/site-library
    #>  [3] /usr/local/lib/R/library
    #>  * ── Packages attached to the search path.
    #> 
    #> ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

## Bibliography

This vignette was generated using
*[BiocStyle](https://bioconductor.org/packages/3.24/BiocStyle)* (Oleś,
2026) with *[knitr](https://CRAN.R-project.org/package=knitr)* (Xie,
2026) and *[rmarkdown](https://CRAN.R-project.org/package=rmarkdown)*
(Allaire, Xie, Dervieux et al., 2026) running behind the scenes.

Citations made with
*[RefManageR](https://CRAN.R-project.org/package=RefManageR)* (McLean,
2017).

[\[1\]](#cite-allaire2026rmarkdown) J. Allaire, Y. Xie, C. Dervieux, et
al. *rmarkdown: Dynamic Documents for R*. R package version 2.32. 2026.
URL: <https://github.com/rstudio/rmarkdown>.

[\[2\]](#cite-mclean2017refmanager) M. W. McLean. “RefManageR: Import
and Manage BibTeX and BibLaTeX References in R”. In: *The Journal of
Open Source Software* (2017). DOI:
[10.21105/joss.00338](https://doi.org/10.21105/joss.00338).

[\[3\]](#cite-ole2026biocstyle) A. Oleś. *BiocStyle: Standard styles for
vignettes and other Bioconductor documents*. R package version 2.41.0.
2026. DOI:
[10.18129/B9.bioc.BiocStyle](https://doi.org/10.18129/B9.bioc.BiocStyle).
URL: <https://bioconductor.org/packages/BiocStyle>.

[\[4\]](#cite-2026language) R Core Team. *R: A Language and Environment
for Statistical Computing*. R Foundation for Statistical Computing (ROR:
\<<https://ror.org/05qewa988%3E>;). Vienna, Austria, 2026. DOI:
[10.32614/R.manuals](https://doi.org/10.32614/R.manuals). URL:
<https://www.R-project.org/>.

[\[5\]](#cite-ruealbrecht2024iseehub) K. Rue-Albrecht. *iSEEhub: iSEE
for the Bioconductor ExperimentHub*. R package version 1.15.0. 2024.
URL: <https://github.com/iSEE/iSEEhub>.

[\[6\]](#cite-wickham2011testthat) H. Wickham. “testthat: Get Started
with Testing”. In: *The R Journal* 3 (2011), pp. 5–10. URL:
<https://journal.r-project.org/articles/RJ-2011-002/>.

[\[7\]](#cite-wickham2026sessioninfo) H. Wickham, W. Chang, R. Flight,
et al. *sessioninfo: R Session Information*. R package version 1.2.4.
2026. URL: <https://sessioninfo.r-lib.org>.

[\[8\]](#cite-xie2026knitr) Y. Xie. *knitr: A General-Purpose Package
for Dynamic Report Generation in R*. R package version 1.52. 2026. URL:
<https://yihui.org/knitr/>.
