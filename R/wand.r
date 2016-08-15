#' Retrieve 'magic' attributes from files and directories
#'
#' @param path character vector of files to use magic on
#' @param magic_db either "\code{system}" (the default) to use the system
#'   \code{magic} database or an atomic character vector with a
#'   colon-separated list of full paths to custom \code{magic} database(s). This parameter
#'   is (for the moment) ignored on Windows.
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
#' library(dplyr)
#'
#' system.file("extdata/img", package="filemagic") %>%
#'   list.files(full.names=TRUE) %>%
#'   incant() %>%
#'   glimpse()
incant <- function(path, magic_db="system") {

  if (get_os() == "win") {

    found_file <- FALSE

    file_exe <- Sys.which("file.exe")
    found_file <- file_exe != ""

    if (found_file) {
      file_version <- suppressWarnings(system2(file_exe, "--version", stdout=TRUE, stderr=TRUE))
      found_file <-  any(grepl("magic file", file_version))
    }

    if (!found_file) {
      stop(paste0("'file.exe' not found. Please install 'Rtools' and restart R. ",
                  "See 'https://github.com/stan-dev/rstan/wiki/Install-Rtools-for-Windows' ",
                  "for more information on how to install 'Rtools'", collapse=""),
           call.=FALSE)
    }

    magic_db <- normalizePath(magic_wand_file())

    tf <- tempfile()
    writeLines(path, tf)

    suppressMessages(
      suppressWarnings(
        system2(file_exe,
                c("--mime-type", "--mime-encoding", "--no-buffer", "--preserve-date",
                  '--separator "||"',
                  sprintf('--files-from "%s"', tf)),
                stdout=TRUE))) -> output_1

    suppressMessages(
      suppressWarnings(system2(file_exe,
                               c("--no-buffer", "--preserve-date", '--separator "||"',
                                 sprintf('--files-from "%s"', tf)),
                               stdout=TRUE))) -> output_2

    unlink(tf)

    stri_split_fixed(output_1, "||", n=2, simplify=TRUE) %>%
      as_data_frame() %>%
      setNames(c("file", "response")) %>%
      separate(response, c("mime_type", "encoding"), sep=";", extra="drop", fill="right") %>%
      mutate(encoding=stri_replace_first_regex(encoding, "charset=", "")) -> df1

    stri_split_fixed(output_2, "||", n=2, simplify=TRUE) %>%
      as_data_frame() %>%
      setNames(c("file", "description")) -> df2

    left_join(df1, df2, by="file") %>%
      mutate_all(stri_trim_both) -> ret

  } else {
    ret <- incant_(path, magic_db)
  }

  if (!("extensions" %in% colnames(ret))) ret$extensions <- NA

  mutate(ret, extensions=ifelse(extensions=="???", NA, extensions)) %>%
    mutate(extensions=map_exts(mime_type, extensions))

}

map_exts <- function(mime_type, current_extensions) {

  exts <- stri_split_regex(current_extensions, "/")

  map2(mime_type, exts, function(mt, xt) {

    ret <- wand::mime_db[[mt]]$extensions %||% NA
    ret <- sort(unique(c(xt, ret)))
    ret <- ret[!is.na(ret)]
    if (length(ret)==0) ret <- NA
    ret

  })

}


#' ripped from rappdirs (ty Hadley!)
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