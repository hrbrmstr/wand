check_office <- function(hdr, path) {

  # [Content_Types.xml] || length 19
  c(
    0x5b,0x43,0x6f,0x6e,0x74,0x65,0x6e,0x74,0x5f,0x54,
    0x79,0x70,0x65,0x73,0x5d,0x2e,0x78,0x6d,0x6c
  ) -> pat_content_types

  # _rels/.rels || length 11
  pat_rels <- c(0x5f,0x72,0x65,0x6c,0x73,0x2f,0x2e,0x72,0x65,0x6c,0x73)

  if ((all(pat_content_types == hdr[31:49])) || (all(pat_rels == hdr[31:41]))) {

    hdr <- readBin(path, "raw", n=4096)

    pat_word <- c(0x77,0x6f,0x72,0x64,0x2f)
    if (length(seq_in(hdr, pat_word)) > 0)
      return("application/vnd.openxmlformats-officedocument.wordprocessingml.document")

    pat_ppt <- c(0x70,0x70,0x74,0x2f)
    if (length(seq_in(hdr, pat_ppt)) > 0)
      return("application/vnd.openxmlformats-officedocument.presentationml.presentation")

    pat_xl <- c(0x78,0x6c,0x2f)
    if (length(seq_in(hdr, pat_xl)) > 0)
      return("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")

  }

  return(NULL)

}
