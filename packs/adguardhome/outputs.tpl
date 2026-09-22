AdGuard Home deployed as job "[[ var "job_name" . ]]" (host-networked).

Setup wizard: http://<node-ip>:[[ var "setup_port" . ]]  (first run only)
Dashboard:    http://<node-ip>:[[ var "web_port" . ]]   (after setup)
DNS server:   <node-ip>:[[ var "dns_port" . ]]  (TCP + UDP)
Discovery:    Nomad service "[[ var "job_name" . ]]" (provider=nomad)

First run: open the setup wizard, keep the admin interface on port [[ var "web_port" . ]] and
DNS on port [[ var "dns_port" . ]], and create your username/password. Then point your router's
or devices' DNS at <node-ip>.

Data (query log, stats, filters) is on [[ var "work_volume" . ]]; the config on
[[ var "conf_volume" . ]]. Pin the job to that node with the constraints variable. Note: port
[[ var "dns_port" . ]] must be free on the host (a systemd-resolved stub often holds :53).
