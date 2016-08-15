#' @title MIME Types Database
#' @description This is a dataset of all mime types. It aggregates data from the
#' following sources:
#'
#' \itemize{
#'   \item \url{http://www.iana.org/assignments/media-types/media-types.xhtml}
#'   \item \url{http://svn.apache.org/repos/asf/httpd/httpd/trunk/docs/conf/mime.types}
#'   \item \url{http://hg.nginx.org/nginx/raw-file/default/conf/mime.types}
#' }
#'
#' There are a total of four possible fields per element:
#'
#' \itemize{
#'   \item \code{source}: where the mime type is defined. If not set, it's
#'     probably a custom media type. One of \code{apache}, \code{iana} or \code{nginx}.
#'   \item \code{extensions}: a character vector of known extensions associated with this mime type.
#'   \item \code{compressible}: whether a file of this type can be "gzipped" (mostly
#'     useful in the context of serving up web content).
#'   \item \code{charset}: the default charset associated with this type, if any.
#' }
#'
#' @docType data
#' @keywords datasets
#' @name mime_db
#'
#' @references Ingested from \url{https://github.com/jshttp/mime-db}.
#' @usage data(mime_db)
#' @note Last updated 2016-08-14; the only guaranteed field is \code{source}
#' @format A list with 1,883 elements and four named fields: \code{source},
#'   \code{compressible}, \code{extensions} & \code{charset}.
NULL