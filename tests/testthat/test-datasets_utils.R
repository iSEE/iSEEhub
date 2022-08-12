# library(testthat); source("setup-ehub.R"); source("test-datasets_available.R")

# .datasets_available ----

test_that(".datasets_available works", {
    out <- iSEEhub:::.datasets_available(ehub)
    expect_s3_class(out, "data.frame")
    expect_identical(
        sort(colnames(out)),
        sort(c("title", "dataprovider", "species", "taxonomyid", "genome",
            "description", "coordinate_1_based", "maintainer", "rdatadateadded",
            "preparerclass", "tags", "rdataclass", "rdatapath", "sourceurl",
            "sourcetype")))
})

# .rdataclasses_available ----

test_that(".rdataclasses_available works", {
    out <- iSEEhub:::.rdataclasses_available(ehub)
    expect_vector(out, ptype = character())
})

# .dataset_factor_columns ----

test_that(".dataset_factor_columns works", {
    df <- data.frame(
        a = "a",
        b = 1,
        c = TRUE,
        d = "A",
        e = 2,
        f = FALSE
    )

    out <- iSEEhub:::.dataset_factor_columns(df, c("a", "e", "f"))
    expect_true(is.factor(out$a))
    expect_false(is.factor(out$b))
    expect_false(is.factor(out$c))
    expect_false(is.factor(out$d))
    expect_true(is.factor(out$e))
    expect_true(is.factor(out$f))
})
