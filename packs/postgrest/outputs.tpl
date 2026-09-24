PostgREST deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

API:       http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Stateless — no volumes, safe to scale via `count`. Point PGRST_DB_URI at your PostgreSQL (the `postgres`
pack co-located on the node is reachable at 127.0.0.1:5432). Create an `authenticator` login role and an
anonymous role (db_anon_role), then GET http://<node-ip>:[[ var "port" . ]]/<table>. Set a JWT secret to
enable authenticated, role-based access, and rely on PostgreSQL row-level security for authorization.
