# lms

[LMS](https://github.com/epoupon/lms) (Lightweight Music Server) — a self-hosted, **Subsonic/OpenSubsonic-compatible**
music streaming server built to be light on resources. It offers smart playlists, similarity-based recommendations,
scrobbling and multi-user support, and works with any Subsonic client.

Single host-networked Nomad service with a working-data volume and a read-only music volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run lms --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `5082` | Web UI / Subsonic API port. |
| `image` | `epoupon/lms:latest` | Container image. Pin a tag in production. |
| `data_volume` | `lms_data` | `/var/lms` — database, config and caches. |
| `music_volume` | `lms_music` | `/music` (read-only) — your music library. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> On first launch, create the admin account and set the media folder to `/music` in settings, then scan. A prestart
> init task makes the working directory writable. Behind a reverse proxy, remember to trust the proxy so client IPs are
> read correctly. Pin the job to the node holding the volumes with `constraints`. A lightweight alternative to
> [navidrome](https://packs.nomploy.com/packs/navidrome) / [gonic](https://packs.nomploy.com/packs/gonic).
