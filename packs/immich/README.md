# immich

[Immich](https://immich.app/) — a high-performance, self-hosted **photo and video backup** solution and a genuine
Google Photos alternative. Automatic mobile backup, timeline and map views, albums and sharing, plus AI-powered
search, face recognition and object detection — all running on your own hardware.

This pack is **batteries-included**: a single host-networked group running four tasks —

- **immich-server** — the web app and API.
- **postgres** — the Immich PostgreSQL build (with the required vector extensions).
- **redis** — Valkey, used as the job queue.
- **machine-learning** — CLIP/face-recognition inference.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run immich --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `2283` | Web UI / API port. |
| `db_password` | `change-me-…` | **Change this.** PostgreSQL password — alphanumeric only. |
| `upload_volume` | `immich_upload` | `/data` — your photo/video library. Grows large; back it up. |
| `image` | `ghcr.io/immich-app/immich-server:release` | Server image. Pin a tag — keep it in sync with the ML image. |
| `machine_learning_image` | `…/immich-machine-learning:release` | ML image. Match its tag to the server. |
| `postgres_image` | `ghcr.io/immich-app/postgres:14-vectorchord…` | **Do not** swap for stock postgres — Immich needs the vector extensions. |
| `redis_image` | `valkey/valkey:8-bookworm` | Job-queue image. |
| `db_data_volume` / `model_cache_volume` / `redis_data_volume` | … | Postgres data, ML model cache, Redis persistence. |
| `db_port` / `redis_port` / `ml_port` | `5432` / `6379` / `3003` | Loopback ports for the bundled services. |
| `resources` | `{ cpu = 1000, memory = 1024 }` | Server task resources. |
| `machine_learning_resources` | `{ cpu = 1000, memory = 1536 }` | ML resources — inference is heavy. |
| `postgres_resources` / `redis_resources` | … | Bundled DB / queue resources. |

> **Version pinning:** pin `image` and `machine_learning_image` to the **same** Immich version in production, and read
> the release notes before upgrading (Immich makes breaking changes). All four tasks share the host network, so they
> run together on one node — pin the job to the node holding the volumes with `constraints`. The first account you
> create becomes the admin. Put Immich behind an authenticating reverse proxy over TLS before exposing it.
