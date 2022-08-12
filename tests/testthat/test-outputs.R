# library(testthat); source("test-outputs.R")

# .render_datasets_table ----

test_that(".render_datasets_table works", {
    df <- data.frame(a=1, b="a")
    output <- new.env()
    pObjects <- new.env()
    rObjects <- new.env()

    out <- iSEEhub:::.render_datasets_table(df, output, pObjects, rObjects)
    expect_null(out)
    expect_named(output, "iSEEExperiment_INTERNAL_datasets_table")

})
