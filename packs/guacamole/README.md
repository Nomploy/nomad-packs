# guacamole

[Apache Guacamole](https://guacamole.apache.org/) — a **clientless remote-desktop gateway**. Access RDP, VNC and SSH
machines straight from your browser — no plugins or client software. This pack uses an **all-in-one** image that bundles
the Guacamole web app, the `guacd` proxy daemon and PostgreSQL, so it runs as a single container.

Single host-networked Nomad service with one persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run guacamole --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8080` | Web UI port. Fixed at `8080` inside the image. |
| `image` | `flcontainers/guacamole:latest` | All-in-one container image. Pin a tag in production. |
| `data_volume` | `guacamole_data` | `/config` — the bundled PostgreSQL database and config. |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> **First login:** `guacadmin` / `guacadmin` — change it immediately. Then add your RDP/VNC/SSH connections in the
> admin settings. Because Postgres lives in the data volume, pin the job to the node holding it with `constraints`, and
> put Guacamole behind an authenticating reverse proxy over TLS before exposing it.
