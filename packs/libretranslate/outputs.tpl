LibreTranslate deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
API:       POST http://<node-ip>:[[ var "port" . ]]/translate  (q, source, target)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Models:    Docker volume "[[ var "models_volume" . ]]" (/home/libretranslate/.local) — downloaded on first boot

First boot downloads the language models named in load_only ("[[ var "load_only" . ]]"), so it may take a
while and needs internet. Translation runs fully on your hardware afterward. Enable api_keys_enabled and
run `ltmanage keys add` in the container to require API keys. Serves plain HTTP — front it with a reverse
proxy for TLS.
