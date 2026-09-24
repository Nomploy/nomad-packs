# backrest

[Backrest](https://garethgeorge.github.io/backrest/) — a web UI and orchestrator for
[restic](https://restic.net) backups. Schedule snapshots, manage repositories and retention, browse and restore
individual files, and get notifications — all from the browser, with restic's fast, encrypted, deduplicated
engine underneath.

Single host-networked Nomad service with persistent data, config, and cache volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run backrest --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `9898` | Web UI port (`BACKREST_PORT`). |
| `data_volume` | `backrest_data` | `/data` — restic binary + Backrest database. |
| `config_volume` | `backrest_config` | `/config` — `config.json` with repos and plans. |
| `cache_volume` | `backrest_cache` | `/cache` — the restic cache. |
| `sources_volume` | `backrest_sources` | `/userdata` — **the data to back up**. Swap for a bind mount to back up real host paths. |
| `image` | `garethgeorge/backrest:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 256 }` | Task resources. |

On first run, set an instance ID and admin password, then add a restic repository (local, **S3/R2**, SFTP,
rclone, …) and a backup plan targeting `/userdata`. To back up real host directories, replace the
`sources_volume` mount with a bind mount. Pairs with the `minio` or `rest-server` packs as a restic target. The
config/data volumes hold your repo passwords — keep them safe and back them up. Front it with a reverse proxy for
TLS. Pin the job to the node holding the volumes with `constraints`.
