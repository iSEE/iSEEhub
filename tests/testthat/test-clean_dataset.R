# library(testthat); source("test-example_test.R")

test_that(".clean_dataset works on rowData", {
    row_data <- DataFrame(a=NA, b=1 , c=NA, d="a", e=factor("A"))
    se <- SummarizedExperiment(rowData = row_data)

    out <- iSEEhub:::.clean_dataset(se)
    expect_identical(rowData(out)$a, factor("NA"))
    expect_identical(rowData(out)$b, 1)
    expect_identical(rowData(out)$c, factor("NA"))
    expect_identical(rowData(out)$d, "a")
    expect_identical(rowData(out)$e, factor("A"))
})

test_that(".clean_dataset works on colData", {
    col_data <- DataFrame(a=NA, b=1 , c=NA, d="a", e=factor("A"))
    se <- SummarizedExperiment(colData = col_data)

    out <- iSEEhub:::.clean_dataset(se)
    expect_identical(colData(out)$a, factor("NA"))
    expect_identical(colData(out)$b, 1)
    expect_identical(colData(out)$c, factor("NA"))
    expect_identical(colData(out)$d, "a")
    expect_identical(colData(out)$e, factor("A"))
})
