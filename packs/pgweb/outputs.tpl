pgweb deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Running in --sessions mode: open the UI and enter a PostgreSQL connection string (or fields).
A co-located postgres pack is reachable at 127.0.0.1:5432. Stateless — no volume. pgweb exposes
full database access, so keep it on a trusted network / behind auth.
