# valkey

[Valkey](https://valkey.io) — an open-source (**BSD**), high-performance in-memory key/value
datastore and a **drop-in replacement for Redis**. It's the Linux Foundation community fork
created after Redis's license change, so it stays fully open. Host-networked Nomad service
with AOF persistence on a volume.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run valkey --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `valkey`, custom registry
`github.com/Nomploy/nomad-packs`, then Deploy. Point any Redis client at `<node-ip>:6379`.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `valkey/valkey:8-alpine` | Pin a tag in production. |
| `port` | `6379` | Listen port. |
| `password` | `""` | Empty = open; set `requirepass`. |
| `data_volume` | `valkey_data` | AOF persistence. Back it up. |
| `constraints` | `[]` | Pin to a node so the local volume stays put. |
| `resources` | `cpu 300 / mem 256` | Raise for larger datasets. |

## Notes

- **Single node.** `count` is fixed to 1 (local volume). Pin with `constraints`.
- Wire-compatible with Redis — the `redisinsight` pack and any redis client/library work.
- vs the `redis` pack: same protocol; `valkey` is the BSD-licensed community fork. Pick
  whichever you prefer.
