# readeck

[Readeck](https://readeck.org) — a lightweight, self-hosted **read-it-later** and bookmark app. Save a link and
Readeck keeps a clean, readable copy of the article — text, images, and your highlights — so it stays available
even if the original disappears. Organize with labels and collections; a modern Pocket alternative.

Single host-networked Nomad service using **SQLite** with a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run readeck --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8000` | Web UI port (`READECK_SERVER_PORT`). |
| `data_volume` | `readeck_data` | `/readeck` — the SQLite database and saved articles. |
| `image` | `codeberg.org/readeck/readeck:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

Create the admin account on first run, then save links via the web UI, the bookmarklet, or a browser extension.
Articles are stored as clean readable copies in the data volume. Serves plain HTTP — front it with a reverse
proxy for TLS. Pin the job to the node holding the volume with `constraints`.
