# wanderer

[wanderer](https://wanderer.to/) — a self-hosted **trail database** and GPS-track manager: upload GPX/FIT tracks, view
them on interactive maps with elevation profiles, tag and search your routes, and share them. A privacy-friendly
Strava/Komoot alternative for planning and archiving your hikes, rides and runs.

This pack is **batteries-included**: a single host-networked group running three tasks —

- **web** — the wanderer app.
- **db** — the PocketBase database + backend (`/pb_data`).
- **meilisearch** — full-text trail search (loopback).

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run wanderer --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3000` | Web UI port. |
| `db_port` | `8090` | PocketBase database/API port (must be browser-reachable). |
| `base_url` | `""` | Public URL of the web UI (`ORIGIN`). Empty = `http://localhost:<port>`. |
| `pocketbase_url` | `""` | **Set for real use.** Browser-reachable DB URL (`PUBLIC_POCKETBASE_URL`), e.g. `http://your-host:8090`. |
| `meili_master_key` | `change-me-…` | **Change this.** Shared by the db and Meilisearch. |
| `pocketbase_encryption_key` | `0123…` | **Change this** (exactly 32 chars) and keep it stable. |
| `data_volume` | `wanderer_data` | `/pb_data` — database and uploads. |
| `meili_data_volume` | `wanderer_meili` | the search index. |
| `image` / `db_image` / `meilisearch_image` | … | Pin the web and db images to the **same** wanderer version. |
| `resources` / `db_resources` / `meilisearch_resources` | … | Per-task resources. |

> **`pocketbase_url` must be reachable from browsers** (it's baked into the frontend), so for anything beyond localhost
> set it to your real host/domain and port `8090` (and `base_url` to the web URL). All three tasks share the host
> network, so pin the job to the node holding the volumes with `constraints`. The first account you register becomes the
> admin.
