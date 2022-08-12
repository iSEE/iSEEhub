#' Landing page function
#'
#' @param ehub An [ExperimentHub()] object.
#' @param runtime_install Logical scalar indicating whether the app may prompt
#' users whether to install data set dependencies at runtime using
#' [BiocManager::install()].
#'
#' @return A `function` that defines UI elements and observers for the
#' landing page of the app.
#'
#' @importFrom S4Vectors mcols
#' @importFrom methods is as
#' @importFrom shiny actionButton br strong column fluidRow p reactiveValues
#' renderUI selectizeInput showNotification tagList uiOutput
#' @importFrom shinydashboard box
#' @importFrom DT datatable DTOutput renderDT
#' @importFrom rintrojs introjs
#'
#' @rdname INTERNAL_landing_page
.landing_page <- function(ehub, runtime_install) {
    datasets_available_table <- .datasets_available(ehub)
    rdataclasses_available <- .rdataclasses_available(ehub)

    function (FUN, input, output, session) {
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
                    ),
                fluidRow(
                    column(width = 12L,
                        shinydashboard::box(title = "Advanced parameters",
                            collapsible = TRUE, collapsed = TRUE, width = NULL,
                            fluidRow(
                                column(width = 11L,
                                    selectizeInput(inputId = .ui_dataset_rdataclass, label = "Filter R data classes:",
                                        choices = rdataclasses_available,
                                        selected = sort(.include_rdataclass),
                                        multiple = TRUE,
                                        options = list(plugins=list('remove_button'), sortField=list(field = 'text', direction = 'asc')))),
                                column(width = 1L,
                                    br(), br(),
                                    actionButton(.ui_reset_rdataclasses, label="Reset!",
                                        style="color: #ffffff; background-color: #0092AC; border-color: #2e6da4"))
                            ),
                            fluidRow(
                                column(width = 11L,
                                    p(strong("WARNING:"), paste(
                                        "The initial selection above represent currently supported R data classes.",
                                        "All other options should be considered invalid;",
                                        "they are only made available for the purpose of exploring the ExperimentHub.",
                                        "Do not attempt to load objects from those other classes.",
                                        "To request support for new classes, contact us.",
                                        "To reset the initial selection, use the button on the right."
                                        ))) # column
                                ) # fluidRow
                            ) # box
                        ) # column
                    ) # fluidRow
                ) # tagList
        }) # renderUI

        ## Disable navbar buttons that are not linked to any observer yet
        shinyjs::disable(iSEE:::.generalOrganizePanels) # organize panels
        shinyjs::disable(iSEE:::.generalLinkGraph) # link graph
        shinyjs::disable(iSEE:::.generalExportOutput) # export content
        shinyjs::disable(iSEE:::.generalCodeTracker) # tracked code
        shinyjs::disable(iSEE:::.generalPanelSettings) # panel settings
        shinyjs::disable(iSEE:::.generalVignetteOpen) # open vignette
        shinyjs::disable(iSEE:::.generalSessionInfo) # session info
        shinyjs::disable(iSEE:::.generalCitationInfo) # citation info

        pObjects <- .create_persistent_objects(datasets_available_table)
        rObjects <- reactiveValues(rerender_datasets=1L, rerender_overview=1L)

        .create_observers(ehub, input, session, pObjects, rObjects)

        .create_launch_observer(FUN, ehub, input, session, pObjects, runtime_install)

        .render_datasets_table(datasets_available_table, output, pObjects, rObjects)

        .render_markdown_overview(ehub, output, pObjects, rObjects)

        invisible(NULL)
        # nocov end
    }
}

#' Create persistent objects
#'
#' @param datasets_table A `data.frame` of metadata for all available data sets.
#'
#' @return An environment containing several global variables for use throughout the application.
#'
#' @rdname INTERNAL_create_persistent_objects
.create_persistent_objects <- function(datasets_table) {
    pObjects <- new.env()
    pObjects$datasets_visible <- datasets_table
    pObjects
}
