.ui_dataset_table <- "iSEEExperiment_INTERNAL_datasets_table"
.ui_launch_button <- "iSEEExperiment_INTERNAL_launch"
.dataset_selected_row <- paste0(.ui_dataset_table, "_rows_selected")
.dataset_selected_id <- paste0(.ui_dataset_table, "_id_selected")
.ui_dataset_columns <- "iSEEExperiment_INTERNAL_datasets_columns"
.ui_markdown_overview <- "iSEEExperiment_INTERNAL_markdown_overview"
.ui_dataset_rdataclass <- "iSEEExperiment_INTERNAL_dataset_rdataclass"
.ui_reset_rdataclasses <- "iSEEExperiment_INTERNAL_reset_rdataclass"
.ui_modal_load_messages <- "iSEEExperiment_INTERNAL_modal_load_messages"

#' Observers for \code{\link{iSEEExperimentHub}}
#'
#' @param input The Shiny input object from the server function.
#' @param pObjects An environment containing global parameters generated in the landing page.
#' @param rObjects A reactive list of values generated in the landing page.
#'
#' @return Observers are created in the server function in which this is called.
#' A \code{NULL} value is invisibly returned.
#'
#' @importFrom shiny isolate observeEvent updateSelectizeInput
#' @importFrom shinyjs disable enable
#'
#' @rdname INTERNAL_create_observers
.create_observers <- function(ehub, input, session, pObjects, rObjects) {

        observeEvent(input[[.dataset_selected_row]], {
            pObjects[[.dataset_selected_id]] <- rownames(pObjects$datasets_visible)[input[[.dataset_selected_row]]]
            rObjects$rerender_overview <- iSEE:::.increment_counter(isolate(rObjects$rerender_overview))
        }, ignoreInit = FALSE, ignoreNULL = FALSE)

        observeEvent(input[[.ui_dataset_columns]], {
            pObjects[[.ui_dataset_columns]] <- input[[.ui_dataset_columns]]
            rObjects$rerender_datasets <- iSEE:::.increment_counter(isolate(rObjects$rerender_datasets))
        })

        observeEvent(input[[.ui_dataset_rdataclass]], {
            value <- input[[.ui_dataset_rdataclass]]
            pObjects[[.ui_dataset_rdataclass]] <- value
            if (identical(sort(value), sort(.include_rdataclass))) {
                shinyjs::disable(.ui_reset_rdataclasses)
            } else {
                shinyjs::enable(.ui_reset_rdataclasses)
            }
            rObjects$rerender_datasets <- iSEE:::.increment_counter(isolate(rObjects$rerender_datasets))
        })

        observeEvent(input[[iSEE:::.generalTourSteps]], {
            introjs(session, options=list(steps=.landing_page_tour))
        }, ignoreInit=TRUE)

        observeEvent(input[[.ui_reset_rdataclasses]], {
            updateSelectizeInput(session, .ui_dataset_rdataclass, selected = .include_rdataclass)
        })

        invisible(NULL)
}

#' Observers for Launching Main \code{\link{iSEE}} App
#'
#' @param FUN A function to initialize the \code{\link{iSEE}} observer architecture.
#' Refer to [iSEE::createLandingPage()] for more details.
#' @param ehub An [ExperimentHub()] object.
#' @param input The Shiny input object from the server function.
#' @param session The Shiny session object from the server function.
#' @param pObjects An environment containing global parameters generated in the landing page.
#'
#' @return Observers are created in the server function in which this is called.
#' A \code{NULL} value is invisibly returned.
#'
#' @importFrom shiny incProgress modalDialog observeEvent showModal
#' showNotification verbatimTextOutput withProgress
#'
#' @rdname INTERNAL_create_launch_observer
.create_launch_observer <- function(FUN, ehub, input, output, session, pObjects, rObjects) {

    rObjects[[.ui_modal_load_messages]] <- ""
    output[[.ui_modal_load_messages]] <- renderText({ paste0(rObjects[[.ui_modal_load_messages]], collapse = "\n") })

    # nocov start
    observeEvent(input[[.ui_launch_button]], {
        showModal(modalDialog(
            title="Console Messages", size="l", fade=FALSE,
            footer=NULL, easyClose=FALSE,
            verbatimTextOutput(.ui_modal_load_messages)
        ))

        withProgress(message = 'Loading Data Set', value = 0, max = 2, {
            id_object <- pObjects[[.dataset_selected_id]]
            incProgress(1, detail = sprintf("Loading '%s'", id_object))
            se2 <- try({
                rObjects[[.ui_modal_load_messages]] <- capture.output(
                    out <- .load_sce(ehub, pObjects[[.dataset_selected_id]]),
                    type = "message"
                )
                out
            })
            incProgress(1, detail = "Launching iSEE")
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
                # removeModal(session = session)
            }
        }, session = session)
    }, ignoreNULL=TRUE, ignoreInit=TRUE)
    # nocov end

    invisible(NULL)
}
