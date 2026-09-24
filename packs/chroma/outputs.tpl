Chroma deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

API:       http://<node-ip>:[[ var "port" . ]]
Heartbeat: http://<node-ip>:[[ var "port" . ]]/api/v2/heartbeat
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (/chroma/chroma) — all collections; back it up

Connect from Python: chromadb.HttpClient(host="<node-ip>", port=[[ var "port" . ]]). Pairs with the
ollama / open-webui packs for a local RAG stack. The API is unauthenticated by default — keep it on an
internal network, or enable token auth with the CHROMA_SERVER_AUTHN_* env vars.
