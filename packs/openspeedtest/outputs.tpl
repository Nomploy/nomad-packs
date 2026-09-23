OpenSpeedTest deployed as job "[[ var "job_name" . ]]" (host-networked).

Open:      http://<node-ip>:[[ var "port" . ]]   (HTTPS: https://<node-ip>:[[ var "https_port" . ]])
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Stateless — no volumes. For accurate results above ~1 Gbps, use the HTTPS URL (HTTP/2). To test
real throughput, run the server on a machine with a fast NIC and test from another device on the
network.
