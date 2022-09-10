#' Load an Initial Application State from File
#'
#' @param pObjects An environment containing global parameters generated in the
#' landing page.
#'
#' @return A `list` representing an initial app state.
#'
#' @rdname INTERNAL_load_initial
.load_initial <- function(pObjects) {
    dataset_selected_id <- pObjects[[.dataset_selected_id]]
    initial_basename <- pObjects[[.ui_initial]]
    if (identical(initial_basename, "(Default)")) {
        initial <- NULL
    } else {
        initial_dirname <- system.file(package = "iSEEhub", "initial", dataset_selected_id)
        initial_path <- file.path(initial_dirname, initial_basename)
        source(initial_path, local = TRUE)
        if (!exists("initial")) {
            stop("No object named 'initial' was found - this needs to be ",
                 "defined in the config script.")
        }
    }
    initial
}

.initial_choices <- function(x) {
    # x: EH identifier of the data set in the ExperimentHub
    dataset_dir <- system.file(package = "iSEEhub", "initial", x)
    choices <- c("Default" = "(Default)")
    if (dir.exists(dataset_dir)) {
        choices <- c(choices, list.files(dataset_dir))
    }
    choices
}
