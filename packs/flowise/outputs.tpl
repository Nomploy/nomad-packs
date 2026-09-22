Flowise deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI / API: http://<node-ip>:[[ var "port" . ]]
Discovery:    Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Login:        [[ if ne (var "username" .) "" ]][[ var "username" . ]] / (the password you set)[[ else ]]none (open — set username/password to enable)[[ end ]]

Build flows in the UI; each deployed chatflow gets an API endpoint and embed snippet. Point LLM
nodes at the ollama pack (http://127.0.0.1:11434) and vector-store nodes at qdrant/weaviate. Data,
API keys, and files live on the [[ var "data_volume" . ]] volume (/root/.flowise) — pin the job to
that node with the constraints variable.
