#include <Rcpp.h>
using namespace Rcpp;

#include "magic.h"
#include "limits.h"

//' Return file info
//'
//' @param path character vector of files to use magic on
//' @return a \code{tibble} / \code{data.frame} of file magic attributes
//' @export
//' @examples
//' library(magrittr)
//' library(dplyr)
//'
//' system.file("img", package="filemagic") %>%
//'   list.files(full.names=TRUE) %>%
//'   incant() %>%
//'   glimpse()
// [[Rcpp::export]]
DataFrame incant(CharacterVector path) {

  unsigned int input_size = path.size();
  StringVector mime_type(input_size);
  StringVector encoding(input_size);
  StringVector extensions(input_size);
  StringVector description(input_size);

  for (unsigned int i=0; i<input_size; i++) {

    if ((i % 10000) == 0) Rcpp::checkUserInterrupt();

    std::string path_str = as<std::string>(path[i]);
    std::string fullPath(R_ExpandFileName(path_str.c_str()));

    int flags = MAGIC_MIME_TYPE;
    magic_t cookie = magic_open(flags);

    if (cookie == NULL) {
      mime_type[i] = NA_STRING;
    } else {
      magic_load(cookie, NULL);
      const char *magic_result = magic_file(cookie, fullPath.c_str());
      if (magic_result == NULL) {
        mime_type[i] = NA_STRING;
      } else {
        std::string res = std::string(magic_result, strnlen(magic_result, 1024));
        mime_type(i) = res;
      }
    }

    flags = MAGIC_MIME_ENCODING;
    cookie = magic_open(flags);
    if (cookie == NULL) {
      encoding[i] = NA_STRING;
    } else {
      magic_load(cookie, NULL);
      const char *magic_result = magic_file(cookie, fullPath.c_str());
      if (magic_result == NULL) {
        encoding[i] = NA_STRING;
      } else {
        std::string res = std::string(magic_result, strnlen(magic_result, 1024));
        encoding(i) = res;
      }
    }

    flags = MAGIC_EXTENSION;
    cookie = magic_open(flags);
    if (cookie == NULL) {
      extensions[i] = NA_STRING;
    } else {
      magic_load(cookie, NULL);
      const char *magic_result = magic_file(cookie, fullPath.c_str());
      if (magic_result == NULL) {
        extensions[i] = NA_STRING;
      } else {
        std::string res = std::string(magic_result, strnlen(magic_result, 1024));
        extensions(i) = res;
      }
    }

    flags = MAGIC_NONE;
    cookie = magic_open(flags);
    if (cookie == NULL) {
      description[i] = NA_STRING;
    } else {
      magic_load(cookie, NULL);
      const char *magic_result = magic_file(cookie, fullPath.c_str());
      if (magic_result == NULL) {
        description[i] = NA_STRING;
      } else {
        std::string res = std::string(magic_result, strnlen(magic_result, 1024));
        description(i) = res;
      }
    }
  }

  DataFrame df = DataFrame::create(_["file"] = path,
                                   _["mime_type"] = mime_type,
                                   _["encoding"] = encoding,
                                   _["extensions"] = extensions,
                                   _["description"] = description,
                                   _["stringsAsFactors"] = false);

  df.attr("class") = CharacterVector::create("tbl_df", "tbl", "data.frame");

  return(df);

}
