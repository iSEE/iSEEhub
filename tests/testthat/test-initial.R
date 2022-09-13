# .load_initial ----

test_that(".load_initial works in default settings", {
    pObjects <- new.env()
    pObjects[[iSEEhub:::.dataset_selected_id]] <- "EH1"
    pObjects[[iSEEhub:::.ui_initial]] <- "(Default)"

    out <- iSEEhub:::.load_initial(pObjects)

    expect_null(out)
})

test_that(".load_initial works with an R script", {
    pObjects <- new.env()
    pObjects[[iSEEhub:::.dataset_selected_id]] <- "EH1"
    pObjects[[iSEEhub:::.ui_initial]] <- "config_1.R"

    out <- iSEEhub:::.load_initial(pObjects)

    expect_type(out, "list")
})

test_that(".load_initial throws error if 'initial' object not found", {
    pObjects <- new.env()
    pObjects[[iSEEhub:::.dataset_selected_id]] <- "EH1"
    pObjects[[iSEEhub:::.ui_initial]] <- "config_no_initial.R"

    expect_error(iSEEhub:::.load_initial(pObjects))
})

test_that(".load_initial throws error if script throws error", {
    pObjects <- new.env()
    pObjects[[iSEEhub:::.dataset_selected_id]] <- "EH1"
    pObjects[[iSEEhub:::.ui_initial]] <- "config_error.R"

    expect_error(iSEEhub:::.load_initial(pObjects))
})

# .initial_choices ----

test_that(".initial_choices works", {
    out <- iSEEhub:::.initial_choices("EH1")
    expect_identical(
        out,
        c(Default = "(Default)", "config_1.R", "config_error.R", "config_no_initial.R")
    )
})
