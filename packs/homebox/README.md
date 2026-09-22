# homebox

[HomeBox](https://homebox.software) — a simple, fast home inventory and organization system:
track belongings, locations, labels, warranties, and attachments, with QR labels and CSV import.

Single host-networked Nomad service on SQLite with a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run homebox --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `7745` | Web UI port (`HBOX_WEB_PORT`). |
| `allow_registration` | `true` | Allow user self-registration. |
| `data_volume` | `homebox_data` | `/data` — SQLite database + uploads. |
| `image` | `ghcr.io/sysadminsmedia/homebox:latest` | Image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 128 }` | Task resources. |

Register the first account on first visit. Consider turning `allow_registration` off afterwards.
Pin the job to the node holding the volume with `constraints`.
