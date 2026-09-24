# linkding

[linkding](https://linkding.link) — a minimal, fast, self-hosted bookmark manager. Organize links
with tags, search full-text, bulk-edit, and archive pages for read-it-later. Ships a bookmarklet and
works with the official browser extensions and a REST API.

Single host-networked Nomad service using **SQLite** with a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run linkding --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `9091` | Web UI port (`LD_SERVER_PORT`). |
| `superuser_name` | `admin` | Initial admin username (`LD_SUPERUSER_NAME`). |
| `superuser_password` | `change-me-please` | Initial admin password (`LD_SUPERUSER_PASSWORD`). **Change it.** |
| `data_volume` | `linkding_data` | `/etc/linkding/data` — SQLite DB and archived snapshots. |
| `image` | `sissbruecker/linkding:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

The admin account is created from the `LD_SUPERUSER_*` env on first boot. For automatic full-page
HTML snapshots, use the `:latest-plus` image (bundles a headless browser). Serves plain HTTP — front
it with a reverse proxy for TLS. Pin the job to the node holding the volume with `constraints`.
