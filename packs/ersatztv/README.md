# ersatztv

[ErsatzTV](https://ersatztv.org/) — build and stream your own **live TV channels** from your media collection. Schedule
movies, shows and music into channels, then watch them through Plex, Jellyfin or Emby via an HDHomeRun-style tuner and an
XMLTV guide. A powerful scheduler for a retro "always-on TV" experience.

Single host-networked Nomad service with a persistent config volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run ersatztv --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8409` | Web UI port. |
| `image` | `jasongdove/ersatztv:latest` | Container image. Pin a tag in production (e.g. `nvidia`/`vaapi` for HW transcoding). |
| `data_volume` | `ersatztv_data` | `/config` — database, channels and settings. |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. Add cores for transcoding. |

> Add your media libraries, build channels and schedules in the web UI, then point your media server's live-TV/DVR at
> ErsatzTV's M3U + XMLTV URLs. A prestart init task makes the config volume writable. For hardware transcoding, use the
> matching image tag and pass through the GPU device. Pin the job to the node holding the volume with `constraints`.
