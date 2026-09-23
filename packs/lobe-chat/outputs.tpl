Lobe Chat deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
[[ if ne (var "ollama_proxy_url" .) "" ]]Ollama:    [[ var "ollama_proxy_url" . ]] (from the ollama pack)
[[ end ]]
Stateless — chats and settings are stored in your browser. Configure model providers in Settings
(or via env). Pairs with the ollama pack for fully local chat. Set access_code to gate the app, and
front with TLS for public use.
