Technitium DNS Server deployed as job "[[ var "job_name" . ]]" (host-networked).

Console:   http://<node-ip>:[[ var "web_port" . ]]  (log in as admin)
DNS:       <node-ip>:[[ var "dns_port" . ]] (UDP + TCP)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Config:    Docker volume "[[ var "data_volume" . ]]" (/etc/dns: settings + zones) — back it up

Log in with admin / your DNS_SERVER_ADMIN_PASSWORD, then set forwarders, enable ad-blocking, or host
your own zones. Point clients' DNS at <node-ip>. NOTE: binding port 53 requires that nothing else on the
node already uses it — on many Linux hosts you must first disable systemd-resolved's stub listener
(DNSStubListener=no).
