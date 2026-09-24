Conduit (Matrix homeserver) deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Client API: http://<node-ip>:[[ var "port" . ]]
Server:     [[ var "server_name" . ]]
Discovery:  Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:       Docker volume "[[ var "data_volume" . ]]" (/var/lib/matrix-conduit) — all messages/keys; back it up

Point a Matrix client (Element, etc.) at your server. New users need the registration token you set.
FEDERATION: for other servers to reach you, [[ var "server_name" . ]] must resolve to this host and be
served over HTTPS on 443 (or advertise the port via a /.well-known/matrix/server file or a SRV record)
— put a TLS reverse proxy in front. The server_name is baked into every user id and cannot be changed
later.
