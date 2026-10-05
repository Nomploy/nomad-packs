Yamtrack deployed as job "[[ var "job_name" . ]]" (all-in-one, host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Bundled: Redis (prestart sidecar, port [[ var "redis_port" . ]]) for background tasks. The
app stores its data in SQLite inside the yamtrack_db volume. Database migrations run
automatically on first start; create the first account in the UI.

CHANGE secret to a long random value before deploying anywhere real and keep it stable.
Add a TMDB / IGDB / MAL API key in the settings to enable metadata lookups for the media
types you track.
