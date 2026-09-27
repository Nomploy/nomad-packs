LibreChat deployed as job "[[ var "job_name" . ]]" (all-in-one, host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

MongoDB is bundled as a prestart sidecar (port [[ var "mongo_port" . ]]).
Register the first account in the UI, then paste your provider API keys
(OpenAI / Anthropic / Google) in each endpoint — they are set to "user_provided"
so every user supplies their own. Change creds_key, creds_iv and the JWT secrets
before deploying anywhere real. Meilisearch (message search) is disabled here;
enable it separately if you want full-text search.
