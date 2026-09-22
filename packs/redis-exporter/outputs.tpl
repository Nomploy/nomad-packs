Redis Exporter deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Metrics:   http://<node-ip>:[[ var "port" . ]]/metrics
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Scraping:  [[ var "redis_addr" . ]]

Scrape it from Prometheus (the monitoring pack):
  - job_name: redis
    static_configs:
      - targets: ['127.0.0.1:[[ var "port" . ]]']

Works with the redis, valkey, and dragonfly packs. Set redis_password if the target
requires auth.
