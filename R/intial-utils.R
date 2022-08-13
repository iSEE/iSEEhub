.load_initial <- function(pObjects) {
    dataset_selected_id <- pObjects[[.dataset_selected_id]]
    initial_basename <- pObjects[[.ui_initial]]
    if (is.na(initial_basename)) {
        initial <- NULL
    } else {
        initial_dirname <- system.file(package = "iSEEhub", "initial", dataset_selected_id)
        initial_path <- file.path(initial_dirname, initial_basename)
        source(initial_path, local = TRUE)
    }
    initial
}
