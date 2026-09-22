app {
  url = "https://beszel.dev"
}

pack {
  name        = "beszel"
  description = "Beszel — a lightweight server monitoring hub with historical CPU/memory/disk/network stats, Docker container stats, and configurable alerts. Deployed as the host (web UI + database); add the beszel-agent on each machine you want to monitor. A simpler alternative to the monitoring pack."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/beszel"
  version     = "0.1.0"
}
