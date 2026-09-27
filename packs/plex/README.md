# plex

[Plex Media Server](https://www.plex.tv/) — organize and stream your movies, TV, music and photos to Plex apps on every
device, with transcoding, live TV/DVR and rich metadata. This pack runs on the host network (recommended by Plex for
discovery and DLNA).

Single host-networked Nomad service with config, media and transcode volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run plex --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `32400` | Web UI / API port. |
| `claim_token` | `""` | Optional `PLEX_CLAIM` to link the server to your account on first run — get one at [plex.tv/claim](https://plex.tv/claim) (valid ~4 min). |
| `image` | `plexinc/pms-docker:latest` | Container image. Pin a tag in production. |
| `data_volume` | `plex_data` | `/config` — Plex database and settings. |
| `media_volume` | `plex_media` | `/data` — your media library. |
| `transcode_volume` | `plex_transcode` | `/transcode` — transcoder scratch. |
| `puid` / `pgid` | `1000` / `1000` | User/group that owns the files (`PUID`/`PGID`). |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. Bump for transcoding. |

> Set `claim_token` for a smooth first-run link to your Plex account (or claim later via the setup wizard at
> `http://<host>:32400/web`). Plex uses host networking for client discovery. For hardware transcoding, pass through the
> GPU/render device. Pin the job to the node holding the volumes with `constraints`. See also
> [jellyfin](https://packs.nomploy.com/packs/jellyfin) and [emby](https://packs.nomploy.com/packs/emby).
