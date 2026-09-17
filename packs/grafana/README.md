# grafana

Grafana as a host-networked Nomad `service` with a **persistent Docker named
volume** for its SQLite database and plugins.

## Usage

```
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run grafana --registry nomploy --var admin_password=change-me
```

Or in nomploy: **Create → Nomad Pack**, pick `grafana` from the Nomploy registry.

## Variables

| Variable | Default | Description |
|---|---|---|
| `job_name` | `grafana` | Nomad job name |
| `image` | `grafana/grafana:latest` | Container image |
| `port` | `3001` | Host port (avoids the panel's `:3000`) |
| `count` | `1` | Keep at 1 (local SQLite DB) |
| `admin_user` | `admin` | Initial admin user |
| `admin_password` | `admin` | **Change this** |
| `root_url` | `""` | Public URL when fronted by a domain |
| `data_volume` | `grafana_data` | Docker named volume for `/var/lib/grafana` |
| `constraints` | `[]` | Pin placement so the local volume stays put |
| `resources` | `{cpu=500, memory=512}` | Task resources |

## Notes

- **Persistence:** uses a Docker named volume — a fresh one inherits the image's
  `/var/lib/grafana` ownership (uid 472), so Grafana can write it (an alloc bind
  would be root-owned and fail). Pin the job with `constraints` so it lands on the
  node holding the volume.
- Set `root_url` when serving Grafana behind a domain/reverse proxy so its links
  and OAuth redirects are correct.
