#' Generate the DESCRIPTION 'Suggests' Field
#' 
#' A helper function to generate the 'Suggests' field of the `DESCRIPTION` file.
#' 
#' @details 
#' The return value can be passed to [cat()] to display the result in a way
#' that may be copy-pasted into the `DESCRIPTION` file.
#'
#' @return A `character` scalar that may be used to update the 'Suggests' field
#' of the `DESCRIPTION` file.
#' 
#' @export
#' 
#' @rdname INTERNAL_generate_description_suggests
.generate_description_suggests <- function() {
    extras <- c("BiocStyle", "covr", "knitr", "RefManageR", "rmarkdown",
        "sessioninfo", "testthat (>= 3.0.0)")
    datasets_available_table <- .datasets_available()
    ehub_suggested_packages <- unique(datasets_available_table$preparerclass)
    available_packages <- BiocManager::available()
    final_suggested_packages <- intersect(ehub_suggested_packages, available_packages)
    paste0(
        "Suggests:\n",
        paste0("    ", sort(unique(c(final_suggested_packages, extras))), collapse=",\n"),
        collapse = ""
    )
}
