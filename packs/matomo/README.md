# matomo

[Matomo](https://matomo.org) — a powerful, privacy-focused web analytics platform and a self-hosted
alternative to Google Analytics: full data ownership, heatmaps, funnels, and reports.

All-in-one host-networked Nomad job: a busybox chown init, a **MariaDB** prestart sidecar (on 3306),
and the **Matomo** app.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run matomo --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `80` | Web UI port (Apache; see note). |
| `db_password` | `matomo` | Database password. |
| `uid` | `33` | User the app runs as (www-data); app volume chown'd to it. |
| `data_volume` | `matomo_data` | `/var/www/html` — app files + config. |
| `db_data_volume` | `matomo_db_data` | MariaDB data — analytics. |
| `resources` / `mariadb_resources` | see defaults | Per-task resources. |

Finish the web installer on first visit (DB fields are pre-filled). See also the privacy-analytics
[plausible](../plausible) and [umami](../umami) packs (lighter). Matomo's Apache binds **80** and the
bundled MariaDB uses **3306** — front with a reverse proxy for another port/domain, and note both
overlap other packs' defaults. Pin the job to the node holding the volumes with `constraints`.
