Open WebUI deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]  (create the admin account on first visit)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Ollama:    [[ var "ollama_base_url" . ]]
Data:      Docker volume "[[ var "data_volume" . ]]" (chats, users, settings) — back it up

Run the ollama pack (and pull a model) so Open WebUI has something to talk to. Front with a
reverse proxy for TLS; set a stable secret_key in production.
