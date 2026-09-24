# donetick

[Donetick](https://donetick.com) — an open-source, self-hosted app for managing **tasks and chores**.
Recurring schedules, assignments, shared "circles" for a household or team, priorities, and notifications —
a friendly way to keep everyone on top of who does what.

Single host-networked Nomad service using **SQLite** with persistent data and config volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run donetick --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `2021` | Web UI / API port (`DT_SERVER_PORT`). The container listens on 2021. |
| `jwt_secret` | `change-me-…` | Auth-token secret (`DT_JWT_SECRET`). **Change it** (`openssl rand -hex 32`). |
| `data_volume` | `donetick_data` | `/donetick-data` — the SQLite database. |
| `config_volume` | `donetick_config` | `/config`. |
| `image` | `donetick/donetick:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

Create your account on first visit, add tasks/chores with recurring schedules, and invite others to a shared
circle. Keep `DT_JWT_SECRET` stable and secret. Configure Telegram/webhook notifications in settings or via
the `/config` file. Serves plain HTTP — front it with a reverse proxy for TLS. Pin the job to the node
holding the volumes with `constraints`.
