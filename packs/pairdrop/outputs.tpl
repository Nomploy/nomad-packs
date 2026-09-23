PairDrop deployed as job "[[ var "job_name" . ]]" (stateless, host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Open the URL on two devices on the same network and they'll discover each other automatically — then
drag files or text between them (peer-to-peer via WebRTC). Devices on different networks can pair
with a code. Stateless — nothing is stored server-side.

Note: browsers require a secure context for WebRTC, so for use beyond localhost put it behind TLS
(e.g. the caddy or nginx-proxy-manager pack).
