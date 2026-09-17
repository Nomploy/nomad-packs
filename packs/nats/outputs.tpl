NATS deployed as job "[[ var "job_name" . ]]" (host-networked).

Client:     nats://[[ if ne (var "auth_token" .) "" ]]<token>@[[ end ]]<node-ip>:[[ var "client_port" . ]]
Monitoring: http://<node-ip>:[[ var "monitoring_port" . ]]/varz  (also /healthz, /jsz)
Discovery:  Nomad service "[[ var "job_name" . ]]" (provider=nomad) on the client port
JetStream:  [[ if var "jetstream" . ]]enabled — persisted to Docker volume "[[ var "data_volume" . ]]" (back it up)[[ else ]]disabled (core NATS only, no persistence)[[ end ]]
Auth:       [[ if ne (var "auth_token" .) "" ]]token required[[ else ]]OPEN (no auth) — set auth_token to require a token[[ end ]]
