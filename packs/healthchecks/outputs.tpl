Healthchecks deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (/data/hc.sqlite) — all checks + history; back it up

Log in with SUPERUSER_EMAIL / SUPERUSER_PASSWORD, create a check, and copy its ping URL. Have your
cron job / script curl that URL on success — Healthchecks alerts you when a ping is late or missing.
Set SITE_ROOT to your real domain so the ping URLs shown in the UI are correct. Configure email/webhook
integrations (or point them at the ntfy / gotify / apprise packs). Front it with a reverse proxy for TLS.
