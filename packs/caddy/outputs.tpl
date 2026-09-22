Caddy deployed as job "[[ var "job_name" . ]]" (host-networked).

HTTP:      http://<node-ip>:[[ var "http_port" . ]]
HTTPS:     https://<node-ip>:[[ var "https_port" . ]]  (auto-TLS when a domain is used in the Caddyfile)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

The Caddyfile is rendered from the caddyfile variable into /etc/caddy/Caddyfile. To serve a real
site with automatic HTTPS, set the site address to your domain, e.g.:

  example.com {
    reverse_proxy 127.0.0.1:8096
  }

Automatic HTTPS needs the domain's DNS pointing here and ports 80/443 reachable from the internet.
ACME certificates persist on the [[ var "data_volume" . ]] volume (/data) — pin the job to that
node with the constraints variable.
