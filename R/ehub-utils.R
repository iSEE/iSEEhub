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
#' @importFrom methods is
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
