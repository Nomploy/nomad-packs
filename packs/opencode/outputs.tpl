OpenCode deployed as job "[[ var "job_name" . ]]" (headless server, host-networked on port [[ var "port" . ]]).

Server API: http://<node-ip>:[[ var "port" . ]]
Discovery:  Nomad service "[[ var "job_name" . ]]" (provider=nomad)

This runs `opencode serve` — the headless HTTP server. Connect the OpenCode TUI or an editor
extension to it (point the client at http://<node-ip>:[[ var "port" . ]]), or drive it over the API.

Set a provider key (anthropic_api_key and/or openai_api_key) — or point OpenCode at a local
OpenAI-compatible endpoint (the litellm/ollama packs) via its config. Config and auth/sessions live on
[[ var "config_volume" . ]] and [[ var "data_volume" . ]]. It has no built-in auth — keep it on a
trusted network / behind TLS+auth, and pin the job to the node holding the volumes with the
constraints variable.
