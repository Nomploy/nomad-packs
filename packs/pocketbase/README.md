# pocketbase

[PocketBase](https://pocketbase.io) — an open-source **backend in a single file**: an
embedded SQLite database with realtime subscriptions, built-in authentication, file storage,
and an admin dashboard, all behind a simple REST-ish API. A lightweight Firebase/BaaS
alternative for small apps and prototypes. Host-networked Nomad service with a persistent
volume.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run pocketbase --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `pocketbase`, custom
registry `github.com/Nomploy/nomad-packs`, then Deploy.

Open `http://<node-ip>:8090/_/` and create the superuser account on first visit.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `ghcr.io/muchobien/pocketbase:latest` | **Community** image (no official one). Pin a tag in production. |
| `port` | `8090` | Admin UI (`/_/`) + API (`/api/`). |
| `data_volume` | `pocketbase_data` | SQLite DB + uploaded files. Back it up. |
| `constraints` | `[]` | Pin to a node so the local volume stays put. |
| `resources` | `cpu 300 / mem 256` | Lightweight. |

## Notes

- **Single node.** `count` is fixed to 1 (SQLite on a local volume). Pin with `constraints`.
- **Community image:** PocketBase publishes only binaries, not a Docker image; this uses the
  widely-used `muchobien/pocketbase` build. Review/pin it for production.
- Serves plain HTTP — front with a reverse proxy for TLS.
- **Backups:** snapshot the `data_volume` (or use PocketBase's built-in backups in Settings).
