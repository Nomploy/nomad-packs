LiteLLM deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

OpenAI-compatible API: http://<node-ip>:[[ var "port" . ]]
Discovery:             Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Call it like the OpenAI API, authenticating with your master key:
  curl http://<node-ip>:[[ var "port" . ]]/v1/chat/completions \
    -H "Authorization: Bearer <master_key>" \
    -d '{"model":"ollama/llama3","messages":[{"role":"user","content":"hi"}]}'

The default config proxies all models from the ollama pack ([[ var "ollama_base" . ]]). Edit the
config variable to add OpenAI/Anthropic/etc. models and keys. CHANGE the master_key. Stateless (no
DB) — for teams/keys/budgets, add a Postgres database (see the LiteLLM docs).
