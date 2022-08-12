# library(testthat); source("test-iseehub.R")

test_that("iSEEhub works on rowData", {
    out <- iSEEhub:::.landing_page(ehub)
    expect_type(out, "closure")
})
