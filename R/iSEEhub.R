#' iSEEhub app
#'
#' @param ehub An [ExperimentHub()] object.
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
iSEEhub <- function(ehub) {
    iSEE(
        landingPage=landing_page(ehub),
        appTitle = sprintf("iSEEhub - v%s (snapshotDate: %s)",
            packageVersion("iSEEhub"),
            snapshotDate(ehub)
            )
        )
}
