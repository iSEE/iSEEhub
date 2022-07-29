#' Landing page function
#'
#' @param ehub An instance of [ExperimentHub()].
#'
#' @return A [function()] that defines UI elements and observers for the
#' landing page of the app.
#' 
#' @importFrom S4Vectors mcols
#' @importFrom methods is as
#' @importFrom shiny actionButton column fluidRow isolate markdown observeEvent p reactiveValues renderUI selectizeInput showNotification tagList uiOutput
#' @importFrom shinydashboard box
#' @importFrom DT datatable DTOutput renderDT
#' @importFrom rintrojs introjs
#' 
#' @rdname INTERNAL_landing_page
landing_page <- function(ehub) {
    datasets_available_table <- .datasets_available(ehub)
    
    se_load <- function(x) {
        object <- ehub[[x]]
        if (!is(object, "SummarizedExperiment")) {
            object <- as(object, "SummarizedExperiment")
        }
        object <- as(object, "SingleCellExperiment")
        object
    }
    
    function (FUN, input, output, session) {
        .ui_dataset_table <- "datasets_table"
        .ui_launch_button <- "launch"
        .dataset_selected_id <- paste0(.ui_dataset_table, "_rows_selected")
        .ui_dataset_columns <- "datasets_columns"
        .ui_markdown_overview <- "markdown_overview"
        
        # nocov start
        output$allPanels <- renderUI({
            tagList(
                fluidRow(
                    column(width = 7L,
                        shinydashboard::box(title = "ExperimentHub",
                            collapsible = FALSE, width = NULL,
                            selectizeInput(inputId = .ui_dataset_columns, label = "Show columns:",
                                choices = colnames(datasets_available_table),
                                selected = c("title", "dataprovider", "species", "rdataclass"),
                                multiple = TRUE,
                                options = list(plugins=list('remove_button', 'drag_drop'))),
                            DTOutput(.ui_dataset_table)
                    )),
                    column(width = 5L,
                        shinydashboard::box(title = "Selected dataset",
                            collapsible = FALSE, width = NULL,
                            uiOutput(.ui_markdown_overview),
                            p(
                                actionButton(.ui_launch_button, label="Launch!",
                                    style="color: #ffffff; background-color: #0092AC; border-color: #2e6da4"),
                                style="text-align: center;"))
                        )
                    )
                )
        })
        # nocov end
        
        pObjects <- new.env()
        rObjects <- reactiveValues(rerender_datasets=1L, rerender_overview=1L)
        
        observeEvent(input[[.dataset_selected_id]], {
            pObjects[[.dataset_selected_id]] <- rownames(datasets_available_table)[input[[.dataset_selected_id]]]
            rObjects$rerender_overview <- iSEE:::.increment_counter(isolate(rObjects$rerender_overview))
        }, ignoreInit = FALSE, ignoreNULL = FALSE)
        
        output[[.ui_markdown_overview]] <- renderUI({
            force(rObjects$rerender_overview)
            dataset_selected_id <- pObjects[[.dataset_selected_id]]
            if (!length(dataset_selected_id)) {
                contents <- markdown("Please select a data set.")
            } else {
                ehub_selected <- ehub[dataset_selected_id]
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
        
        observeEvent(input[[.ui_dataset_columns]], {
            pObjects[[.ui_dataset_columns]] <- input[[.ui_dataset_columns]]
            rObjects$rerender_datasets <- iSEE:::.increment_counter(isolate(rObjects$rerender_datasets))
        })
        
        output[[.ui_dataset_table]] <- DT::renderDT({
            force(rObjects$rerender_datasets)
            datasets_table_visible <- datasets_available_table[, pObjects[[.ui_dataset_columns]]]
            DT::datatable(datasets_table_visible, filter="top", rownames=TRUE,
            options=list(
                search=list(search="", smart=FALSE, regex=TRUE, caseInsensitive=FALSE),
                searchCols=c(list(NULL), list(NULL)), # row names are the first column!
                scrollX=TRUE,
                columnDefs=NULL),
            selection=list(mode = 'single', selected=1L, target = 'row'))
        })

        # nocov start, ignoreNULL=TRUE, ignoreInit=TRUE
        observeEvent(input[[.ui_launch_button]], {
            se2 <- try(se_load(pObjects[[.dataset_selected_id]]))
            if (is(se2, "try-error")) {
                showNotification("invalid SummarizedExperiment supplied", type="error")
            } else {
                # init <- try(initLoad(input[[.initializeInitial]]))
                # if (is(init, "try-error")) {
                #     showNotification("invalid initial state supplied", type="warning")
                #     init <- NULL
                # }
                # init <- list(ReducedDimensionPlot())
                init <- NULL
                FUN(SE=se2, INITIAL=init)
            }
        }, ignoreNULL=TRUE, ignoreInit=TRUE)
        # nocov end
        
        tour <- rbind(
            data.frame(
                element = "#launch",
                intro = "Click this button when you are ready!"
            )
        )
        
        observeEvent(input[[iSEE:::.generalTourSteps]], {
            introjs(session, options=list(steps=tour))
        }, ignoreInit=TRUE)

        invisible(NULL)
    }
}