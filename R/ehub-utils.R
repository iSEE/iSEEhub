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
#' @rdname INTERNAL_install_dataset_dependencies
.missing_deps <- function(ehub, x) {
    ehub_dataset <- ehub[x]
    deps <- ehub_dataset$preparerclass
    ip <- rownames(installed.packages())
    missing_deps <- setdiff(deps, ip)
    missing_deps
}
