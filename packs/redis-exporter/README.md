# redis-exporter

[Prometheus Redis Exporter](https://github.com/oliver006/redis_exporter) (oliver006) — scrapes a
Redis, Valkey, or Dragonfly server and exposes memory, keyspace, clients, and per-command
metrics for Prometheus.

Stateless, host-networked Nomad service. Point it at any reachable instance; with host
networking a co-located [redis](../redis) / [valkey](../valkey) / [dragonfly](../dragonfly)
pack is on `127.0.0.1`.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run redis-exporter --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `9121` | Host port for `/metrics`. |
| `redis_addr` | `redis://127.0.0.1:6379` | Target server (`REDIS_ADDR`). |
| `redis_password` | `""` | Target password (`REDIS_PASSWORD`); empty if auth is off. |
| `image` | `oliver006/redis_exporter:latest` | Exporter image. Pin a tag in production. |
| `resources` | `{ cpu = 200, memory = 64 }` | Task resources. |

## Scrape

```yaml
- job_name: redis
  static_configs:
    - targets: ['127.0.0.1:9121']
```
