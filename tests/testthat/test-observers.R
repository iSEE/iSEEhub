# library(testthat); source("test-observers.R")

# .create_observers ----

test_that(".create_observers works", {
    input <- new.env()
    pObjects <- new.env()
    rObjects <- new.env()

    out <- iSEEhub:::.create_observers(ehub, input, session = NULL, pObjects, rObjects)
    expect_null(out)

})

# .create_launch_observer ----

test_that(".create_launch_observer works", {
    input <- new.env()
    pObjects <- new.env()
    FUN <- function(SE, INITIAL) invisible(NULL)

    out <- iSEEhub:::.create_launch_observer(FUN, ehub, input, session = NULL, pObjects)
    expect_null(out)

})
