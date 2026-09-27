NetAlertX deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

NetAlertX scans the LAN of the node it runs on, so pin it (via constraints) to a
node connected to the network you want monitored. It needs the raw-socket
capabilities (granted here) to run arp-scan. Configure scan settings and
notifications under Settings in the UI.
