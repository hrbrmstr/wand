#' Use the "magic" file that comes with the package
#'
#' The \code{magic_load()} functon from \code{libmagic} can't take ZIP files
#' and the \code{magic.mgc} file that ships with the package is too large to
#' be shipped uncompressed. Using this function as the \code{magic_db}
#' parameter will copy and uncompress the database to a cache directory and
#' return the full path to the magic file. Subsequent calls will not have to
#' perform the decompression unless \code{force} is \code{TRUE} or the
#' cache directory has been cleared.
#'
#' @param force ensure the lastest copy of the pacakge "magic"
#'   database is used.
#' @export
#' @examples
# ' library(magrittr)
# ' library(dplyr)
#'
#' system.file("img", package="filemagic") %>%
#'   list.files(full.names=TRUE) %>%
#'   incant(magic_wand_file()) %>%
#'   glimpse()
magic_wand_file <- function(force=FALSE) {

  cache <- rappdirs::user_cache_dir("wandr")

  if (!dir.exists(cache)) dir.create(cache, showWarnings=FALSE)
  if (!dir.exists(cache)) return("system")

  if (lib_version() >= 528) vers <- "new" else vers <- "old"

  if (!file.exists(file.path(rappdirs::user_cache_dir("wandr"), "magic.mgc"))) {
    suppressWarnings(unzip(system.file("db", vers, "magic.mgc.zip", package="wand"),
                           exdir=cache, overwrite=force))
  }

  file.path(rappdirs::user_cache_dir("wandr"), "magic.mgc")

}