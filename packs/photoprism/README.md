# photoprism

[PhotoPrism](https://www.photoprism.app) — a privacy-first, AI-powered app for browsing,
organizing, and sharing your photos and videos, with automatic tagging and face recognition
that runs entirely on your own hardware.

Single host-networked Nomad service using SQLite (no separate database to run). Runs as root so
the fresh volumes are writable.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run photoprism --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `2342` | Web UI port (`PHOTOPRISM_HTTP_PORT`). |
| `admin_user` | `admin` | Initial admin username. |
| `admin_password` | `changeme-please` | Initial admin password (min 8 chars). **Change it.** |
| `site_url` | `""` | Public URL (`PHOTOPRISM_SITE_URL`); empty = derive from request. |
| `storage_volume` | `photoprism_storage` | `/photoprism/storage` — SQLite DB, cache, thumbnails. |
| `originals_volume` | `photoprism_originals` | `/photoprism/originals` — your photos/videos. |
| `image` | `photoprism/photoprism:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 2000, memory = 3072 }` | Task resources; 4GB+ RAM recommended. |

Add photos to the originals volume, then **Library → Index** to import them. SQLite is fine for
personal libraries; use MariaDB for very large ones. Pin the job to the node holding the volumes
with `constraints`.
