library(wand)

list(
  actions.csv = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
  actions.txt = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
  actions.xlsx = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
  test_128_44_jstereo.mp3 = "audio/mp3",
  test_excel_2000.xls = "application/msword",
  test_excel_spreadsheet.xml = "application/xml",
  test_excel_web_archive.mht = "message/rfc822",
  test_excel.xlsm = "application/zip",
  test_excel.xlsx = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
  test_nocompress.tif = "image/tiff",
  test_powerpoint.pptm = "application/zip",
  test_powerpoint.pptx = "application/vnd.openxmlformats-officedocument.presentationml.presentation",
  test_word_2000.doc = "application/msword",
  test_word_6.0_95.doc = "application/msword",
  test_word.docm = "application/zip",
  test_word.docx = "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
  test.au = "audio/basic",
  test.bin = c(
    "application/mac-binary",
    "application/macbinary", "application/octet-stream", "application/x-binary",
    "application/x-macbinary"
  ), test.bmp = "image/bmp",
  test.dtd = "application/xml-dtd",
  test.emf = "application/x-msmetafile",
  test.eps = "application/postscript",
  test.fli = c("video/flc", "video/fli", "video/x-fli"),
  test.gif = "image/gif",
  test.ico = "image/x-icon",
  test.jpg = "image/jpeg",
  test.mp3 = "audio/mp3",
  test.odt = "application/vnd.oasis.opendocument.text",
  test.ogg = c(
    "application/ogg",
    "audio/ogg"
  ), test.pcx = c("image/pcx", "image/x-pcx"),
  test.pdf = "application/pdf",
  test.pl = c("text/plain", "text/x-perl", "text/x-script.perl"),
  test.png = "image/png",
  test.pnm = c(
    "application/x-portable-anymap",
    "image/x-portable-anymap"
  ), test.ppm = "image/x-portable-pixmap",
  test.ppt = "application/msword",
  test.ps = "application/postscript",
  test.psd = "image/photoshop",
  test.py = c(
    "text/x-python",
    "text/x-script.phyton"
  ), test.rtf = c(
    "application/rtf",
    "application/x-rtf", "text/richtext", "text/rtf"
  ), test.sh = c(
    "application/x-bsh",
    "application/x-sh", "application/x-shar", "text/x-script.sh",
    "text/x-sh"
  ), test.tar = "application/tar",
  test.tar.gz = c(
    "application/octet-stream",
    "application/x-compressed", "application/x-gzip"
  ), test.tga = "image/x-tga",
  test.txt = "text/plain",
  test.txt.gz = c(
    "application/octet-stream",
    "application/x-compressed", "application/x-gzip"
  ), test.wav = "audio/x-wav",
  test.wmf = c("application/x-msmetafile", "windows/metafile"),
  test.xcf = "application/x-xcf",
  test.xml = "application/xml",
  test.xpm = c("image/x-xbitmap", "image/x-xpixmap", "image/xpm"),
  test.zip = "application/zip"
) -> results

fils <- list.files(system.file("extdat", package="wand"), full.names=TRUE)
tst <- lapply(fils, get_content_type)
names(tst) <- basename(fils)

for(n in names(tst)) expect_identical(results[[n]], tst[[n]])
