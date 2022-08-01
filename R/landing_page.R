#' Landing page function
#'
#' @param ehub An [ExperimentHub()] object.
#'
#' @return A `function` that defines UI elements and observers for the
#' landing page of the app.
#'
#' @importFrom S4Vectors mcols
#' @importFrom methods is as
#' @importFrom shiny actionButton br strong column fluidRow p reactiveValues renderUI selectizeInput showNotification tagList uiOutput
#' @importFrom shinydashboard box
#' @importFrom DT datatable DTOutput renderDT
#' @importFrom rintrojs introjs
#'
#' @rdname INTERNAL_landing_page
landing_page <- function(ehub) {
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
                    shinydashboard::box(title = "Advanced parameters",
                        collapsible = TRUE, collapsed = TRUE, width = NULL,
                        column(width = 11L,
                            selectizeInput(inputId = .ui_dataset_rdataclass, label = "Filter R data classes:",
                                choices = rdataclasses_available,
                                selected = .include_rdataclass,
                                multiple = TRUE,
                                options = list(plugins=list('remove_button')))),
                        column(width = 1L,
                            br(), br(),
                            actionButton("TODO", label="Reset!",
                                    style="color: #ffffff; background-color: #0092AC; border-color: #2e6da4")),
                        column(width = 12L,
                            p(strong("WARNING:"), paste(
                                "The initial selection above represent currently supported R data classes.",
                                "All other options should be considered invalid;",
                                "they are only made available for the purpose of exploring the ExperimentHub.",
                                "Do not attempt to load objects from those other classes.",
                                "To request support for new classes, contact us."
                                )))
                    )
                )
                )
        })
        # nocov end

        pObjects <- new.env()
        pObjects$datasets_visible <- datasets_available_table
        rObjects <- reactiveValues(rerender_datasets=1L, rerender_overview=1L)

        .create_observers(ehub, input, session, pObjects, rObjects)

        .create_launch_observer(ehub, input, pObjects)

        .render_datasets_table(datasets_available_table, output, pObjects, rObjects)

        .render_markdown_overview(ehub, output, pObjects, rObjects)

        tour <- rbind(
            data.frame(
                element = "#launch",
                intro = "Click this button when you are ready!"
            )
        )

        invisible(NULL)
    }
}
