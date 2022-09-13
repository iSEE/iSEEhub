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

# .missing_deps ----

test_that(".missing_deps returns empty vector when dependencies are present", {

    # ExpressionSet is supported
    # package 'GSE62944' is installed through Suggests:
    out <- iSEEhub:::.missing_deps(ehub, "EH7082")
    expect_vector(out, character(), 0)

})

test_that(".missing_deps detects missing dependencies", {

    # BamFile is not supported
    # package 'RNAmodR.Data' is not installed as an iSEEhub dependency
    out <- iSEEhub:::.missing_deps(ehub, "EH2519")
    expect_vector(out, character(), 1)

})
