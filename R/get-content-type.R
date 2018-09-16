#' Discover MIME type of a file based on contents
#'
#' There are a limited number of header "magic" bytes checked directly by
#' this function but cover quite a bit of ground. After that, [guess_content_type()] is called which uses
#' file extension-to-MIME mappings. File an issue or PR if more magic-byte-level
#' comparisons are required/desired. If no match is found, `???` is returned.
#'
#' @details
#' Initial in-R header mapping logic borrowed from `MimeTypes.java` from
#' [`servoy-client`](https://github.com/Servoy/servoy-client)
#'
#' @md
#' @param path path to a file
#' @return character vector
#' @export
#' @examples
#' get_content_type(system.file("extdat", "test.pdf", package="simplemagic"))
get_content_type <- function(path) {

  path <- path.expand(path)
  if (!file.exists(path)) stop("File not found.", call.=FALSE)

  hdr <- readBin(path, "raw", n=1024)

  if (all(c(0xCA,0xFE,0xBA,0xBE) == hdr[1:4])) return("application/java-vm")

  if (all(c(0xD0,0xCF,0x11,0xE0,0xA1,0xB1,0x1A,0xE1) == hdr[1:8])) {
    guessed_name <- guess_content_type(path)
    if ((length(guessed_name) == 1) && (guessed_name != "???")) return(guessed_name)
    return("application/msword")
  }

  if (all(c(0x25,0x50,0x44,0x46,0x2d,0x31,0x2e) == hdr[1:7])) return("application/pdf")
  if (all(c(0x25,0x50,0x44,0x46) == hdr[1:4])) return("application/x-pdf")

  if (all(c(0x38,0x42,0x50,0x53,0x00,0x01) == hdr[1:6])) return("image/photoshop")

  if (all(c(0x25,0x21,0x50,0x53) == hdr[1:4])) return("application/postscript")

  if (all(c(0xff,0xfb,0x30) == hdr[1:3])) return("audio/mp3")
  if (all(c(0xff,0xfb,0xd0) == hdr[1:3])) return("audio/mp3")
  if (all(c(0xff,0xfb,0x90) == hdr[1:3])) return("audio/mp3")
  if (all(c(0x49,0x44,0x33) == hdr[1:3])) return("audio/mp3")
  if (all(c(0xAC,0xED) == hdr[1:2])) return("application/x-java-serialized-object")

  if (hdr[1] == 0x3c) { # "<"
    if (all(c(0x68,0x74,0x6d,0x6c) == hdr[2:5])) return("text/html") # "html"
    if (all(c(0x48,0x54,0x4d,0x4c) == hdr[2:5])) return("text/html") # "HTML"
    if (all(c(0x48,0x45,0x41,0x44) == hdr[2:5])) return("text/html") # "HEAD"
    if (all(c(0x68,0x65,0x61,0x64) == hdr[2:5])) return("text/html") # "head"
    if (all(c(0x3f,0x78,0x6d,0x6c,0x20) == hdr[2:6])) return("application/xml")
  }

  if (all(c(0xfe,0xff) == hdr[1:2])) {
    if (all(c(0x00,0x3c,0x00,0x3f,0x00,0x78) == hdr[3:8])) return("application/xml")
  }

  if (all(c(0x42,0x4d) == hdr[1:2])) return("image/bmp")
  if (all(c(0x49,0x49,0x2a,0x00) == hdr[1:4])) return("image/tiff")
  if (all(c(0x4D,0x4D,0x00,0x2a) == hdr[1:4])) return("image/tiff")
  if (all(c(0x47,0x49,0x46,0x38) == hdr[1:4])) return("image/gif")
  if (all(c(0x23,0x64,0x65,0x66) == hdr[1:4])) return("image/x-bitmap")
  if (all(c(0x21,0x20,0x58,0x50,0x4d,0x32) == hdr[1:6])) return("image/x-pixmap")
  if (all(c(137,80,78,71,13,10,26,10) == hdr[1:8])) return("image/png")

  if (all(c(0x23,0x21,0x2f,0x62,0x69,0x6e,0x2f,0x6e,0x6f,0x64,0x65) == hdr[1:11]))
    return("application/javascript")
  if (all(c(0x23,0x21,0x2f,0x62,0x69,0x6e,0x2f,0x6e,0x6f,0x64,0x65,0x6a,0x73) == hdr[1:13]))
    return("application/javascript")
  if (all(c(0x23,0x21,0x2f,0x75,0x73,0x72,0x2f,0x62,0x69,0x6e,0x2f,0x6e,0x6f,0x64,0x65) == hdr[1:15]))
    return("application/javascript")
  if (all(c(0x23,0x21,0x2f,0x75,0x73,0x72,0x2f,0x62,0x69,0x6e,0x2f,0x6e,0x6f,0x64,0x65,0x6a,0x73) == hdr[1:17]))
    return("application/javascript")
  if (all(c(0x23,0x21,0x2f,0x75,0x73,0x72,0x2f,0x62,0x69,0x6e,0x2f,0x65,0x6e,0x76,0x20,0x6e,0x6f,0x64,0x65) == hdr[1:19]))
    return("application/javascript")
  if (all(c(0x23,0x21,0x2f,0x75,0x73,0x72,0x2f,0x62,0x69,0x6e,0x2f,0x65,0x6e,0x76,0x20,0x6e,0x6f,0x64,0x65,0x6a,0x73) == hdr[1:21]))
    return("application/javascript")

  if (all(c(0xFF,0xD8,0xFF) == hdr[1:3])) {
    if (0xE0 == hdr[4]) return("image/jpeg")
    if (0xE1 == hdr[4]) {
      if (all(c(0x45,0x78,0x69,0x66,0x00) == hdr[7:11])) return("image/jpeg") # Exif
    }
    if (0xEE == hdr[4]) return("image/jpg")
  }

  if (all(c(0x41,0x43) == hdr[1:2]) && all(c(0x00,0x00,0x00,0x00,0x00) == hdr[7:11]))
    return("application/acad")

  if (all(c(0x2E,0x73,0x6E,0x64) == hdr[1:4])) return("audio/basic")
  if (all(c(0x64,0x6E,0x73,0x2E) == hdr[1:4])) return("audio/basic")
  if (all(c(0x52,0x49,0x46,0x46) == hdr[1:4])) return("audio/x-wav") # "RIFF"

  if (all(c(0x50, 0x4b) == hdr[1:2])) { # "PK"

    office_type <- check_office(hdr, path)
    if (length(office_type) > 0) return(office_type)

    guessed_name <- guess_content_type(path)
    if ((length(guessed_name) == 1) && (guessed_name != "???")) return(guessed_name)

    return("application/zip")

  }

  if (all(c(0x5a,0x4d) == hdr[1:2])) return("x-system/exe")

  if (all(c(0x75,0x73,0x74,0x61,0x72) == hdr[258:262])) return("application/pax")

  if (all(c(0x00,0x00,0x01,0xBA) == hdr[1:4])) return("video/mpeg")
  if (all(c(0x00,0x00,0x01,0xB3) == hdr[1:4])) return("video/mpeg")


  return(guess_content_type(path))

}
