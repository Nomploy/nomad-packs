# kimai

[Kimai](https://www.kimai.org) — a professional self-hosted time-tracking app: track time per
customer/project/activity, manage teams and rates, and export invoices and reports.

All-in-one host-networked Nomad job: a busybox chown init, a **MariaDB** prestart sidecar, and the
**Kimai** (Apache) app.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run kimai --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8001` | Web UI port. |
| `db_port` | `3306` | Co-located MariaDB port. |
| `db_password` | `kimai` | Database password. |
| `admin_email` / `admin_password` | admin defaults | Initial super-admin. **Change the password.** |
| `trusted_hosts` | `localhost,127.0.0.1` | Hosts Kimai answers for — **add your node IP/domain**. |
| `uid` | `33` | User the app runs as (www-data); data volume chown'd to it. |
| `data_volume` / `db_data_volume` | named volumes | Uploads/invoices / MariaDB data. |
| `resources` / `mariadb_resources` | see defaults | Per-task resources. |

> **Set `trusted_hosts`** to the host/IP or domain you access Kimai on, or it returns an "Invalid
> host" error. Pin the job to the node holding the volumes with `constraints`.
