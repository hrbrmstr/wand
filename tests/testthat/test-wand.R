context("basic functionality")
test_that("we can do something", {

  tmp <- incant(list.files(system.file("extdata", "img", package="wand"),
                           full.names=TRUE),
                magic_wand_file())
  tmp <- tmp$description
  tmp <- unlist(tmp, use.names=FALSE)
  tmp <- sort(tmp)

  expect_that(any(substr(tmp, 1, 3) == "PNG"), equals(TRUE))

})
