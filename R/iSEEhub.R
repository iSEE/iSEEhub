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
    iSEE(
        landingPage=.landing_page(ehub, runtime_install),
        appTitle = sprintf("iSEEhub - v%s (snapshotDate: %s)",
            packageVersion("iSEEhub"),
            snapshotDate(ehub)
            )
        )
}
