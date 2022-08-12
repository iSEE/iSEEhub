# library(testthat); source("setup-ehub.R"); source("test-ehub-utils.R")

context(".datasets_available")

test_that(".datasets_available works", {
    out <- iSEEhub:::.load_sce(ehub, "EH7082")
    expect_s4_class(out, "SingleCellExperiment")
})
