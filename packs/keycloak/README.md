# keycloak

[Keycloak](https://www.keycloak.org) — open-source identity and access management: SSO,
OpenID Connect, SAML, social login, and user federation. Put it in front of the services
you host so they share one login.

This pack is **all-in-one**: Keycloak plus its required **PostgreSQL** in a single
host-networked Nomad job. Postgres starts first (prestart sidecar); Keycloak reaches it
on `127.0.0.1` and runs its schema migrations automatically on start.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run keycloak --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `keycloak`, custom
registry `github.com/Nomploy/nomad-packs`, then Deploy.

Open `http://<node-ip>:8080/admin` and log in as `admin` / `admin` (change it). **First
boot is slow** — Keycloak builds its config and migrates the database before serving.

## Fronting with a domain / TLS

Keycloak serves **plain HTTP** here; terminate TLS at a reverse proxy (Traefik). Proxy
headers are enabled (`KC_PROXY_HEADERS=xforwarded`). When you put it behind a real domain,
set `hostname` (e.g. `https://auth.example.com`) — that turns `hostname-strict` on so
Keycloak pins its issuer/redirect URLs to that domain.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `quay.io/keycloak/keycloak:latest` | Pin a 26.x tag in production. |
| `port` | `8080` | Keycloak HTTP port. |
| `hostname` | `""` | Public URL when fronted by a domain; empty = infer from request (IP/testing). |
| `admin_user` / `admin_password` | `admin` / `admin` | Bootstrap admin, **first boot only**. Change the password. |
| `db_password` | `keycloak` | Postgres password. **Change this.** |
| `db_data_volume` | `keycloak_db_data` | Realms/users/clients live here — back it up. |
| `db_port` | `5432` | Bundled Postgres host port. |
| `constraints` | `[]` | Pin to a node so the DB volume stays put. |

Per-task resources: `keycloak_resources` (JVM — default cpu 1000 / mem 1024),
`postgres_resources`.

## Notes

- **Single node.** `count` is fixed to 1 (local Postgres volume). Pin with `constraints`.
  For HA/clustered Keycloak, run it against an external Postgres and multiple replicas.
- The **bootstrap admin** is created only on first start with an empty DB. To rotate it
  later, use the admin console; changing the variable afterwards has no effect.
- **Backups:** snapshot the `db_data_volume` (or `pg_dump` the `keycloak` database).
