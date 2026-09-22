Headscale deployed as job "[[ var "job_name" . ]]" (host-networked).

Control:   [[ if ne (var "server_url" .) "" ]][[ var "server_url" . ]][[ else ]]http://<node-ip>:[[ var "port" . ]] (set server_url!)[[ end ]]
Metrics:   http://<node-ip>:[[ var "metrics_port" . ]]/metrics
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

IMPORTANT: set the server_url variable to a URL your devices can actually reach (e.g.
http://<node-ip>:[[ var "port" . ]] or a TLS domain) — clients register against it.

Create a user and enrol a device:
  nomad alloc exec -task headscale <alloc> headscale users create myuser
  # on the device:
  tailscale up --login-server=<server_url> --accept-routes
  # then approve the node key printed by the client:
  nomad alloc exec -task headscale <alloc> headscale nodes register --user myuser --key <nodekey>

DB and keys live on the [[ var "data_volume" . ]] volume (/var/lib/headscale). This image is
pinned because the config schema is version-specific — review the config if you change the tag.
