#' iSEEExperimentHub app
#'
#' @param ehub An [ExperimentHub()] object.
#'
#' @return An [iSEE()] app with a custom landing page interfacing with `ehub`.
#' 
#' @export
#' 
#' @importFrom iSEE iSEE
#' @importFrom AnnotationHub snapshotDate
#'
#' @examples
#' library(ExperimentHub)
#' ehub <- ExperimentHub()
#' 
#' app <- iSEEExperimentHub(ehub)
#' 
#' if (interactive()) {
#'   shiny::runApp(app, port = 1234)
#' }
iSEEExperimentHub <- function(ehub) {
    iSEE(
        landingPage=landing_page(ehub),
        appTitle = sprintf("iSEEExperimentHub - v%s (snapshotDate: %s)",
            packageVersion("iSEEExperimentHub"),
            snapshotDate(ehub)
            )
        )
}
