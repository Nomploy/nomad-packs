Traccar deployed as job "[[ var "job_name" . ]]" (host-networked).

Web UI:    http://<node-ip>:[[ var "port" . ]]   (register the first account; it becomes admin)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Traccar listens for GPS devices on the protocol port range 5000-5150 (TCP/UDP);
with host networking these are open on the node automatically. Point your
tracker/app at <node-ip> and the port for its protocol. The embedded H2 database
is fine for testing/small setups — switch to MySQL/PostgreSQL for production.
