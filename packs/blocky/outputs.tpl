Blocky deployed as job "[[ var "job_name" . ]]" (host-networked).

DNS:       <node-ip>:[[ var "dns_port" . ]] (UDP + TCP)
HTTP/API:  http://<node-ip>:[[ var "http_port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Point your router's or devices' DNS at <node-ip>:[[ var "dns_port" . ]] to filter ads and
trackers network-wide. The HTTP port serves the query UI and Prometheus metrics
(/metrics). The config is seeded from the upstreams and blocklists variables; edit them
and redeploy, or customize further per the Blocky docs.

Test it: dig @<node-ip> -p [[ var "dns_port" . ]] example.com
