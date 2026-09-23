Consul deployed as job "[[ var "job_name" . ]]" (single-node server, host-networked).

Web UI / HTTP API: http://<node-ip>:[[ var "http_port" . ]]
DNS interface:     <node-ip>:[[ var "dns_port" . ]]  (TCP + UDP)
Discovery:         Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Use the KV store and register services via the HTTP API or the consul CLI:
  nomad alloc exec -task consul <alloc> consul kv put myapp/config '{"key":"value"}'
  nomad alloc exec -task consul <alloc> consul members

This is a single-node, ACL-open server for app config / KV / discovery — restrict it to a trusted
network. For a production HA cluster, run multiple servers with gossip encryption + ACLs. Data lives
on the [[ var "data_volume" . ]] volume (/consul/data); pin the job to that node with the
constraints variable.
