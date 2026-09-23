Redpanda deployed as job "[[ var "job_name" . ]]" (single-node dev-container, host-networked).

Kafka API:       <node-ip>:[[ var "kafka_port" . ]]  (advertised as [[ var "advertise_host" . ]]:[[ var "kafka_port" . ]])
Admin API:       http://<node-ip>:[[ var "admin_port" . ]]
HTTP Proxy:      http://<node-ip>:[[ var "proxy_port" . ]]
Schema Registry: http://<node-ip>:[[ var "schema_port" . ]]
Discovery:       Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Manage it with rpk (bundled in the image):
  nomad alloc exec -task redpanda <alloc> rpk cluster info
  nomad alloc exec -task redpanda <alloc> rpk topic create my-topic

IMPORTANT: set advertise_host to the node's IP for remote clients (127.0.0.1 only works for
clients on the same host). dev-container mode is for a single node — not for production clusters.
Data lives on [[ var "data_volume" . ]]; pin the job to that node with the constraints variable.
