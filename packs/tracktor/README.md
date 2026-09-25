# tracktor

[Tracktor](https://github.com/javedh-dev/tracktor) — a self-hosted **vehicle maintenance and expense tracker**. Log
fuel fill-ups and watch mileage/economy, record services and repairs, track insurance and registration with expiry
reminders, and see it all per vehicle on a clean dashboard.

Single host-networked Nomad service with a persistent SQLite volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run tracktor --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3000` | Web UI port. |
| `image` | `ghcr.io/javedh-dev/tracktor:latest` | Container image. Pin a tag in production. |
| `data_volume` | `tracktor_data` | `/data` — the SQLite database. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> The first account you create becomes the admin. Put Tracktor behind an authenticating reverse proxy over TLS before
> exposing it, and pin the job to the node holding the volume with `constraints`.
