# library(testthat); source("setup-ehub.R"); source("test-ehub-utils.R")

# .datasets_available ----

test_that(".datasets_available works", {
    out <- iSEEhub:::.load_sce(ehub, "EH7082")
    expect_s4_class(out, "SingleCellExperiment")
})

# .convert_to_sce ----

test_that(".convert_to_sce works for GRanges", {

    out <- iSEEhub:::.convert_to_sce(GRanges())
    expect_s4_class(out, "SingleCellExperiment")

})

test_that(".convert_to_sce works for ExpressionSet", {

    out <- iSEEhub:::.convert_to_sce(ExpressionSet())
    expect_s4_class(out, "SingleCellExperiment")

})

test_that(".convert_to_sce works for SummarizedExperiment", {

    out <- iSEEhub:::.convert_to_sce(SummarizedExperiment())
    expect_s4_class(out, "SingleCellExperiment")

})
