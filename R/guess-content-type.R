#' Guess MIME type from filename (extension)
#'
#' Uses an internal database of over 1,500 file extension-to-MIME mappings to
#' return one or more associated types for a given input path. If no match is
#' found, `???` is returned.
#'
#' @details
#' Incorporates standard IANA MIME extension mappings and those from
#' [`servoy-client`](https://github.com/Servoy/servoy-client) and
#' [stevenwdv](https://github.com/stevenwdv)'s
#' [`allMimeTypes.json`](https://s-randomfiles.s3.amazonaws.com/mime/allMimeTypes.json).
#'
#' @md
#' @param path path to file
#' @return character vector
#' @export
#' @examples
#' guess_content_type(system.file("extdat", "test.pdf", package="simplemagic"))
guess_content_type <- function(path) {

  path <- path.expand(path)
  if (!file.exists(path)) stop("File not found.", call.=FALSE)

  extension <- trimws(tolower(tools::file_ext(path)))

  res <- simplemagic_mime_db[(simplemagic_mime_db$extension == extension),]$mime_type

  if (length(res) == 0) return("???")

  return(unique(res))

}
