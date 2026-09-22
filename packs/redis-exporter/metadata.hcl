app {
  url = "https://github.com/oliver006/redis_exporter"
}

pack {
  name        = "redis-exporter"
  description = "Prometheus Redis Exporter — scrapes a Redis, Valkey, or Dragonfly server and exposes memory, keyspace, clients, and command metrics for Prometheus. Deployed as a stateless host-networked Nomad service; point it at any reachable instance. Pairs with the redis/valkey and monitoring packs."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/redis-exporter"
  version     = "0.1.0"
}
