.generateDescriptionSuggests <- function() {
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
