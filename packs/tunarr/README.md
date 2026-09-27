# tunarr

[Tunarr](https://tunarr.com/) — create your own **live TV channels** from your Plex/Jellyfin media, then watch them
through those apps as if they were broadcast. It exposes an HDHomeRun-style tuner plus an M3U playlist and XMLTV guide,
with a slick web UI for building channels, schedules and commercials. The spiritual successor to dizqueTV.

Single host-networked Nomad service with a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run tunarr --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8000` | Web UI port. |
| `image` | `chrisbenincasa/tunarr:latest` | Container image. Pin a tag in production. |
| `data_volume` | `tunarr_data` | `/config/tunarr` — database, settings and cache. |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. Add cores if you enable transcoding. |

> Connect Tunarr to your media server(s) and FFmpeg in the web UI, build channels, then add the tuner/M3U + XMLTV URLs
> to Jellyfin/Plex/Emby. A prestart init task makes the data volume writable. For hardware transcoding, pass through the
> render device. Pin the job to the node holding the volume with `constraints`.
