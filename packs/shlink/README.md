# shlink

[Shlink](https://shlink.io) — a self-hosted URL shortener with real analytics. Create short links with
custom slugs, tags, and multiple domains; track visits with geolocation and referrers; generate QR codes;
and drive it all through a full REST API or the separate web client. A privacy-friendly Bitly alternative.

All-in-one host-networked Nomad job: the **Shlink** app plus a **PostgreSQL** sidecar. Migrations run
automatically on boot.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run shlink --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8080` | API / redirect port. The container listens on 8080. |
| `default_domain` | `localhost` | `DEFAULT_DOMAIN` — the domain your short URLs use. **Set to your real domain.** |
| `is_https_enabled` | `false` | `IS_HTTPS_ENABLED` — set true behind a TLS reverse proxy. |
| `initial_api_key` | `change-me-…` | `INITIAL_API_KEY` created on first boot. **Change it.** |
| `db_password` | `shlink` | PostgreSQL password. |
| `db_port` | `5432` | Host port for the bundled PostgreSQL. |
| `db_data_volume` | `shlink_db_data` | `/var/lib/postgresql/data` — all short URLs and visits. |
| `image` | `shlinkio/shlink:stable` | App image. Pin a tag in production. |
| `resources` / `postgres_resources` | see `variables.hcl` | Per-task resources. |

`DEFAULT_DOMAIN` is stored on every short URL, so set it correctly before creating links. Manage links
with the `initial_api_key` via the CLI or the standalone `shlink-web-client`. Point your short-link domain
at this service and front it with a reverse proxy for TLS. Pin the job to the node holding the volume with
`constraints`.
