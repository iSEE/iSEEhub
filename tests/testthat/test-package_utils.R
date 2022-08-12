# library(testthat); source("test-outputs.R")

# .generate_description_suggests ----

test_that(".generate_description_suggests works", {
    out <- iSEEhub:::.generate_description_suggests(ehub)

    expect_vector(out, character(), 1)
})

