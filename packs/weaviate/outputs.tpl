Weaviate deployed as job "[[ var "job_name" . ]]" (host-networked).

REST/GraphQL: http://<node-ip>:[[ var "port" . ]]  (readiness: /v1/.well-known/ready)
gRPC:         <node-ip>:[[ var "grpc_port" . ]]  (used by the v4 clients)
Discovery:    Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Auth: [[ if ne (var "api_key" .) "" ]]API key enabled (send Authorization: Bearer <api_key>)[[ else if var "anonymous_access" . ]]anonymous access ON (open — restrict on a shared network)[[ else ]]anonymous access OFF[[ end ]]

Default vectorizer module is "none" — supply your own vectors, or enable a module and the matching
inference service. Pairs with the ollama pack for local embeddings. Data is on the
[[ var "data_volume" . ]] volume (/var/lib/weaviate); pin the job to that node with constraints.
