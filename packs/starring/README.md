# Starring

[Starring](https://github.com/pipozzz/starring) deployed as an all-in-one,
host-networked Nomad job: the Starring app plus a bundled **PostgreSQL 17** with a
persistent volume. The app task is gated on the database accepting connections
(a `prestart` wait task), so the first migration doesn't race a cold database.

## Variables

| Variable | Default | Description |
|---|---|---|
| `image` | `ghcr.io/pipozzz/starring:latest` | App image (pin a version in production). |
| `postgres_image` | `postgres:17-alpine` | Bundled PostgreSQL image (when `bundled_db`). |
| `bundled_db` | `true` | Run a bundled PostgreSQL. Set `false` to use an external / managed DB via `database_url`. |
| `database_url` | `""` | External PostgreSQL connection string (when `bundled_db = false`). |
| `port` | `4321` | Host port for the web app. |
| `db_port` | `5432` | Host port for the co-located PostgreSQL. |
| `db_password` | `starring` | **Change this.** PostgreSQL password. |
| `better_auth_url` | `""` | Public URL (BETTER_AUTH_URL). Empty → `http://localhost:<port>`. Set to your real domain. |
| `better_auth_secret` | `change-me-…` | **Change this, keep it stable.** Signs auth sessions. `openssl rand -hex 32`. |
| `site_url` | `""` | Optional SITE_URL. |
| `allow_signup` | `false` | Open sign-ups. |
| `password_auth` | `true` | Email/password auth (create the first user). |
| `db_data_volume` | `starring_db_data` | Named volume for PostgreSQL data — back it up. |
| `constraints` | `[]` | Pin to the node holding the volume (see below). |
| `resources` / `postgres_resources` | — | Per-task CPU/memory. |

## Persistence & placement

All data lives in the `db_data_volume` docker named volume, which is **node-local**.
Pin the job to the node that holds it so a reschedule always finds the data. On a
nomploy cluster:

```hcl
constraints = [{
  attribute = "${meta.nomploy_control_plane}"
  operator  = "="
  value     = "true"
}]
```

Serves plain HTTP — front it with Traefik / a reverse proxy for TLS, and set
`better_auth_url` to that public HTTPS URL.

## Example

```hcl
nomad-pack run starring \
  --var better_auth_url=https://app.example.com \
  --var better_auth_secret=$(openssl rand -hex 32) \
  --var db_password=$(openssl rand -hex 16)
```
