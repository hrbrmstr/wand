
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Signed
by](https://img.shields.io/badge/Keybase-Verified-brightgreen.svg)](https://keybase.io/hrbrmstr)
![Signed commit
%](https://img.shields.io/badge/Signed_Commits-100%25-lightgrey.svg)
[![Linux build
Status](https://travis-ci.org/hrbrmstr/wand.svg?branch=master)](https://travis-ci.org/hrbrmstr/wand)
[![Windows build
status](https://ci.appveyor.com/api/projects/status/github/hrbrmstr/wand?svg=true)](https://ci.appveyor.com/project/hrbrmstr/wand)
[![Coverage
Status](https://codecov.io/gh/hrbrmstr/wand/branch/master/graph/badge.svg)](https://codecov.io/gh/hrbrmstr/wand)
[![cran
checks](https://cranchecks.info/badges/worst/wand)](https://cranchecks.info/pkgs/wand)
[![CRAN
status](https://www.r-pkg.org/badges/version/wand)](https://www.r-pkg.org/pkg/wand)
![Minimal R
Version](https://img.shields.io/badge/R%3E%3D-3.2.0-blue.svg)
![License](https://img.shields.io/badge/License-MIT-blue.svg)

# wand

Retrieve Magic Attributes from Files and Directories

## Description

MIME types are shorthand descriptors for file contents and can be
determined from “magic” bytes in file headers, file contents or intuited
from file extensions. Tools are provided to perform curated “magic”
tests as well as mapping MIME types from a database of over 1,800
extension mappings.

## SOME IMPORTANT DETAILS

The header checking is minimal (i.e. nowhere near as comprehensive as
`libmagic`) but covers quite a bit of ground. If there are content-check
types from [`magic
sources`](https://github.com/threatstack/libmagic/tree/master/magic/)
that you would like coded into the package, please file an issue and
*include the full line(s)* from that linked `magic.tab` that you would
like mapped.

## What’s Inside The Tin

The following functions are implemented:

  - `get_content_type`: Discover MIME type of a file based on contents
  - `guess_content_type`: Guess MIME type from filename (extension)
  - `simplemagic_mime_db`: File extension-to-MIME mapping data frame

## Installation

``` r
install.packages("wand", repos = "https://cinc.rud.is")
# or
remotes::install_git("https://git.rud.is/hrbrmstr/wand.git")
# or
remotes::install_git("https://git.sr.ht/~hrbrmstr/wand")
# or
remotes::install_gitlab("hrbrmstr/wand")
# or
remotes::install_bitbucket("hrbrmstr/wand")
# or
remotes::install_github("hrbrmstr/wand")
```

NOTE: To use the ‘remotes’ install options you will need to have the
[{remotes} package](https://github.com/r-lib/remotes) installed.

## Usage

``` r
library(wand)
library(tidyverse)

# current verison
packageVersion("wand")
## [1] '0.6.0'
```

``` r
list.files(system.file("extdat", package="wand"), full.names=TRUE) %>% 
  map_df(~{
    tibble(
      fil = basename(.x),
      mime = list(get_content_type(.x))
    )
  }) %>% 
  unnest()
```

<div class="kable-table">

| fil                           | mime                                                                      |
| :---------------------------- | :------------------------------------------------------------------------ |
| actions.csv                   | application/vnd.openxmlformats-officedocument.spreadsheetml.sheet         |
| actions.txt                   | application/vnd.openxmlformats-officedocument.spreadsheetml.sheet         |
| actions.xlsx                  | application/vnd.openxmlformats-officedocument.spreadsheetml.sheet         |
| test\_128\_44\_jstereo.mp3    | audio/mp3                                                                 |
| test\_excel\_2000.xls         | application/msword                                                        |
| test\_excel\_spreadsheet.xml  | application/xml                                                           |
| test\_excel\_web\_archive.mht | message/rfc822                                                            |
| test\_excel.xlsm              | application/zip                                                           |
| test\_excel.xlsx              | application/vnd.openxmlformats-officedocument.spreadsheetml.sheet         |
| test\_nocompress.tif          | image/tiff                                                                |
| test\_powerpoint.pptm         | application/zip                                                           |
| test\_powerpoint.pptx         | application/vnd.openxmlformats-officedocument.presentationml.presentation |
| test\_word\_2000.doc          | application/msword                                                        |
| test\_word\_6.0\_95.doc       | application/msword                                                        |
| test\_word.docm               | application/zip                                                           |
| test\_word.docx               | application/vnd.openxmlformats-officedocument.wordprocessingml.document   |
| test.au                       | audio/basic                                                               |
| test.bin                      | application/mac-binary                                                    |
| test.bin                      | application/macbinary                                                     |
| test.bin                      | application/octet-stream                                                  |
| test.bin                      | application/x-binary                                                      |
| test.bin                      | application/x-macbinary                                                   |
| test.bmp                      | image/bmp                                                                 |
| test.dtd                      | application/xml-dtd                                                       |
| test.emf                      | application/x-msmetafile                                                  |
| test.emf                      | image/emf                                                                 |
| test.eps                      | application/postscript                                                    |
| test.fli                      | video/flc                                                                 |
| test.fli                      | video/fli                                                                 |
| test.fli                      | video/x-fli                                                               |
| test.gif                      | image/gif                                                                 |
| test.ico                      | image/vnd.microsoft.icon                                                  |
| test.ico                      | image/x-icon                                                              |
| test.jpg                      | image/jpeg                                                                |
| test.mp3                      | audio/mp3                                                                 |
| test.odt                      | application/vnd.oasis.opendocument.text                                   |
| test.ogg                      | application/ogg                                                           |
| test.ogg                      | audio/ogg                                                                 |
| test.pcx                      | image/pcx                                                                 |
| test.pcx                      | image/vnd.zbrush.pcx                                                      |
| test.pcx                      | image/x-pcx                                                               |
| test.pdf                      | application/pdf                                                           |
| test.pl                       | application/x-perl                                                        |
| test.pl                       | text/plain                                                                |
| test.pl                       | text/x-perl                                                               |
| test.pl                       | text/x-script.perl                                                        |
| test.png                      | image/png                                                                 |
| test.pnm                      | application/x-portable-anymap                                             |
| test.pnm                      | image/x-portable-anymap                                                   |
| test.ppm                      | image/x-portable-pixmap                                                   |
| test.ppt                      | application/msword                                                        |
| test.ps                       | application/postscript                                                    |
| test.psd                      | image/photoshop                                                           |
| test.py                       | text/x-python                                                             |
| test.py                       | text/x-script.phyton                                                      |
| test.rtf                      | application/rtf                                                           |
| test.rtf                      | application/x-rtf                                                         |
| test.rtf                      | text/richtext                                                             |
| test.rtf                      | text/rtf                                                                  |
| test.sh                       | application/x-bsh                                                         |
| test.sh                       | application/x-sh                                                          |
| test.sh                       | application/x-shar                                                        |
| test.sh                       | text/x-script.sh                                                          |
| test.sh                       | text/x-sh                                                                 |
| test.tar                      | application/tar                                                           |
| test.tar.gz                   | application/gzip                                                          |
| test.tar.gz                   | application/octet-stream                                                  |
| test.tar.gz                   | application/x-compressed                                                  |
| test.tar.gz                   | application/x-gzip                                                        |
| test.tga                      | image/x-tga                                                               |
| test.txt                      | text/plain                                                                |
| test.txt.gz                   | application/gzip                                                          |
| test.txt.gz                   | application/octet-stream                                                  |
| test.txt.gz                   | application/x-compressed                                                  |
| test.txt.gz                   | application/x-gzip                                                        |
| test.wav                      | audio/x-wav                                                               |
| test.wmf                      | application/x-msmetafile                                                  |
| test.wmf                      | image/wmf                                                                 |
| test.wmf                      | windows/metafile                                                          |
| test.xcf                      | application/x-xcf                                                         |
| test.xml                      | application/xml                                                           |
| test.xpm                      | image/x-xbitmap                                                           |
| test.xpm                      | image/x-xpixmap                                                           |
| test.xpm                      | image/xpm                                                                 |
| test.zip                      | application/zip                                                           |

</div>

## wand Metrics

| Lang | \# Files |  (%) | LoC |  (%) | Blank lines |  (%) | \# Lines |  (%) |
| :--- | -------: | ---: | --: | ---: | ----------: | ---: | -------: | ---: |
| R    |        7 | 0.78 | 154 | 0.61 |          59 | 0.78 |       70 | 0.69 |
| JSON |        1 | 0.11 |  80 | 0.32 |           0 | 0.00 |        0 | 0.00 |
| Rmd  |        1 | 0.11 |  17 | 0.07 |          17 | 0.22 |       31 | 0.31 |

## Code of Conduct

Please note that this project is released with a Contributor Code of
Conduct. By participating in this project you agree to abide by its
terms.
