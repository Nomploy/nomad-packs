openHAB deployed as job "[[ var "job_name" . ]]" (host-networked).

Web UI:    http://<node-ip>:[[ var "port" . ]]   (run the first-start setup wizard)
HTTPS:     https://<node-ip>:[[ var "https_port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

openHAB uses host networking so UPnP/mDNS device discovery works — pin it (via
constraints) to a node on the same LAN as your devices. Configuration, the
database and add-ons persist across three separate volumes.
