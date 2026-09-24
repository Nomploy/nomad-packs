LittleLink Server deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Stateless — no volumes, safe to scale via `count`. Configure your page entirely with environment variables:
NAME, THEME, DESCRIPTION, AVATAR_URL, plus social handles and custom buttons (TWITTER, GITHUB, EMAIL,
BUTTON_1_*, …) — see the LittleLink Server docs for the full list. Serves plain HTTP — front it with a
reverse proxy for TLS.
