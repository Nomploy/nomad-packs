# emby

[Emby](https://emby.media/) — a personal **media server** that organizes and streams your movies, TV, music and photos
to apps on every device, with live TV/DVR, user profiles and parental controls. A polished alternative/cousin to
Jellyfin and Plex.

Single host-networked Nomad service with config and media volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run emby --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8096` | Web UI port. |
| `image` | `lscr.io/linuxserver/emby:latest` | Container image. Pin a tag in production. |
| `data_volume` | `emby_data` | `/config` — Emby database and settings. |
| `media_volume` | `emby_media` | `/data` — your media library. |
| `puid` / `pgid` | `1000` / `1000` | User/group that owns the files (`PUID`/`PGID`). |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. Bump for transcoding. |

> Complete the setup wizard on first launch and point Emby at your library under `/data`. For hardware transcoding, pass
> through the GPU/render device and use the appropriate image tag. Pin the job to the node holding the volumes with
> `constraints`. See also [jellyfin](https://packs.nomploy.com/packs/jellyfin) (FOSS) and
> [plex](https://packs.nomploy.com/packs/plex).
