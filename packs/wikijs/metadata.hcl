app {
  url = "https://js.wiki"
}

pack {
  name        = "wikijs"
  description = "Wiki.js — a modern, powerful wiki with a Markdown/WYSIWYG editor, full-text search, access control, and Git/storage sync. Deployed as an all-in-one host-networked Nomad job: a PostgreSQL sidecar plus the Wiki.js app (content is stored in Postgres, so only the database needs a volume)."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/wikijs"
  version     = "0.1.0"
}
