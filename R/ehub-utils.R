#' Load Object Coerced to SingleCellExperiment
#'
#' @param ehub An instance of [ExperimentHub()].
#' @param x Numerical or character scalar to retrieve (if necessary) and import
#' the resource from the [ExperimentHub::ExperimentHub-class] into R.
#'
#' @return A [SingleCellExperiment::SingleCellExperiment-class] object.
#'
#' @rdname INTERNAL_load_sce
.load_sce <- function(ehub, x) {
    object <- ehub[[x]]
    if (!is(object, "SummarizedExperiment")) {
        object <- as(object, "SummarizedExperiment")
    }
    object <- as(object, "SingleCellExperiment")
    object
}
