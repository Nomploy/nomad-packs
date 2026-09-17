# redis

Redis as a host-networked Nomad `service` with **AOF persistence** on a Docker
named volume.

## Usage

```
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run redis --registry nomploy --var password=change-me
```

Or in nomploy: **Create → Nomad Pack**, pick `redis` from the Nomploy registry.

## Variables

| Variable | Default | Description |
|---|---|---|
| `job_name` | `redis` | Nomad job name |
| `image` | `redis:7-alpine` | Container image |
| `port` | `6379` | Host port (pick a free one per node) |
| `count` | `1` | Keep at 1 (local-disk AOF) |
| `password` | `""` | `requirepass` password; empty = no auth |
| `data_volume` | `redis_data` | Docker named volume for `/data` |
| `constraints` | `[]` | Pin placement so the local volume stays put |
| `resources` | `{cpu=300, memory=256}` | Task resources |

## Notes

- **Persistence:** AOF is enabled (`--appendonly yes`) and stored on a Docker named
  volume, so data survives restarts and reschedules. Pin the job with `constraints`
  so it lands on the node holding the volume.
- Leave `password` empty only on a trusted private/overlay network.
