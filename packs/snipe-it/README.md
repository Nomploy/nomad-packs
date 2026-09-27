# snipe-it

[Snipe-IT](https://snipeitapp.com/) — a free, open-source **IT asset management** system. Track hardware, licenses,
accessories and consumables; check items in and out to users; run audits, reports and alerts. This pack is
**batteries-included**: the app plus a bundled MariaDB in one host-networked group.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run snipe-it --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8000` | Web UI port. |
| `app_key` | `base64:0000…` | **Change this.** `base64:` + a 32-byte base64 value — encrypts data. `echo "base64:$(openssl rand -base64 32)"`. |
| `base_url` | `""` | Public URL (`APP_URL`). Empty = `http://localhost:<port>`. |
| `db_password` | `change-me-…` | **Change this.** Database password. |
| `image` | `snipe/snipe-it:latest` | App image. Pin a tag in production. |
| `mariadb_image` | `mariadb:11` | Bundled database image. |
| `data_volume` / `db_data_volume` | … | App uploads (`/var/lib/snipeit`) and MariaDB data. |
| `db_port` | `3306` | Loopback MariaDB port. |
| `resources` / `db_resources` | … | Per-task resources. |

> **Set `app_key`** (valid `base64:` key) before first boot — it encrypts stored data, so keep it stable. The app runs
> database migrations automatically on start; the first run also walks you through creating the admin user. All tasks
> share the host network, so pin the job to the node holding the volumes with `constraints` and use a reverse proxy over
> TLS.
