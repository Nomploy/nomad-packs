Qdrant deployed as job "[[ var "job_name" . ]]" (host-networked).

REST + dashboard: http://<node-ip>:[[ var "http_port" . ]]/dashboard
gRPC:            <node-ip>:[[ var "grpc_port" . ]]
Discovery:       Nomad service "[[ var "job_name" . ]]" (provider=nomad) on the HTTP port
Data:            Docker volume "[[ var "data_volume" . ]]" (collections + vectors) — back it up
Auth:            [[ if ne (var "api_key" .) "" ]]api-key required (header: api-key)[[ else ]]OPEN (no auth) — set api_key to require one[[ end ]]

Use with the ollama pack for embeddings + RAG. Point your client at http://<node-ip>:[[ var "http_port" . ]].
