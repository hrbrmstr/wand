library(tidyverse)

a <- jsonlite::fromJSON("https://s-randomfiles.s3.amazonaws.com/mime/allMimeTypes.json")
b <- jsonlite::fromJSON("https://cdn.jsdelivr.net/gh/jshttp/mime-db@master/db.json")

aa <- map(a, compact)
aa <- keep(aa, lengths(aa)>0)

bb <- keep(b, ~"extensions" %in% names(.x))

map_df(names(aa), ~{
  tibble(
    extension = aa[[.x]],
    mime_type = .x
  ) %>% unnest()
}) -> aa_df

map_df(names(bb), ~{
  tibble(
    extension = bb[[.x]][["extensions"]],
    mime_type = .x
  ) %>% unnest()
}) -> bb_df

bind_rows(aa_df, bb_df, read_csv("tools/orig-db.csv", col_types = "cc")) %>%
  distinct() %>%
  arrange(extension, mime_type) %>%
  mutate_all(as.character) %>%
  mutate_all(trimws) -> simplemagic_mime_db

use_data(simplemagic_mime_db, internal = TRUE, overwrite = TRUE)
