app {
  url = "https://caddyserver.com"
}

pack {
  name        = "caddy"
  description = "Caddy — a fast web server and reverse proxy with automatic HTTPS. Deployed as a host-networked Nomad service with a Caddyfile rendered from a variable and a data volume that persists ACME certificates. Edit the caddyfile variable to serve files or reverse-proxy your apps."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/caddy"
  version     = "0.1.0"
}
