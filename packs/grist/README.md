# grist

[Grist](https://www.getgrist.com) — a modern relational spreadsheet: the flexibility of a
spreadsheet with the structure of a database, plus Python formulas, dashboards, and
fine-grained access rules.

Single host-networked Nomad service on SQLite with a persistent `/persist` volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run grist --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8484` | Web UI port (`PORT`). |
| `session_secret` | placeholder | `GRIST_SESSION_SECRET` — set a long random value. |
| `default_email` | `""` | `GRIST_DEFAULT_EMAIL` — makes this account the initial owner. |
| `app_home_url` | `""` | `APP_HOME_URL` — public base URL (for a reverse proxy). |
| `data_volume` | `grist_data` | `/persist` — documents + SQLite metadata. |
| `image` | `gristlabs/grist:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. |

Documents live on the `/persist` volume — back it up and pin the job to that node with
`constraints`.
