.ui_dataset_table <- "iSEEhub_INTERNAL_datasets_table"
.ui_launch_button <- "iSEEhub_INTERNAL_launch"
.dataset_selected_row <- paste0(.ui_dataset_table, "_rows_selected")
.dataset_selected_id <- paste0(.ui_dataset_table, "_id_selected")
.ui_dataset_columns <- "iSEEhub_INTERNAL_datasets_columns"
.ui_markdown_overview <- "iSEEhub_INTERNAL_markdown_overview"
.ui_dataset_rdataclass <- "iSEEhub_INTERNAL_dataset_rdataclass"
.ui_reset_rdataclasses <- "iSEEhub_INTERNAL_reset_rdataclass"
.ui_launch_yes <- "iSEEhub_INTERNAL_launch_yes"
.ui_launch_no <- "iSEEhub_INTERNAL_launch_no"
.ui_initial <- "iSEEhub_INTERNAL_initial"
.ui_initial_overview <- "iSEEhub_INTERNAL_initial_overview"
.ui_box_dataset <- "iSEEhub_INTERNAL_box_dataset"

#' Observers for \code{\link{iSEEhub}}
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

    # nocov start
    observeEvent(input[[.dataset_selected_row]], {
        dataset_selected_id <- rownames(pObjects$datasets_visible)[input[[.dataset_selected_row]]]
        pObjects[[.dataset_selected_id]] <- dataset_selected_id
        rObjects$rerender_overview <- iSEE:::.increment_counter(isolate(rObjects$rerender_overview))
        initial_choices <- .initial_choices(dataset_selected_id)
        updateSelectizeInput(session, .ui_initial, choices = initial_choices)
    }, ignoreInit = FALSE, ignoreNULL = FALSE)
    # nocov end

    # nocov start
    observeEvent(input[[.ui_dataset_columns]], {
        pObjects[[.ui_dataset_columns]] <- input[[.ui_dataset_columns]]
        rObjects$rerender_datasets <- iSEE:::.increment_counter(isolate(rObjects$rerender_datasets))
    })
    # nocov end

    # nocov start
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
    # nocov end

    # nocov start
    observeEvent(input[[iSEE:::.generalTourSteps]], {
        introjs(session, options=list(steps=.landing_page_tour))
    }, ignoreInit=TRUE)
    # nocov end

    # nocov start
    observeEvent(input[[.ui_reset_rdataclasses]], {
        updateSelectizeInput(session, .ui_dataset_rdataclass, selected = .include_rdataclass)
    })
    # nocov end

    # nocov start
    observeEvent(input[[.ui_initial]], {
        pObjects[[.ui_initial]] <- input[[.ui_initial]]
        rObjects$rerender_initial <- iSEE:::.increment_counter(isolate(rObjects$rerender_initial))
    })
    # nocov end

    invisible(NULL)
}

#' Observers for Launching Main \code{\link{iSEE}} App
#'
#' @param FUN A function to initialize the \code{\link{iSEE}} observer
#' architecture. Refer to [iSEE::createLandingPage()] for more details.
#' @param ehub An [ExperimentHub()] object.
#' @param input The Shiny input object from the server function.
#' @param session The Shiny session object from the server function.
#' @param pObjects An environment containing global parameters generated in the
#' landing page.
#' @param runtime_install A logical scalar indicating whether the app may allow
#' users whether to install data set dependencies at runtime using
#' [BiocManager::install()] through a modal prompt.
#'
#' @return Observers are created in the server function in which this is called.
#' A \code{NULL} value is invisibly returned.
#'
#' @importFrom shiny code hr incProgress modalDialog observeEvent removeModal
#' showModal showNotification withProgress
#'
#' @rdname INTERNAL_create_launch_observers
.create_launch_observers <- function(FUN, ehub, input, session, pObjects, runtime_install) {

    # nocov start
    observeEvent(input[[.ui_launch_button]], {
        deps <- .missing_deps(ehub, pObjects[[.dataset_selected_id]])
        if (length(deps)) {
            if (runtime_install) {
                showModal(modalDialog(
                    p("Install data set dependencies?"),
                    br(), br(),
                    tagList(lapply(deps, code)),
                    hr(),
                    p(
                        style="text-align:center;",
                        actionButton(.ui_launch_yes, "Yes"),
                        actionButton(.ui_launch_no, "No")
                    ),
                    title = "Dependencies required",
                    easyClose = FALSE,
                    footer = NULL
                ))
            } else {
                showModal(modalDialog(
                    p(
                        "Some dependencies required to load the selected data set are missing.",
                        "This app does not allow users to install packages at runtime.",
                        br(), br(),
                        "Please contact the maintainer of this app instance to install the required package(s): ",
                        tagList(lapply(deps, code))
                    ),
                    title = "Dependencies missing",
                    easyClose = TRUE
                    ))
            }
        } else {
            .launch_isee(FUN, ehub, session, pObjects)
        }
    }, ignoreNULL=TRUE, ignoreInit=TRUE)
    # nocov end

    # nocov start
    observeEvent(input[[.ui_launch_yes]], {
        .launch_isee(FUN, ehub, session, pObjects)
        removeModal(session)
    }, ignoreNULL=TRUE, ignoreInit=TRUE)
    # nocov end

    # nocov start
    observeEvent(input[[.ui_launch_no]], {
        showNotification("Launch cancelled.")
        removeModal(session)
    }, ignoreNULL=TRUE, ignoreInit=TRUE)
    # nocov end

    invisible(NULL)
}
