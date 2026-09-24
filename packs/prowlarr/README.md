# prowlarr

[Prowlarr](https://prowlarr.com) — an **indexer manager** for the *arr media stack. Configure your torrent and
Usenet indexers once, and Prowlarr keeps them in sync across Sonarr, Radarr, Lidarr, Readarr, and more — with
unified search, stats, and health checks.

Single host-networked Nomad service with a persistent config volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run prowlarr --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `9696` | Web UI port. |
| `config_volume` | `prowlarr_config` | `/config` — database, settings, indexers. |
| `puid` / `pgid` | `1000` / `1000` | User/group the app runs as (`PUID`/`PGID`). |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `image` | `lscr.io/linuxserver/prowlarr:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

Add indexers, then link the `sonarr` / `radarr` packs under **Settings > Apps** so Prowlarr pushes indexers to
them (co-located apps are reachable on `127.0.0.1`). Serves plain HTTP — front it with a reverse proxy for TLS.
Only use indexers you're entitled to. Pin the job to the node holding the volume with `constraints`.
