# redisinsight

[RedisInsight](https://redis.io/insight/) — the official **Redis GUI**: browse and edit
keys, run commands in a workbench, analyze memory, and visualize data structures. Pairs with
the `redis` pack. Host-networked Nomad service with a persistent volume for saved
connections.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run redisinsight --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `redisinsight`, custom
registry `github.com/Nomploy/nomad-packs`, then Deploy.

Open `http://<node-ip>:5540`, then add a database — host `127.0.0.1` (same node) or
`<node-ip>`, port `6379` (plus the password if your redis pack sets one).

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `redis/redisinsight:latest` | Pin a tag in production. |
| `port` | `5540` | Web UI (`RI_APP_PORT`). |
| `data_volume` | `redisinsight_data` | Saved connections (includes DB passwords). |
| `constraints` | `[]` | Pin to a node so the local volume stays put. |
| `resources` | `cpu 300 / mem 256` | Lightweight. |

## Notes

- **Single node.** `count` is fixed to 1 (local volume). A prestart task chowns the volume to
  uid 1000 (the app user). Pin with `constraints`.
- Stores DB credentials — keep it internal / behind an authenticating reverse proxy.
