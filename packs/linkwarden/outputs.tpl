Linkwarden deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Tasks: postgres (prestart sidecar) + linkwarden (app).

[[ if eq (var "base_url" .) "" ]]NOTE: NEXTAUTH_URL is derived from http://localhost:[[ var "port" . ]] — set the base_url variable
to this node's host/IP or your domain, or login/OAuth callbacks won't resolve for remote clients.
[[ else ]]Auth base: [[ var "base_url" . ]]/api/v1/auth (NEXTAUTH_URL).
[[ end ]]
Create the first account (it becomes admin). Bookmarks live in PostgreSQL
([[ var "db_data_volume" . ]]); archived snapshots (screenshots/PDFs) on [[ var "data_volume" . ]]
(/data/data). Set a long random nextauth_secret. Pin the job to the node holding the volumes.
