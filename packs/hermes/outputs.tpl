Hermes Agent deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

API (OpenAI-compatible): http://<node-ip>:[[ var "port" . ]]
Health:                  http://<node-ip>:[[ var "port" . ]]/health
Discovery:               Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Give it a model provider — set openai_api_key and/or anthropic_api_key, or point openai_base_url at a
local OpenAI-compatible endpoint (the litellm pack at http://127.0.0.1:4000/v1, or ollama). Then use
it like the OpenAI API[[ if ne (var "auth_token" .) "" ]] with Authorization: Bearer <auth_token>[[ end ]], or connect a UI (e.g. Open WebUI).

Persistent memory, config, and keys live on the [[ var "data_volume" . ]] volume (/opt/data) — pin
the job to that node with the constraints variable. Set auth_token before exposing it.
