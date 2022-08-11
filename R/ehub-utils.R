#' Load Object Coerced to SingleCellExperiment
#'
#' @param ehub An [ExperimentHub()] object.
#' @param x Numerical or character scalar to retrieve (if necessary) and import
#' the resource from `ehub` into R.
#'
#' @return A [SingleCellExperiment()] object.
#'
#' @import SingleCellExperiment
#' @import ExperimentHub
#' @importFrom SummarizedExperiment SummarizedExperiment
#'
#' @rdname INTERNAL_load_sce
.load_sce <- function(ehub, x) {
    object <- ehub[[x]]
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
