# garnet

[Garnet](https://microsoft.github.io/garnet/) — a high-performance, **Redis-compatible** cache-store from Microsoft
Research. It speaks the RESP wire protocol, so unmodified Redis clients work against it, while offering excellent
throughput, low latency and optional disk persistence. A drop-in alternative to Redis/Valkey.

Single host-networked Nomad service with a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run garnet --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `6379` | RESP (Redis) protocol port. |
| `aof` | `true` | Enable the append-only file for durability (`--aof`). Set `false` for a pure in-memory cache. |
| `image` | `ghcr.io/microsoft/garnet:latest` | Container image. Pin a tag in production. |
| `data_volume` | `garnet_data` | `/data` — checkpoints and the append-only file. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. Bump memory for large datasets. |

> Connect with any Redis client: `redis-cli -h <host> -p 6379`. A prestart init task makes the data volume writable.
> With `aof = true`, data survives restarts; disable it (and the app becomes a fast volatile cache). Pin the job to the
> node holding the volume with `constraints`, and don't expose the port to untrusted networks (no auth by default).
