SearXNG deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Config:    Docker volume "[[ var "data_volume" . ]]" (/etc/searxng/settings.yml) — back it up

On first boot the image writes a default settings.yml into the volume using SEARXNG_SECRET and
SEARXNG_BASE_URL. Edit that file in the volume to enable JSON output (needed by Open WebUI / LLM
tools), tune engines, or change server.port. Serves plain HTTP — front it with a reverse proxy for
TLS. It's a metasearch front-end: no accounts, no tracking.
