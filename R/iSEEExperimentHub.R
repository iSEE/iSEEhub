#' iSEEExperimentHub app
#'
#' @param ehub An instance of [ExperimentHub()].
#'
#' @return An [iSEE()] app with a custom landing page interfacing with the
#' Bioconductor [ExperimentHub()].
#' 
#' @export
#' 
#' @importFrom iSEE iSEE
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
    iSEE(landingPage=landing_page(ehub))
}
