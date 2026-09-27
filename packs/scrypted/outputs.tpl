Scrypted deployed as job "[[ var "job_name" . ]]" (host-networked).

Management console: https://<node-ip>:[[ var "port" . ]]   (self-signed cert; create the admin account on first visit)
HTTP endpoint:      http://<node-ip>:[[ var "http_port" . ]]
Discovery:          Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Scrypted needs host networking for camera discovery and HomeKit/mDNS, so pin it
(via constraints) to a node on the same LAN as your cameras. Install plugins for
your cameras and smart-home platforms from the management console.
