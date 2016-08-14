
[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/0.1.0/active.svg)](http://www.repostatus.org/#active) [![Travis-CI Build Status](https://travis-ci.org/hrbrmstr/wand.svg?branch=master)](https://travis-ci.org/hrbrmstr/wand)

`wand` : Retrieve 'Magic' Attributes from Files and Directories

The `libmagic` library must be installed on \*nix/macOS and available to use this.

-   `apt-get install libmagic-dev` on Debian-ish systems
-   `brew install libmagic` on macOS

While the package was developed using the 5.28 version of `libmagic` it has been configured to work with older versions. Note that some fields in the resultant data frame might not be available with older library versions. When using the function `magic_wand_file()` it checks for which version of `libmagic` is installed on your system and provides a suitable `magic.mgc` file for it.

The package also works on Windows but it's a bit of a hack because, well, *Windows*. Seriously, folks, use a real operating system. The Windows version makes two `system2()` calls, so it's sub-optimal at best. Help to get it working in C would be greatly appreciated.

The following functions are implemented:

-   `incant` : returns the "magic" metadata of the files in the input vector (as a data frame)
-   `magic_wand_file` : provides a full path to the package-provided `magic` file

### Installation

``` r
devtools::install_github("hrbrmstr/wand")
```

### Usage

``` r
library(wand)
library(magrittr)
library(dplyr)

system.file("img", package="wand") %>% 
  list.files(full.names=TRUE) %>% 
  incant() %>% 
  glimpse()
```

    ## Observations: 10
    ## Variables: 5
    ## $ file        <chr> "/Library/Frameworks/R.framework/Versions/3.3/Resources/library/wand/img/example_dir", "/Librar...
    ## $ mime_type   <chr> "inode/directory", "text/x-c", "text/html", "text/plain", "text/rtf", "image/jpeg", "applicatio...
    ## $ encoding    <chr> "binary", "us-ascii", "us-ascii", "us-ascii", "us-ascii", "binary", "binary", "binary", "us-asc...
    ## $ extensions  <chr> NA, "???", "???", "???", "???", "jpeg/jpg/jpe/jfif", "???", "???", "???", "???"
    ## $ description <chr> "directory", "C source, ASCII text", "HTML document, ASCII text, with CRLF line terminators", "...

``` r
system.file("img", package="wand") %>% 
  list.files(full.names=TRUE) %>% 
  incant(magic_wand_file()) %>% 
  select(description) %>% 
  unlist(use.names=FALSE)
```

    ##  [1] "directory"                                                                                                                                                                                                        
    ##  [2] "C source, ASCII text"                                                                                                                                                                                             
    ##  [3] "HTML document, ASCII text, with CRLF line terminators"                                                                                                                                                            
    ##  [4] "ASCII text, with no line terminators"                                                                                                                                                                             
    ##  [5] "Rich Text Format data, version 1, ANSI"                                                                                                                                                                           
    ##  [6] "JPEG image data, JFIF standard 1.01, aspect ratio, density 72x72, segment length 16, Exif Standard: [TIFF image data, big-endian, direntries=2, orientation=upper-left], baseline, precision 8, 800x700, frames 3"
    ##  [7] "PDF document, version 1.3"                                                                                                                                                                                        
    ##  [8] "PNG image data, 800 x 700, 8-bit/color RGBA, non-interlaced"                                                                                                                                                      
    ##  [9] "ASCII text, with very long lines, with CRLF line terminators"                                                                                                                                                     
    ## [10] "TIFF image data, big-endian"

``` r
# current verison
packageVersion("wand")
```

    ## [1] '0.2.0'

### Test Results

``` r
library(wand)
library(testthat)

date()
```

    ## [1] "Sun Aug 14 18:36:44 2016"

``` r
test_dir("tests/")
```

    ## testthat results ========================================================================================================
    ## OK: 1 SKIPPED: 0 FAILED: 0
    ## 
    ## DONE ===================================================================================================================
