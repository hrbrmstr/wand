#include <Rcpp.h>
using namespace Rcpp;

#include "magic.h"
#include "limits.h"

//' Retrieve 'magic' attributes from files and directories
//'
//' @param path character vector of files to use magic on
//' @param magic_db either "\code{system}" (the default) to use the system
//'   \code{magic} database or an atomic character vector with a
//'   colon-separated list of full paths to custom \code{magic} database(s).
//' @return a \code{tibble} / \code{data.frame} of file magic attributes.
//'   Specifically, mime type, encoding, possible file extensions and
//'   type description are returned as colums in the data frame along
//'   with \code{path}.
//' @note Various fields might not be available depending on the version
//'   of \code{libmagic} you have installed.
//' @references See \url{http://openpreservation.org/blog/2012/08/09/magic-editing-and-creation-primer/}
//'   for information on how to create your own \code{magic} database
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
DataFrame incant(CharacterVector path, std::string magic_db="system") {

  unsigned int input_size = path.size();

  StringVector mime_type(input_size);
  StringVector encoding(input_size);
  StringVector extensions(input_size);
  StringVector description(input_size);

  const char *mdb;
  std::string mdbcpp;

  int version = magic_version();

  if (magic_db == "system") {
    mdb = NULL;
  } else {
    mdbcpp = magic_db;
    mdb = mdbcpp.c_str();
  }

  for (unsigned int i=0; i<input_size; i++) {

    if ((i % 10000) == 0) Rcpp::checkUserInterrupt();

    std::string path_str = as<std::string>(path[i]);
    std::string fullPath(R_ExpandFileName(path_str.c_str()));

    int flags = MAGIC_MIME_TYPE;
    magic_t cookie = magic_open(flags);
    if (cookie == NULL) {
      mime_type[i] = NA_STRING;
    } else {
      int val = magic_load(cookie, mdb);
      if (val < 0) magic_load(cookie, NULL);
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
      int val = magic_load(cookie, mdb);
      if (val < 0) magic_load(cookie, NULL);
      const char *magic_result = magic_file(cookie, fullPath.c_str());
      if (magic_result == NULL) {
        encoding[i] = NA_STRING;
      } else {
        std::string res = std::string(magic_result, strnlen(magic_result, 1024));
        encoding(i) = res;
      }
    }

    if (version >= 528) {
      flags = MAGIC_EXTENSION;
      cookie = magic_open(flags);
      if (cookie == NULL) {
        extensions[i] = NA_STRING;
      } else {
        int val = magic_load(cookie, mdb);
        if (val < 0) magic_load(cookie, NULL);
        const char *magic_result = magic_file(cookie, fullPath.c_str());
        if (magic_result == NULL) {
          extensions[i] = NA_STRING;
        } else {
          std::string res = std::string(magic_result, strnlen(magic_result, 1024));
          extensions(i) = res;
        }
      }
    }

    flags = MAGIC_NONE;
    cookie = magic_open(flags);
    if (cookie == NULL) {
      description[i] = NA_STRING;
    } else {
      int val = magic_load(cookie, mdb);
      if (val < 0) magic_load(cookie, NULL);
      const char *magic_result = magic_file(cookie, fullPath.c_str());
      if (magic_result == NULL) {
        description[i] = NA_STRING;
      } else {
        std::string res = std::string(magic_result, strnlen(magic_result, 1024));
        description(i) = res;
      }
    }
  }

  DataFrame df;

  if (version >= 528) {
    df = DataFrame::create(_["file"]             = path,
                           _["mime_type"]        = mime_type,
                           _["encoding"]         = encoding,
                           _["extensions"]       = extensions,
                           _["description"]      = description,
                           _["stringsAsFactors"] = false);
  } else {
    df = DataFrame::create(_["file"]             = path,
                           _["mime_type"]        = mime_type,
                           _["encoding"]         = encoding,
                           _["description"]      = description,
                           _["stringsAsFactors"] = false);
  }

  df.attr("class") = CharacterVector::create("tbl_df", "tbl", "data.frame");

  return(df);

}

// [[Rcpp::export]]
int lib_version() { return(magic_version()); }
