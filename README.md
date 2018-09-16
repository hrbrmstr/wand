
[![Project Status: Active - The project has reached a stable, usable
state and is being actively
developed.](http://www.repostatus.org/badges/0.1.0/active.svg)](http://www.repostatus.org/#active)
[![Travis-CIBuild
Status](https://travis-ci.org/hrbrmstr/simplemagic.svg?branch=master)](https://travis-ci.org/hrbrmstr/simplemagic)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/hrbrmstr/simplemagic?branch=master&svg=true)](https://ci.appveyor.com/project/hrbrmstr/simplemagic)
[![Coverage
Status](https://img.shields.io/codecov/c/github/hrbrmstr/simplemagic/master.svg)](https://codecov.io/github/hrbrmstr/simplemagic?branch=master)

# wand

Lightweight File ‘MIME’ Type Detection Based On Contents or Extension

## Description

‘MIME’ types are shorthand descriptors for file contents and can be
determined from “magic” bytes in file headers, file contents or intuited
from file extensions. Tools are provided to perform curated “magic”
tests as well as mapping ‘MIME’ types from a database of over 1,500
extension mappings.

Provides a more portable/ligtweight alternative to the `wand` package.

## SOME IMPORTANT DETAILS

The header checking is minimal (i.e. nowhere near as comprehensive as
`libmagic`) but covers quite a bit of ground. If there are content-check
types from [`magic
sources`](https://github.com/threatstack/libmagic/tree/master/magic/)
that you would like coded into the package, please file an issue and
*include the full line(s)* from that linked `magic.tab` that you would
like mapped.

## What’s Inside The Tin

  - `get_content_type`: Discover MIME type of a file based on contents
  - `guess_content_type`: Guess MIME type from filename (extension)
  - `simplemagic_mime_db`: File extension-to-MIME mapping data frame

The following functions are implemented:

## Installation

``` r
devtools::install_git("https://gitlab.com/hrbrmstr/wand")
```

## Usage

``` r
library(wand)
library(tidyverse)

# current verison
packageVersion("wand")
```

    ## [1] '0.3.0'

``` r
list.files(system.file("extdat", package="wand"), full.names=TRUE) %>% 
  map_df(~{
    data_frame(
      fil = basename(.x),
      mime = list(get_content_type(.x))
    )
  }) %>% 
  unnest() %>% 
  print(n=100)
```

    ## # A tibble: 85 x 2
    ##    fil                        mime                                                                     
    ##    <chr>                      <chr>                                                                    
    ##  1 actions.csv                application/vnd.openxmlformats-officedocument.spreadsheetml.sheet        
    ##  2 actions.txt                application/vnd.openxmlformats-officedocument.spreadsheetml.sheet        
    ##  3 actions.xlsx               application/vnd.openxmlformats-officedocument.spreadsheetml.sheet        
    ##  4 test_1.2.class             application/java-vm                                                      
    ##  5 test_1.3.class             application/java-vm                                                      
    ##  6 test_1.4.class             application/java-vm                                                      
    ##  7 test_1.5.class             application/java-vm                                                      
    ##  8 test_128_44_jstereo.mp3    audio/mp3                                                                
    ##  9 test_excel_2000.xls        application/msword                                                       
    ## 10 test_excel_spreadsheet.xml application/xml                                                          
    ## 11 test_excel_web_archive.mht message/rfc822                                                           
    ## 12 test_excel.xlsm            application/zip                                                          
    ## 13 test_excel.xlsx            application/vnd.openxmlformats-officedocument.spreadsheetml.sheet        
    ## 14 test_nocompress.tif        image/tiff                                                               
    ## 15 test_powerpoint.pptm       application/zip                                                          
    ## 16 test_powerpoint.pptx       application/vnd.openxmlformats-officedocument.presentationml.presentation
    ## 17 test_word_2000.doc         application/msword                                                       
    ## 18 test_word_6.0_95.doc       application/msword                                                       
    ## 19 test_word.docm             application/zip                                                          
    ## 20 test_word.docx             application/vnd.openxmlformats-officedocument.wordprocessingml.document  
    ## 21 test.au                    audio/basic                                                              
    ## 22 test.bin                   application/mac-binary                                                   
    ## 23 test.bin                   application/macbinary                                                    
    ## 24 test.bin                   application/octet-stream                                                 
    ## 25 test.bin                   application/x-binary                                                     
    ## 26 test.bin                   application/x-macbinary                                                  
    ## 27 test.bmp                   image/bmp                                                                
    ## 28 test.dtd                   application/xml-dtd                                                      
    ## 29 test.emf                   application/x-msmetafile                                                 
    ## 30 test.eps                   application/postscript                                                   
    ## 31 test.fli                   video/flc                                                                
    ## 32 test.fli                   video/fli                                                                
    ## 33 test.fli                   video/x-fli                                                              
    ## 34 test.gif                   image/gif                                                                
    ## 35 test.ico                   image/x-icon                                                             
    ## 36 test.java                  text/plain                                                               
    ## 37 test.java                  text/x-java                                                              
    ## 38 test.java                  text/x-java-source                                                       
    ## 39 test.jpg                   image/jpeg                                                               
    ## 40 test.mp3                   audio/mp3                                                                
    ## 41 test.odt                   application/vnd.oasis.opendocument.text                                  
    ## 42 test.ogg                   application/ogg                                                          
    ## 43 test.ogg                   audio/ogg                                                                
    ## 44 test.pcx                   image/pcx                                                                
    ## 45 test.pcx                   image/x-pcx                                                              
    ## 46 test.pdf                   application/pdf                                                          
    ## 47 test.pl                    text/plain                                                               
    ## 48 test.pl                    text/x-perl                                                              
    ## 49 test.pl                    text/x-script.perl                                                       
    ## 50 test.png                   image/png                                                                
    ## 51 test.pnm                   application/x-portable-anymap                                            
    ## 52 test.pnm                   image/x-portable-anymap                                                  
    ## 53 test.ppm                   image/x-portable-pixmap                                                  
    ## 54 test.ppt                   application/msword                                                       
    ## 55 test.ps                    application/postscript                                                   
    ## 56 test.psd                   image/photoshop                                                          
    ## 57 test.py                    text/x-python                                                            
    ## 58 test.py                    text/x-script.phyton                                                     
    ## 59 test.rtf                   application/rtf                                                          
    ## 60 test.rtf                   application/x-rtf                                                        
    ## 61 test.rtf                   text/richtext                                                            
    ## 62 test.rtf                   text/rtf                                                                 
    ## 63 test.sh                    application/x-bsh                                                        
    ## 64 test.sh                    application/x-sh                                                         
    ## 65 test.sh                    application/x-shar                                                       
    ## 66 test.sh                    text/x-script.sh                                                         
    ## 67 test.sh                    text/x-sh                                                                
    ## 68 test.tar                   application/pax                                                          
    ## 69 test.tar.gz                application/octet-stream                                                 
    ## 70 test.tar.gz                application/x-compressed                                                 
    ## 71 test.tar.gz                application/x-gzip                                                       
    ## 72 test.tga                   image/x-tga                                                              
    ## 73 test.txt                   text/plain                                                               
    ## 74 test.txt.gz                application/octet-stream                                                 
    ## 75 test.txt.gz                application/x-compressed                                                 
    ## 76 test.txt.gz                application/x-gzip                                                       
    ## 77 test.wav                   audio/x-wav                                                              
    ## 78 test.wmf                   application/x-msmetafile                                                 
    ## 79 test.wmf                   windows/metafile                                                         
    ## 80 test.xcf                   application/x-xcf                                                        
    ## 81 test.xml                   application/xml                                                          
    ## 82 test.xpm                   image/x-xbitmap                                                          
    ## 83 test.xpm                   image/x-xpixmap                                                          
    ## 84 test.xpm                   image/xpm                                                                
    ## 85 test.zip                   application/zip

## Code of Conduct

Please note that this project is released with a [Contributor Code of
Conduct](CONDUCT.md). By participating in this project you agree to
abide by its terms.
