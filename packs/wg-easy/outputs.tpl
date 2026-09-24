wg-easy deployed as job "[[ var "job_name" . ]]" (host-networked).

Web UI:    http://<node-ip>:[[ var "web_port" . ]]  (log in with your PASSWORD)
WireGuard: [[ var "wg_host" . ]]:[[ var "wg_port" . ]]/udp
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Config:    Docker volume "[[ var "data_volume" . ]]" (/etc/wireguard: keys + clients) — back it up

Set WG_HOST to your server's PUBLIC address and forward UDP [[ var "wg_port" . ]] to this node — clients connect
there. Create clients in the web UI and scan the QR code on your phone. Needs the NET_ADMIN capability and IP
forwarding (enabled here). Front the web UI with a reverse proxy for TLS; never expose it unauthenticated.
