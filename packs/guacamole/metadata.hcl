app {
  url = "https://guacamole.apache.org/"
}

pack {
  name        = "guacamole"
  description = "Apache Guacamole — a clientless remote-desktop gateway: access RDP, VNC and SSH machines from your browser. This all-in-one image bundles guacd and PostgreSQL. Deployed as a single host-networked Nomad service."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/guacamole"
  version     = "0.1.0"
}
