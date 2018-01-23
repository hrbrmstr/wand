context("wand can correctly test files")
test_that("a sample image file is identified correctly", {

  tmp <- incant(list.files(system.file("extdata", "img", package="wand"),
                           full.names=TRUE),
                magic_wand_file())
  tmp <- tmp$description
  tmp <- unlist(tmp, use.names=FALSE)
  tmp <- sort(tmp)

  expect_that(any(substr(tmp, 1, 3) == "PNG"), equals(TRUE))

})
