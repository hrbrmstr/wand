
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Signed
by](https://img.shields.io/badge/Keybase-Verified-brightgreen.svg)](https://keybase.io/hrbrmstr)
![Signed commit
%](https://img.shields.io/badge/Signed_Commits-100%25-lightgrey.svg)
[![Linux build
Status](https://travis-ci.org/hrbrmstr/wand.svg?branch=master)](https://travis-ci.org/hrbrmstr/wand)
[![builds.sr.ht
status](https://builds.sr.ht/~hrbrmstr/wand.svg)](https://builds.sr.ht/~hrbrmstr/wand?)
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
list.files(system.file("extdat", "pass-through", package="wand"), full.names=TRUE) %>% 
  map_df(~{
    tibble(
      fil = basename(.x),
      mime = list(get_content_type(.x))
    )
  }) %>% 
  unnest()
## # A tibble: 85 x 2
##    fil                        mime                                                             
##    <chr>                      <chr>                                                            
##  1 actions.csv                application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
##  2 actions.txt                application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
##  3 actions.xlsx               application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
##  4 test_128_44_jstereo.mp3    audio/mp3                                                        
##  5 test_excel_2000.xls        application/msword                                               
##  6 test_excel_spreadsheet.xml application/xml                                                  
##  7 test_excel_web_archive.mht message/rfc822                                                   
##  8 test_excel.xlsm            application/zip                                                  
##  9 test_excel.xlsx            application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
## 10 test_nocompress.tif        image/tiff                                                       
## # … with 75 more rows
```

## wand Metrics

| Lang | \# Files |  (%) | LoC |  (%) | Blank lines |  (%) | \# Lines |  (%) |
| :--- | -------: | ---: | --: | ---: | ----------: | ---: | -------: | ---: |
| R    |        7 | 0.78 | 159 | 0.62 |          62 | 0.78 |       72 | 0.71 |
| JSON |        1 | 0.11 |  80 | 0.31 |           0 | 0.00 |        0 | 0.00 |
| Rmd  |        1 | 0.11 |  17 | 0.07 |          17 | 0.22 |       29 | 0.29 |

## Code of Conduct

Please note that this project is released with a Contributor Code of
Conduct. By participating in this project you agree to abide by its
terms.
