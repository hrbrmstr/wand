#' Retrieve 'Magic' Attributes from Files and Directories
#'
#' The 'libmagic' library provides functions to determine 'MIME' type and other
#' metadata from files through their "magic" attributes. This is useful when you
#' do not wish to rely solely on the honesty of a user or the extension on a
#' file name. It also incorporates other metadata from the mime-db database
#' <https://github.com/jshttp/mime-db>
#'
#' Based on \code{file} / \code{libmagic} - \url{https://github.com/file/file}
#'
#' @name wand
#' @docType package
#' @author Bob Rudis (@@hrbrmstr)
#' @import purrr
#' @import tibble
#' @import tidyr
#' @import stringi
#' @importFrom rappdirs user_cache_dir
#' @useDynLib wand, .registration=TRUE
#' @importFrom Rcpp sourceCpp
#' @importFrom utils unzip
#' @importFrom dplyr mutate left_join mutate_all
#' @import stats
NULL
