app {
  url = "https://healthchecks.io"
}

pack {
  name        = "healthchecks"
  description = "Healthchecks — a self-hosted cron job and background-task monitor (a dead man's switch): your jobs ping a URL when they finish, and Healthchecks alerts you when a ping is late or missing. Deployed as a host-networked Nomad service using SQLite with a persistent data volume."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/healthchecks"
  version     = "0.1.0"
}
