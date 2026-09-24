OpenFGA deployed as job "[[ var "job_name" . ]]" (host-networked).

HTTP API:   http://<node-ip>:[[ var "http_port" . ]]
gRPC:       <node-ip>:[[ var "grpc_port" . ]]
Playground: http://<node-ip>:[[ var "playground_port" . ]]/playground
Discovery:  Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:       Docker volume "[[ var "data_volume" . ]]" (/data/openfga.db, SQLite) — back it up

The prestart "migrate" task creates the SQLite schema, then the server runs. Create a store and an
authorization model, then issue check/write calls from your app's SDK. This runs WITHOUT auth by default —
keep it internal, or set OPENFGA_AUTHN_* (preshared key / OIDC) for production.
