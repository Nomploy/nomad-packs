Gatus deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Status page: http://<node-ip>:[[ var "port" . ]]
Discovery:   Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Stateless (in-memory results by default). Edit the `endpoints` var to monitor your services
(HTTP/TCP/DNS/ICMP + conditions), and add `alerting:` in the config for notifications.
Gatus probes from the node it runs on — pin it (constraints) accordingly.
