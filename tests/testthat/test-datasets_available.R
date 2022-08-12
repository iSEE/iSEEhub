# library(testthat); source("test-datasets_available.R")

test_that(".datasets_available works", {
    ehub <- ExperimentHub()
    out <- iSEEhub:::.datasets_available(ehub)
    expect_s3_class(out, "data.frame")
    expect_identical(
        sort(colnames(out)),
        sort(c("title", "dataprovider", "species", "taxonomyid", "genome",
            "description", "coordinate_1_based", "maintainer", "rdatadateadded",
            "preparerclass", "tags", "rdataclass", "rdatapath", "sourceurl",
            "sourcetype")))
})


