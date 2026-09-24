EventStoreDB deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Admin UI:  http://<node-ip>:[[ var "port" . ]]
Clients:   esdb://<node-ip>:[[ var "port" . ]]?tls=false  (gRPC SDKs)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (/var/lib/eventstore) — all events; back it up

Runs in single-node INSECURE mode (no TLS/auth) for easy self-hosting — keep it on an internal network, or
configure certificates for production. Append events to streams and consume them with catch-up or persistent
subscriptions; projections are set to "[[ var "run_projections" . ]]".
