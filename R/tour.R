.landing_page_tour <- rbind(
    data.frame(
        element=paste0("#", .ui_dataset_table),
        intro=paste0(
            "This table displays data sets available in the snapshot of Bioconductor ExperimentHub loaded in this landing page.<br/><br/>",
            "Browse this table and select the row that corresponds to the data set that you wish to load.<br/><br/>",
            "No more than one row can be selected at any time.")
        ),
    data.frame(
        element=paste0("#", .ui_markdown_overview),
        intro=paste0(
            "This panel collates all known information about the selected data set in the Bioconductor ExperimentHub metadata.")
        ),
    data.frame(
        element=paste0("#", .ui_launch_button),
        intro=paste0(
            "Click this button when you are ready to load and visualise the selected data set!<br/><br/>",
            "Please be patient when loading a data set for the first time on a new computer, ",
            "as the data set must first be downloaded from the Bioconductor ExperimentHub to the local cache, ",
            " and package dependencies specific to each data set may need to be installed.<br/><br/>",
            "Subsequent sessions will load the data set directly from the local cache, ",
            "resulting in a much faster loading time."
        )
    )
)
