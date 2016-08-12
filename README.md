
`filemagic` : R interface to libmagic

The following functions are implemented:

-   `get_mimetype` : returns the mimetype of the files in the input vector (as a data frame)

The following data sets are included:

-   (eventually will be an internal mime types db)

### Installation

``` r
devtools::install_github("hrbrmstr/filemagic")
```

### Usage

``` r
library(filemagic)

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

    ## [1] "Fri Aug 12 18:16:56 2016"

``` r
test_dir("tests/")
```

    ## testthat results ========================================================================================================
    ## OK: 0 SKIPPED: 0 FAILED: 0
    ## 
    ## DONE ===================================================================================================================
