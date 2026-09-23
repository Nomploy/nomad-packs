Opengist deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

The first registered user becomes the admin. Create and share snippets with syntax highlighting,
revisions, and public/unlisted/private visibility. Git-over-SSH is disabled by default (HTTP only);
enable it via OG_SSH_GIT_ENABLED and an SSH port if you want git push/pull.

Database and Git repos live on the [[ var "data_volume" . ]] volume (/opengist) — back it up and
pin the job to that node with the constraints variable.
