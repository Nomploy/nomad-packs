app {
  url = "https://github.com/pipozzz/starring"
}

pack {
  name        = "starring"
  description = "Starring — a self-hosted app (GitHub stars/bookmarks manager) deployed as an all-in-one Nomad job: the Starring app plus an optional bundled PostgreSQL with a persistent volume. Uses bridge networking with dynamic host ports so rolling/canary deploys work. Set better_auth_url to your real domain and a stable better_auth_secret; serves plain HTTP, front it with a reverse proxy for TLS."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/starring"
  version     = "0.1.4"
}
