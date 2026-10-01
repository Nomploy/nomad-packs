Gel deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Server:    gel://admin:<password>@<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Gel bundles its own PostgreSQL and generates a self-signed TLS certificate on
first start. Change server_password before deploying anywhere real. Connect with
the `gel` CLI or any Gel client; create your schema and run migrations with
`gel migrate`. Data persists in the data_volume.
