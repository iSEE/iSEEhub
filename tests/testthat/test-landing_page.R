# library(testthat); source("test-landing_page.R")

test_that(".landing_page works", {
    out <- iSEEhub:::.landing_page(ehub)
    expect_type(out, "closure")
})

test_that(".create_persistent_objects works", {
    df <- data.frame(a=1, b="a")

    out <- iSEEhub:::.create_persistent_objects(df)
    expect_identical(out$datasets_visible, df)
})
