#' iSEEhub app
#'
#' @param ehub An [ExperimentHub()] object.
#' @param runtime_install A logical scalar indicating whether the app may allow
#' users whether to install data set dependencies at runtime using
#' [BiocManager::install()] through a modal prompt.
#'
#' @return An [iSEE()] app with a custom landing page interfacing with `ehub`.
#'
#' @export
#'
#' @importFrom iSEE iSEE
#' @importFrom AnnotationHub snapshotDate
#' @importFrom utils packageVersion
#'
#' @examples
#' library(ExperimentHub)
#' ehub <- ExperimentHub()
#'
#' app <- iSEEhub(ehub)
#'
#' if (interactive()) {
#'   shiny::runApp(app, port = 1234)
#' }
iSEEhub <- function(ehub, runtime_install = FALSE) {
    stopifnot(is(ehub, "ExperimentHub"))
    iSEE(
        landingPage=.landing_page(ehub, runtime_install),
        appTitle = sprintf("iSEEhub - v%s (snapshotDate: %s)",
            packageVersion("iSEEhub"),
            snapshotDate(ehub)
            )
        )
}

#' Prepare and Launch the Main App.
#'
#' @details
#' This function wraps steps that can be tracked and reported to the
#' user through a progress bar, using [shiny::withProgress()].
#'
#' @section Unit testing:
#' This function cannot be unit tested (yet), as [shiny::withProgress()]
#' requires a functional `ShinySession` object.
#'
#' This might be revisited in the future.
#'
#' @param FUN A function to initialize the \code{\link{iSEE}} observer
#' architecture. Refer to [iSEE::createLandingPage()] for more details.
#' @param ehub An [ExperimentHub()] object.
#' @param session The Shiny session object from the server function.
#' @param pObjects An environment containing global parameters generated in the
#' landing page.
#'
#' @return A `NULL` value is invisibly returned.
#'
#' @importFrom utils capture.output
#' @importFrom shiny modalDialog showModal
#' @importFrom iSEE iSEEconstants
#'
#' @rdname INTERNAL_launch_isee
.launch_isee <- function(FUN, ehub, session, pObjects) {
    # nocov start
    id_object <- pObjects[[.dataset_selected_id]]
    withProgress(message = sprintf("Loading '%s'", id_object),
        value = 0, max = 3, {
        incProgress(1, detail = "Installing package dependencies")
        .install_dataset_dependencies(ehub, id_object)
        incProgress(1, detail = "(Down)loading object")
        se2 <- try(.load_sce(ehub, id_object))
        incProgress(1, detail = "Launching iSEE app")
        if (is(se2, "try-error")) {
            showNotification("Invalid SummarizedExperiment supplied.", type="error")
        } else {
            se2 <- .clean_dataset(se2)
            initial_message <- capture.output(
                init <- try(.load_initial(pObjects)),
                type = "message")
            if (is(init, "try-error")) {
                showModal(modalDialog(
                    title = "Invalid initial state",
                    p("An error occured while evaluating the script:"),
                    markdown(paste0(c("```", initial_message, "```"), collapse = "\n")),
                    p("Contact the app maintainer for further help."),
                    footer = NULL,
                    size = "l",
                    easyClose = TRUE
                  ))
                return(NULL)
            }
            FUN(SE=se2, INITIAL=init)
            shinyjs::enable(iSEEconstants$generalOrganizePanels) # organize panels
            shinyjs::enable(iSEEconstants$generalLinkGraph) # link graph
            shinyjs::enable(iSEEconstants$generalExportOutput) # export content
            shinyjs::enable(iSEEconstants$generalCodeTracker) # tracked code
            shinyjs::enable(iSEEconstants$generalPanelSettings) # panel settings
            shinyjs::enable(iSEEconstants$generalVignetteOpen) # open vignette
            shinyjs::enable(iSEEconstants$generalSessionInfo) # session info
            shinyjs::enable(iSEEconstants$generalCitationInfo) # citation info
        }
    }, session = session)

    invisible(NULL)
    # nocov end
}
