app {
  url = "https://docs.linuxserver.io/images/docker-webtop/"
}

pack {
  name        = "webtop"
  description = "Webtop — a full Linux desktop environment (XFCE, KDE, and more) that runs in a container and streams to your browser. Handy for a disposable, always-available workstation or a jump box. Deployed as a host-networked Nomad service with a persistent home volume."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/webtop"
  version     = "0.1.0"
}
