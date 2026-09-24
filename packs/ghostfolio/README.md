# ghostfolio

[Ghostfolio](https://ghostfol.io) — a self-hosted wealth-management and investment-portfolio tracker.
Follow stocks, ETFs, cryptocurrencies, and cash across multiple accounts, with performance analytics,
asset-allocation charts, dividend tracking, and a privacy-first design (no ads, no account linking).

All-in-one host-networked Nomad job: the **Ghostfolio** app plus **PostgreSQL** and **Redis** sidecars.
Database migrations run automatically on boot.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run ghostfolio --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3333` | Web app port (`PORT`). |
| `access_token_salt` | `change-me-…` | `ACCESS_TOKEN_SALT` — hashes access tokens. **Change it** (`openssl rand -hex 16`). |
| `jwt_secret_key` | `change-me-…` | `JWT_SECRET_KEY` — signs JWTs. **Change it** (`openssl rand -hex 32`). |
| `db_password` | `ghostfolio` | PostgreSQL password. |
| `redis_password` | `ghostfolio` | Redis password (`REDIS_PASSWORD`). |
| `db_port` / `redis_port` | `5432` / `6379` | Host ports for the bundled services. |
| `db_data_volume` | `ghostfolio_db_data` | `/var/lib/postgresql/data` — accounts and activities. |
| `image` | `ghostfolio/ghostfolio:latest` | App image. Pin a tag in production. |
| `resources` / `*_resources` | see `variables.hcl` | Per-task resources. |

Open the app, create your account, and start adding holdings. Keep `ACCESS_TOKEN_SALT` and
`JWT_SECRET_KEY` **stable and secret**. Serves plain HTTP — front it with a reverse proxy for TLS. Pin the
job to the node holding the volume with `constraints`.
