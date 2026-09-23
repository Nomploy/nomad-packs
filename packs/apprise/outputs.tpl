Apprise deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Config:    Docker volume "[[ var "config_volume" . ]]" (/config) — saved destinations; back it up

Create a config in the web UI (or POST one) under a key, then have any app notify all its
destinations with a single request:
  curl -X POST -d '{"body":"hello"}' -H "Content-Type: application/json" \
    http://<node-ip>:[[ var "port" . ]]/notify/<your-config-key>

The API is unauthenticated — keep it on an internal network or front it with a reverse proxy.
