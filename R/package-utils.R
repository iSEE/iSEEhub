#' Generate the DESCRIPTION 'Suggests' Field
#'
#' A helper function to generate the 'Suggests' field of the `DESCRIPTION` file.
#'
#' @param ehub An [ExperimentHub()] object.
#'
#' @details
#' The return value can be passed to [cat()] to display the result in a way
#' that may be copy-pasted into the `DESCRIPTION` file.
#'
#' @return A `character` scalar that may be used to update the 'Suggests' field
#' of the `DESCRIPTION` file.
#'
#' @importFrom BiocManager available
#'
#' @rdname INTERNAL_dataset_packages_enhanced
.dataset_packages_enhanced <- function(ehub) {
    datasets_available_table <- .datasets_available(ehub)
    keep_rows <- datasets_available_table$rdataclass %in% .include_rdataclass
    datasets_available_table <- datasets_available_table[keep_rows, , drop = FALSE]
    ehub_enhanced_packages <- unique(datasets_available_table$preparerclass)
    available_packages <- BiocManager::available()
    final_suggested_packages <- intersect(ehub_enhanced_packages, available_packages)
    paste0(
        "Enhances:\n",
        paste0("    ", sort(unique(final_suggested_packages)), collapse=",\n"),
        collapse = ""
    )
}
