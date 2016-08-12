
`filemagic` : R interface to `libmagic`

So you do need to install `libmagic` to use this. This should also be pretty straightforward to get working on Windows. Assistance to do that is welcome.

The following functions are implemented:

-   `incant` : returns the mimetype of the files in the input vector (as a data frame)

The following data sets are included:

-   (eventually will be an internal mime types db)

### Installation

``` r
devtools::install_github("hrbrmstr/filemagic")
```

### Usage

``` r
library(filemagic)
library(magrittr)
library(dplyr)

system.file("img", package="filemagic") %>% 
  list.files(full.names=TRUE) %>% 
  incant() %>% 
  glimpse()
```

    ## Observations: 10
    ## Variables: 5
    ## $ file        <chr> "/Library/Frameworks/R.framework/Versions/3.3/Resources/library/filemagic/img/example_dir", "/L...
    ## $ mime_type   <chr> "inode/directory", "text/x-c", "text/html", "text/plain", "text/rtf", "image/jpeg", "applicatio...
    ## $ encoding    <chr> "binary", "us-ascii", "us-ascii", "us-ascii", "us-ascii", "binary", "binary", "binary", "us-asc...
    ## $ extensions  <chr> NA, "???", "???", "???", "???", "jpeg/jpg/jpe/jfif", "???", "???", "???", "???"
    ## $ description <chr> "directory", "C source, ASCII text", "HTML document, ASCII text, with CRLF line terminators", "...

``` r
# current verison
packageVersion("filemagic")
```

    ## [1] '0.1.0'

### Test Results

``` r
library(filemagic)
library(testthat)

date()
```

    ## [1] "Fri Aug 12 19:47:32 2016"

``` r
test_dir("tests/")
```

    ## testthat results ========================================================================================================
    ## OK: 0 SKIPPED: 0 FAILED: 0
    ## 
    ## DONE ===================================================================================================================
