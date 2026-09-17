app {
  url = "https://about.gitea.com"
}

pack {
  name        = "gitea"
  description = "Gitea — a lightweight, self-hosted Git service (repos, issues, PRs, CI actions, and a built-in container/package registry). Deployed as a host-networked Nomad service with a persistent Docker volume; uses the bundled SQLite database for a zero-dependency single-node setup."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/gitea"
  version     = "0.1.0"
}
