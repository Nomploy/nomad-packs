app {
  url = "https://mattermost.com"
}

pack {
  name        = "mattermost"
  description = "Mattermost — a self-hosted team chat and collaboration platform (a Slack alternative) with channels, threads, file sharing, and integrations. Deployed as an all-in-one host-networked Nomad job: a PostgreSQL sidecar plus the Mattermost Team Edition server with config/data/plugins volumes."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/mattermost"
  version     = "0.1.0"
}
