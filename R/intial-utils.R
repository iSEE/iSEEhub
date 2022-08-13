.load_initial <- function(pObjects) {
    dataset_selected_id <- pObjects[[.dataset_selected_id]]
    initial_basename <- pObjects[[.ui_initial]]
    if (length(initial_basename)) {
        initial_dirname <- system.file(package = "iSEEhub", "initial", dataset_selected_id)
        initial_path <- file.path(initial_dirname, initial_basename)
        source(initial_path, local = TRUE)
    } else {
        initial <- NULL
    }
    initial
}
