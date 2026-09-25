# kitchenowl

[KitchenOwl](https://kitchenowl.org/) — a smart **grocery list and recipe manager**. Share shopping lists that
update in real time, store recipes and add their ingredients to the list with a tap, plan meals on a calendar, and
track household expenses. Ships native mobile apps plus the web UI, all backed by this single all-in-one container.

Single host-networked Nomad service with a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run kitchenowl --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8080` | Web UI / API port. |
| `jwt_secret_key` | `change-me-…` | **Change this and keep it stable.** Signs session tokens. `openssl rand -base64 36`. |
| `image` | `tombursch/kitchenowl:latest` | Container image. Pin a tag in production. |
| `data_volume` | `kitchenowl_data` | `/data` — SQLite database and uploads. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> The first account you create becomes the admin. Put KitchenOwl behind an authenticating reverse proxy over TLS
> before exposing it, and pin the job to the node holding the volume with `constraints`.
