# jellyseerr

[Jellyseerr](https://docs.jellyseerr.dev) — request management and media discovery for
Jellyfin/Plex/Emby. Users browse and request movies and TV; it integrates with Sonarr/Radarr to
fulfil requests.

Single host-networked Nomad service with a config volume. Pairs with the [jellyfin](../jellyfin)
pack.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run jellyseerr --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `5055` | Web UI port (`PORT`). |
| `log_level` | `info` | `LOG_LEVEL` — debug/info/warn/error. |
| `data_volume` | `jellyseerr_config` | `/app/config` — settings + SQLite database. |
| `image` | `fallenbagel/jellyseerr:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. |

Sign in with your media-server account on first visit and connect Jellyfin/Plex + Sonarr/Radarr.
Pin the job to the node holding the volume with `constraints`.
