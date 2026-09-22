# jellyfin

[Jellyfin](https://jellyfin.org) — the free software media system. Stream your own movies, TV,
music, and photos to any device, with no tracking and no fees.

Single host-networked Nomad service (the official `jellyfin/jellyfin` image, runs as root so the
fresh volumes are writable). Config and cache volumes plus a read-only media volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run jellyfin --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8096` | Web UI port. See note below. |
| `config_volume` | `jellyfin_config` | `/config` — config, metadata, database. |
| `cache_volume` | `jellyfin_cache` | `/cache` — transcode/cache. |
| `media_volume` | `jellyfin_media` | `/media`, read-only — your library. |
| `published_server_url` | `""` | Optional public URL (`JELLYFIN_PublishedServerUrl`). |
| `image` | `jellyfin/jellyfin:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 2000, memory = 1024 }` | Task resources; raise cpu for transcoding. |

## Notes

- Jellyfin binds its default HTTP port `8096`. There is no env to rebind it — to use another
  port, change it in **Dashboard → Networking** after first run and set the `port` variable to
  match (so discovery is correct).
- The media volume starts empty — populate it and add `/media` as a library.
- **Hardware transcoding** needs device access (`/dev/dri`, etc.), which this pack does not
  configure; software transcoding works but is CPU-heavy.
- Pin the job to the node holding the volumes with `constraints`.
