n8n deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      [[ if ne (var "webhook_url" .) "" ]][[ var "webhook_url" . ]][[ else ]]http://<node-ip>:[[ var "port" . ]][[ end ]]  (set up the owner account on first visit)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (SQLite DB + encryption key) — back it up

[[ if var "secure_cookie" . ]]Secure cookie is ON — serve n8n over HTTPS or logins will be blocked.[[ else ]]Secure cookie is off so http://<ip>:[[ var "port" . ]] logins work; set secure_cookie=true behind HTTPS.[[ end ]]
[[ if eq (var "encryption_key" .) "" ]]An encryption key was auto-generated into the volume — back it up, or credentials can't be restored elsewhere.[[ end ]]
When fronting with a domain, set `host` and `webhook_url` so webhooks route correctly.
