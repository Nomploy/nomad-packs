# shiori

[Shiori](https://github.com/go-shiori/shiori) — a simple, fast bookmark manager written in Go: save,
tag, search, and archive pages for offline reading, with a clean web UI and a CLI.

Single host-networked Nomad service on SQLite with a data volume. A busybox prestart task chowns the
data volume to Shiori's UID (the image is distroless/nonroot).

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run shiori --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8105` | Web UI port. |
| `secret_key` | placeholder | `SHIORI_HTTP_SECRET_KEY` — set a long random value. |
| `uid` | `65532` | User Shiori runs as; data volume is chown'd to it. |
| `data_volume` | `shiori_data` | `/shiori` — SQLite database + archives. |
| `image` | `ghcr.io/go-shiori/shiori:latest` | Image. Pin a tag in production. |
| `resources` | `{ cpu = 200, memory = 128 }` | Task resources. |

Default login is `shiori` / `gopher` — **change it immediately**. See also the
[linkwarden](../linkwarden) pack (heavier, with full-page archiving). Pin the job to the node holding
the volume with `constraints`.
