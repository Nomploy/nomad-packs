TREK deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

TREK stores everything in SQLite inside the trek_data volume; uploads go to the
trek_uploads volume. No external database is needed. Create the first account in the UI.

CHANGE encryption_key to a long random value before deploying anywhere real and keep it
stable (it encrypts stored integration keys — rotating it makes them unreadable). Set
allowed_origins to your public URL when exposing TREK behind a proxy.
