soketi deployed as job "[[ var "job_name" . ]]" (host-networked).

WebSocket: ws://<node-ip>:[[ var "port" . ]]
Metrics:   http://<node-ip>:[[ var "metrics_port" . ]]/metrics
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Point a Pusher-compatible client at this host with:
  app id     = [[ var "app_id" . ]]
  app key    = [[ var "app_key" . ]]
  app secret = [[ var "app_secret" . ]]
  host/port  = <node-ip>:[[ var "port" . ]]  (forceTLS: false)

Stateless (in-memory) — CHANGE the default app credentials, and front with TLS for browser
clients in production.
