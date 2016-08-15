JSON_DB_URL <- "https://raw.githubusercontent.com/jshttp/mime-db/master/db.json"

mime_db <- jsonlite::fromJSON(JSON_DB_URL, flatten=TRUE)
use_data(mime_db)
