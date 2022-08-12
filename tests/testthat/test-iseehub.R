# library(testthat); source("test-iseehub.R")

# iSEEhub ----

test_that("iSEEhub works on rowData", {
    out <- iSEEhub(ehub)
    expect_s3_class(out, "shiny.appobj")
})
