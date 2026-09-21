Ollama deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

API:       http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Models:    Docker volume "[[ var "data_volume" . ]]" (/root/.ollama)

Pull a model, then chat:
  curl http://<node-ip>:[[ var "port" . ]]/api/pull  -d '{"name":"llama3.2"}'
  curl http://<node-ip>:[[ var "port" . ]]/api/generate -d '{"model":"llama3.2","prompt":"hi"}'

CPU-only by default (slow for big models); a GPU needs Nomad device config (not set here).
No auth — keep it internal. Pairs well with a chat UI like Open WebUI.
