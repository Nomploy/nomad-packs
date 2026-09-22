# dragonfly

[DragonflyDB](https://www.dragonflydb.io) — a modern, **multi-threaded** in-memory datastore
that's **drop-in compatible with the Redis and Memcached APIs**, designed for very high
throughput on a single node. Host-networked Nomad service with snapshots on a persistent
volume.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run dragonfly --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `dragonfly`, custom registry
`github.com/Nomploy/nomad-packs`, then Deploy. Point any Redis client at `<node-ip>:6379`.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `docker.dragonflydb.io/dragonflydb/dragonfly:latest` | Pin a tag in production. |
| `port` | `6379` | Listen port (Redis-compatible). |
| `password` | `""` | Empty = open; set `--requirepass`. |
| `data_volume` | `dragonfly_data` | Snapshots. Back it up. |
| `constraints` | `[]` | Pin to a node so the local volume stays put. |
| `resources` | `cpu 1000 / mem 1024` | **Give it real memory** — Dragonfly shines with 4GB+. |

## Notes

- **Single node.** `count` is fixed to 1 (local volume). Pin with `constraints`.
- A `memlock` ulimit is set (Dragonfly requires it). Needs Linux kernel ≥ 4.19.
- If it fails to initialize on some hosts/kernels, that node may need docker `allow_privileged`
  (add `privileged = true`) — not enabled here by default.
- vs `redis`/`valkey`: same wire protocol; Dragonfly is multi-threaded for high throughput.
