Vaultwarden deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web vault: [[ if ne (var "domain" .) "" ]][[ var "domain" . ]][[ else ]]http://<node-ip>:[[ var "port" . ]][[ end ]]  (create your account, then point Bitwarden clients here)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (SQLite DB, keys, attachments) — BACK IT UP
Signups:   [[ if var "signups_allowed" . ]]OPEN — set signups_allowed=false after your users register[[ else ]]closed[[ end ]]
Admin:     [[ if ne (var "admin_token" .) "" ]]/admin enabled (token-protected)[[ else ]]/admin disabled (set admin_token to enable)[[ end ]]

IMPORTANT: serve over HTTPS (front with a reverse proxy) — browser crypto features and the
Bitwarden clients require it in practice. Set `domain` to your public https URL.
