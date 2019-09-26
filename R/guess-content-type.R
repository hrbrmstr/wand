#' Guess MIME type from filename (extension)
#'
#' Uses an internal database of over 1,800 file extension-to-MIME mappings to
#' return one or more associated types for a given input path. If no match is
#' found, `???` is returned.
#'
#' @md
#' @param path path to file
#' @param not_found MIME type to use when the content cannot be guessed by
#'        file type.
#' @param custom_db a single data frames each with two columns:
#'        `mime_type` and `extension`. These sources will be used along with
#'        the built-in sources and will take priority over the built-in sources.
#'        Note that the `extension`s should be lower case as they are in the
#'        official MIME database.
#' @return character vector
#' @export
#' @examples
#' guess_content_type(system.file("extdat", "pass-through", "test.pdf", package="wand"))
guess_content_type <- function(path, not_found = "???", custom_db = NULL) {

  path <- path.expand(path[1])
  if (!file.exists(path)) stop("File not found.", call.=FALSE)

  if (is.null(custom_db)) {
    db <- simplemagic_mime_db
  } else {

    if (inherits(custom_db, "data.frame")) {

      if (!all(c("mime_type", "extension") %in% colnames(custom_db))) {
        stop(
          "'custom_db' must have both 'mime_type' and 'extension' columns.",
          call.=FALSE
        )
      }

      rbind.data.frame(
        custom_db[, c("mime_type", "extension")],
        simplemagic_mime_db
      ) -> db

      db[["mime_type"]] <- as.character(db[["mime_type"]])
      db[["extension"]] <- as.character(db[["extension"]])

    } else {
      stop("'custom_db' must be data frame.", call.=FALSE)
    }

  }

  extension <- trimws(tolower(tools::file_ext(path)))

  res <- db[(db$extension == extension),]$mime_type

  if (length(res) == 0) return(not_found)

  return(unique(res))

}
