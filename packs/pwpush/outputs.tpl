Password Pusher deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Password Pusher stores its SQLite database and uploads in the pwpush_storage volume — no
external database is needed. Paste a password or secret, get a self-destructing link with
an expiry and view limit to share.

Put it behind HTTPS (a reverse proxy) for real use, since you'll be sending secrets
through it. For heavy use you can switch to PostgreSQL and S3-compatible storage via the
PWP__* / DATABASE_URL environment variables — see the Password Pusher docs.
