#' Render Table of Available Data Sets
#'
#' @param datasets_table A `data.frame` of metadata for all available data sets.
#' @param output The Shiny output object from the server function.
#' @param pObjects An environment containing global parameters generated in the landing page.
#' @param rObjects A reactive list of values generated in the landing page.
#'
#' @return Adds a rendered [DT::datatable()] to `output`.
#' A \code{NULL} value is invisibly returned.
#'
#' @rdname INTERNAL_render_datasets_table
.render_datasets_table <- function(datasets_table, output, pObjects, rObjects) {
    # nocov start
    output[[.ui_dataset_table]] <- DT::renderDT({
        force(rObjects$rerender_datasets)
        keep_rdataclass_indices <- which(datasets_table$rdataclass %in% pObjects[[.ui_dataset_rdataclass]])
        keep_rows <- keep_rdataclass_indices
        keep_columns <- pObjects[[.ui_dataset_columns]]
        datasets_table_visible <- datasets_table[keep_rows, keep_columns]
        columns_factor <- intersect(colnames(datasets_table_visible), .ehub_columns_factor)
        datasets_table_visible <- .dataset_factor_columns(datasets_table_visible, columns_factor)
        pObjects$datasets_visible <- datasets_table_visible
        DT::datatable(pObjects$datasets_visible, filter="top", rownames=TRUE,
            options=list(
                search=list(search="", smart=FALSE, regex=TRUE, caseInsensitive=FALSE),
                searchCols=c(list(NULL), list(NULL)), # row names are the first column!
                scrollX=TRUE,
                columnDefs=NULL),
            selection=list(mode = 'single', selected=1L, target = 'row'))
    })
    # nocov end

    invisible(NULL)
}

#' Render Markdown Overview of Selected Data Set
#'
#' @param ehub An [ExperimentHub()] object.
#' @param output The Shiny output object from the server function.
#' @param pObjects An environment containing global parameters generated in the landing page.
#' @param rObjects A reactive list of values generated in the landing page.
#'
#' @return Adds a rendered [DT::datatable()] to `output`.
#' A \code{NULL} value is invisibly returned.
#'
#' @importFrom shiny markdown
#'
#' @rdname INTERNAL_render_markdown_overview
.render_markdown_overview <- function(ehub, output, pObjects, rObjects) {
    # nocov start
    output[[.ui_markdown_overview]] <- renderUI({
        force(rObjects$rerender_overview)
        dataset_selected_row <- pObjects[[.dataset_selected_id]]
        if (!length(dataset_selected_row)) {
            contents <- markdown("Please select a data set.")
        } else {
            ehub_selected <- ehub[dataset_selected_row]
            contents <- markdown(paste0(
                "# ", sprintf("[%s]", ehub_selected$ah_id), " ", ehub_selected$title, "\n\n",
                "- **Data provider:** ", ehub_selected$dataprovider, "\n\n",
                "- **Species:** ", ehub_selected$species, "\n\n",
                "- **Taxonomy ID:** ", ehub_selected$taxonomyid, "\n\n",
                "- **Genome:** ", ehub_selected$genome, "\n\n",
                "## Description", "\n\n", ehub_selected$description, "\n\n",
                "## Details", "\n\n",
                "- **Coordinate 1-based:** ", as.logical(ehub_selected$coordinate_1_based), "\n\n",
                "- **Maintainer:** ", ehub_selected$maintainer, "\n\n",
                "- **Date added:** ", ehub_selected$rdatadateadded, "\n\n",
                "- **Preparer class:** ", ehub_selected$preparerclass, "\n\n",
                "- **R data class:** ", ehub_selected$rdataclass, "\n\n",
                "- **R data path:** ", ehub_selected$rdatapath, "\n\n",
                "- **Source URL:** ", ehub_selected$sourceurl, "\n\n",
                "- **Source type:** ", ehub_selected$sourcetype, "\n\n",
                "## Tags", "\n\n",
                paste0(sprintf("- %s", strsplit(ehub_selected$tags, ", ")[[1]]), collapse = "\n")
            ))
        }
        contents
    })
    # nocov end

    invisible(NULL)
}
