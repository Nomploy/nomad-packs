Cefiro deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Database:  co-located PostgreSQL on port [[ var "db_port" . ]], volume "[[ var "db_data_volume" . ]]" — back it up
Uploads:   Docker volume "[[ var "uploads_volume" . ]]" (/app/uploads) — back it up (or use S3, see below)

Bundled: the Cefiro app + PostgreSQL 17 + Redis + the Obscura page-renderer (for URL imports).
Set AUTH_URL (base_url) to your real domain and keep MASTER_KEY stable — changing it invalidates all
encrypted data. With password_auth_enabled=true you can register the first admin from the UI.

To offload media to S3/R2 instead of the uploads volume, add STORAGE_DRIVER=s3 and the S3_* env vars
to the "cefiro" task. Serves plain HTTP — front it with a reverse proxy for TLS.
