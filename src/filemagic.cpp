#include <Rcpp.h>
using namespace Rcpp;

#include "magic.h"
#include "limits.h"

//' Return file info
//'
//' @export
// [[Rcpp::export]]
DataFrame get_mimetype(CharacterVector path) {

  unsigned int input_size = path.size();
  StringVector mime_type(input_size);

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

  }

  return DataFrame::create(_["file"] = path,
                           _["mime_type"] = mime_type,
                           _["stringsAsFactors"] = false);

}
