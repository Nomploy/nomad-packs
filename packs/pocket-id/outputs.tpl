Pocket ID deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    [[ if ne (var "app_url" .) "" ]][[ var "app_url" . ]][[ else ]]http://<node-ip>:[[ var "port" . ]][[ end ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

IMPORTANT: passkeys are WebAuthn and origin-bound — set the app_url variable to the EXACT URL your
browser uses (scheme+host+port), and serve over HTTPS (WebAuthn requires a secure context; only
"localhost" is exempt). Behind a TLS reverse proxy, set app_url to the https URL and trust_proxy=true.

On first start, open the URL to create the initial admin and register a passkey. Register OIDC
clients in the admin UI. Data + keys live on the [[ var "data_volume" . ]] volume (/app/data) — pin
the job to that node with the constraints variable.
