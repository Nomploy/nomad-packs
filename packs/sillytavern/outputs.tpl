SillyTavern deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Whitelist mode is off and listening is enabled so the UI is reachable on your
network. This exposes it to anyone who can reach the node — set basic_auth=true
(and a strong basic_auth_password), or keep it behind a trusted network / proxy.
Add your LLM backend API keys under the API connections panel in the UI.
