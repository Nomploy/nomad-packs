CouchDB deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

API:       http://<node-ip>:[[ var "port" . ]]/
Fauxton UI: http://<node-ip>:[[ var "port" . ]]/_utils
Login:     [[ var "admin_user" . ]] / <admin_password>
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (databases) — back it up

First boot creates the admin. On a fresh single node, initialize the system databases once:
  curl -X POST http://[[ var "admin_user" . ]]:<pw>@<node-ip>:[[ var "port" . ]]/_cluster_setup \
    -H 'Content-Type: application/json' -d '{"action":"enable_single_node"}'
