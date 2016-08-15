#include <Rcpp.h>

using namespace Rcpp;

#ifdef _WIN32
#define WINDOWS
#endif

#ifdef _WIN64
#define WINDOWS
#endif

#ifndef WINDOWS
#include "magic.h"
#endif

#ifndef WINDOWS
// [[Rcpp::export]]
DataFrame incant_(CharacterVector path, std::string magic_db="system") {

  unsigned int input_size = path.size();

  StringVector mime_type(input_size);
  StringVector encoding(input_size);
  StringVector extensions(input_size);
  StringVector description(input_size);

  const char *mdb;
  std::string mdbcpp;

#ifndef MAGIC_VERSION
  int version = 500;
#else
  int version = magic_version();
#endif

  if (magic_db == "system") {
    mdb = NULL;
  } else {
    mdbcpp = magic_db;
    mdb = mdbcpp.c_str();
  }

  // This is "ugh" due to the fact that various versions of the libmagic
  // library can't handle loading multiple "cookies" at the same time.
  // So, we end up doing way too much extra work to get the individual
  // bits of info. I may just switch this over to a single call (all the
  // availabel flags) and do string parsing before pushing to CRAN.

  int flags = MAGIC_MIME_TYPE;
  magic_t cookie = magic_open(flags);

  for (unsigned int i=0; i<input_size; i++) {

    if ((i % 10000) == 0) Rcpp::checkUserInterrupt();

    std::string path_str = as<std::string>(path[i]);
    std::string fullPath(R_ExpandFileName(path_str.c_str()));

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

  }

  flags = MAGIC_MIME_ENCODING;
  cookie = magic_open(flags);

  for (unsigned int i=0; i<input_size; i++) {

    if ((i % 10000) == 0) Rcpp::checkUserInterrupt();

    std::string path_str = as<std::string>(path[i]);
    std::string fullPath(R_ExpandFileName(path_str.c_str()));

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

  }

  if (version >= 528) {

    for (unsigned int i=0; i<input_size; i++) {

      if ((i % 10000) == 0) Rcpp::checkUserInterrupt();

      std::string path_str = as<std::string>(path[i]);
      std::string fullPath(R_ExpandFileName(path_str.c_str()));

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

  }

  flags = MAGIC_NONE;
  cookie = magic_open(flags);
  for (unsigned int i=0; i<input_size; i++) {

    if ((i % 10000) == 0) Rcpp::checkUserInterrupt();

    std::string path_str = as<std::string>(path[i]);
    std::string fullPath(R_ExpandFileName(path_str.c_str()));

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
#else
DataFrame incant_(CharacterVector path, std::string magic_db="system") {
  return(DataFrame::create());
}
#endif

// [[Rcpp::export]]
int lib_version() {
#ifndef MAGIC_VERSION
  return(500);
#else
  return(magic_version());
#endif
}
