# spoolman

[Spoolman](https://github.com/Donkie/Spoolman) — a **filament inventory** manager for 3D printing. Track your spools,
filaments and vendors, watch remaining weight as you print, and let your printer report usage automatically through
the REST API — with native integrations for OctoPrint, Klipper/Moonraker and Home Assistant.

Single host-networked Nomad service. Defaults to an embedded SQLite database on a persistent volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run spoolman --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8000` | Web UI / API port (`SPOOLMAN_PORT`). |
| `image` | `ghcr.io/donkie/spoolman:latest` | Container image. Pin a tag in production. |
| `data_volume` | `spoolman_data` | `/home/app/.local/share/spoolman` — the SQLite database. |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> A prestart init task chowns the data volume to uid `1000` (Spoolman runs unprivileged). To use an external
> PostgreSQL/MySQL instead of SQLite, add the `SPOOLMAN_DB_*` env vars to the `spoolman` task. Pin the job to the
> node holding the volume with `constraints`.
