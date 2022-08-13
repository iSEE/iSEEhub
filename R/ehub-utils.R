#' Load Object Coerced to SingleCellExperiment
#'
#' @param ehub An [ExperimentHub()] object.
#' @param x Numerical or character scalar to retrieve (if necessary) and import
#' the resource from `ehub` into R.
#'
#' @return
#' For `.load_sce()`, a [SingleCellExperiment()] object.
#'
#' @import SingleCellExperiment
#' @import ExperimentHub
#'
#' @rdname INTERNAL_load_sce
.load_sce <- function(ehub, x) {
    object <- ehub[[x]]
    object <- .convert_to_sce(object)
    object
}

#' @param object An object loaded from the Bioconductor [ExperimentHub()].
#'
#' @return
#' For `.convert_to_sce()`, a [SingleCellExperiment()] object.
#'
#' @importFrom methods is as
#' @importFrom SummarizedExperiment SummarizedExperiment
#'
#' @rdname INTERNAL_load_sce
.convert_to_sce <- function(object) {
    if (is(object, "GRanges")) {
        object <- SummarizedExperiment(rowRanges = object)
    }
    if (!is(object, "SummarizedExperiment")) {
        object <- as(object, "SummarizedExperiment")
    }
    if (!is(object, "SingleCellExperiment")) {
        object <- as(object, "SingleCellExperiment")
    }
    object
}

#' Install Package Dependencies
#'
#' Install packages necessary to load a particular data set in the Bioconductor
#' ExperimentHub.
#'
#' @param ehub An [ExperimentHub()] object.
#' @param x Numerical or character scalar to retrieve (if necessary) and import
#' the resource from `ehub` into R.
#'
#' @return
#' For `.install_dataset_dependencies()`,
#' a `character` vector of packaged installed.
#'
#' @importFrom BiocManager install
#'
#' @rdname INTERNAL_install_dataset_dependencies
.install_dataset_dependencies <- function(ehub, x) {
    # nocov start
    ehub_dataset <- ehub[x]
    pkgs <- ehub_dataset$preparerclass
    BiocManager::install(pkgs, update = FALSE)
    # nocov end
}

#' @return
#' For `.missing_deps()`,
#' a character vector of packages that need to be installed.
#'
#' @section Unit tests:
#'
#' The function `.missing_deps()` is not unit tested as we cannot reliably
#' expect a fixed result across all testing platforms
#' (e.g., GitHub, Bioconductor Build System), depending on their respective
#' configuration.
#'
#' In theory, the `Suggests:` field of the `DESCRIPTION` file includes all
#' packages known to be required for loading any of the data sets available
#' in the Bioconductor ExperimentHub.
#' As such, any continuous integration that installs all stated dependencies
#' should always return an empty vector, while minimal installations on
#' users' personal computers are likely to report missing dependencies.
#'
#' @rdname INTERNAL_install_dataset_dependencies
.missing_deps <- function(ehub, x) {
    # nocov start
    ehub_dataset <- ehub[x]
    deps <- ehub_dataset$preparerclass
    ip <- rownames(installed.packages())
    missing_deps <- setdiff(deps, ip)
    missing_deps
    # nocov end
}
