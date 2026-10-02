app {
  url = "https://documenso.com"
}

pack {
  name        = "documenso"
  description = "Documenso — the open-source DocuSign alternative for signing documents. Deployed as an all-in-one host-networked Nomad job (PostgreSQL + a self-signed signing certificate + the app). Uploads are stored in the database by default; set SMTP to send signing emails."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/documenso"
  version     = "0.1.0"
}
