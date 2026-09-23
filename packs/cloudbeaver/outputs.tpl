CloudBeaver deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Complete the initial setup wizard on first visit (create the admin account and server name), then
add database connections. A co-located postgres/mariadb/clickhouse pack is reachable on 127.0.0.1.
The workspace (connections, users, settings) lives on the [[ var "data_volume" . ]] volume
(/opt/cloudbeaver/workspace) — pin the job to that node with the constraints variable. CloudBeaver
grants broad DB access, so keep it on a trusted network / behind auth.
