app {
  url = "https://garethgeorge.github.io/backrest/"
}

pack {
  name        = "backrest"
  description = "Backrest — a web UI and orchestrator for restic backups: schedule snapshots, manage repositories and retention, browse and restore files, and get notifications — all from a browser, with restic's fast, encrypted, deduplicated engine underneath. Deployed as a host-networked Nomad service with persistent data, config, and cache volumes."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/backrest"
  version     = "0.1.0"
}
