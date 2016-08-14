#' Retrieve 'magic' attributes from files and directories
#'
#' @param path character vector of files to use magic on
#' @param magic_db either "\code{system}" (the default) to use the system
#'   \code{magic} database or an atomic character vector with a
#'   colon-separated list of full paths to custom \code{magic} database(s).
#' @return a \code{tibble} / \code{data.frame} of file magic attributes.
#'   Specifically, mime type, encoding, possible file extensions and
#'   type description are returned as colums in the data frame along
#'   with \code{path}.
#' @note Various fields might not be available depending on the version
#'   of \code{libmagic} you have installed.
#' @references See \url{http://openpreservation.org/blog/2012/08/09/magic-editing-and-creation-primer/}
#'   for information on how to create your own \code{magic} database
#' @export
#' @examples
#' library(magrittr)
#' library(dplyr)
#'
#' system.file("img", package="filemagic") %>%
#'   list.files(full.names=TRUE) %>%
#'   incant() %>%
#'   glimpse()
incant <- function(path, magic_db="system") {

  if (get_os() == "win") {

    file_exe <- system.file("exec/file.exe", package="wand")

    magic_db <- normalizePath(magic_wand_file())

    tf <- tempfile()
    writeLines(path, tf)

    system2(file_exe,
            c("--mime-type", "--mime-encoding", "--no-buffer", "--preserve-date",
              '--separator "||"', sprintf('--magic-file "%s"', magic_db),
              sprintf('--files-from "%s"', tf)),
            stdout=TRUE) -> output_1

    system2(file_exe,
            c("--no-buffer", "--preserve-date", '--separator "||"',
              sprintf('--magic-file "%s"', magic_db),
              sprintf('--files-from "%s"', tf)),
            stdout=TRUE) -> output_2

    unlink(tf)

    stri_split_fixed(output_1, "||", n=2, simplify=TRUE) %>%
      as_data_frame() %>%
      setNames(c("file", "response")) %>%
      separate(response, c("mime_type", "encoding"), sep=";", extra="drop", fill="right") %>%
      mutate(encoding=stri_replace_first_regex(encoding, "charset=", "")) -> df1

    stri_split_fixed(output_2, "||", n=2, simplify=TRUE) %>%
      as_data_frame() %>%
      setNames(c("file", "description")) -> df2

    left_join(df1, df2, by="file")

  } else {
    incant_(path, magic_db)
  }
}

get_os <- function () {
  if (.Platform$OS.type == "windows") {
    "win"
  } else if (Sys.info()["sysname"] == "Darwin") {
    "mac"
  } else if (.Platform$OS.type == "unix") {
    "unix"
  } else {
    stop("Unknown OS")
  }
}