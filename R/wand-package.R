#' Retrieve 'Magic' Attributes from Files and Directories
#'
#' The 'libmagic' library provides functions to determine 'MIME' type and other
#' metadata from files through their "magic" attributes. This is useful when you
#' do not wish to rely solely on the honesty of a user or the extension on a
#' file name. It also incorporates other metadata from the mime-db database
#' <https://github.com/jshttp/mime-db>
#'
#' @section Some important details:
#'
#' The header checking is minimal (i.e. nowhere near as comprehensive as `libmagic`) but
#' covers quite a bit of ground. If there are content-check types from
#' [`magic sources`](https://github.com/threatstack/libmagic/tree/master/magic/)
#' that you would like coded into the package, please file an issue and
#' _include the full line(s)_ from that linked `magic.tab` that you would like mapped.
#'
#' @md
#' @name wand
#' @docType package
#' @author Bob Rudis (bob@@rud.is)
#' @importFrom tools file_ext
NULL
