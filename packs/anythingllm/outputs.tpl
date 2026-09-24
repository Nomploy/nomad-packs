AnythingLLM deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Storage:   Docker volume "[[ var "storage_volume" . ]]" (/app/server/storage: DB, vectors, docs) — back it up

On first run the setup wizard lets you pick an LLM provider and embedding/vector settings. Point it at the
co-located "ollama" pack (http://127.0.0.1:11434) and the "chroma"/"qdrant" packs for a fully local RAG
stack, then create a workspace and upload documents. Serves plain HTTP — front it with a reverse proxy for
TLS.
