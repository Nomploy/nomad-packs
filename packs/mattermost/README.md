# mattermost

[Mattermost](https://mattermost.com) — a self-hosted team chat and collaboration platform (a Slack
alternative) with channels, threads, file sharing, and integrations. This pack runs the Team
Edition (free, open source).

All-in-one host-networked Nomad job: a busybox chown init, a **PostgreSQL** prestart sidecar, and
the **Mattermost** server. Messages live in Postgres; uploads/config/plugins on their own volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run mattermost --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8065` | Web UI / API port. |
| `db_port` | `5432` | Co-located PostgreSQL port. |
| `db_password` | `mattermost` | Password for the Mattermost Postgres user. |
| `site_url` | `""` | `MM_SERVICESETTINGS_SITEURL`; empty = `http://localhost:<port>`. See note. |
| `uid` | `2000` | User Mattermost runs as; mounted dirs are chown'd to it. |
| `config_volume` / `data_volume` / `plugins_volume` / `client_plugins_volume` | named volumes | Config, uploads, plugins. |
| `db_data_volume` | `mattermost_db_data` | PostgreSQL data — all messages. |
| `resources` / `postgres_resources` | see defaults | Per-task resources. |

> Set `site_url` to this node's host/IP or your domain — Mattermost needs a correct Site URL for
> uploads, integrations, and mobile clients. The first account created becomes the System Admin.

Pin the job to the node holding the volumes with `constraints`.
