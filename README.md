
`wand` : Retrieve 'Magic' Attributes from Files and Directories

The `libmagic` library must be installed and available to use this. The package should also be pretty straightforward to get working on Windows. Assistance to do that is welcome.

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

    ## [1] '0.1.0'

### Test Results

``` r
library(wand)
library(testthat)

date()
```

    ## [1] "Fri Aug 12 23:58:20 2016"

``` r
test_dir("tests/")
```

    ## testthat results ========================================================================================================
    ## OK: 1 SKIPPED: 0 FAILED: 0
    ## 
    ## DONE ===================================================================================================================
