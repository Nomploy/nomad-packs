# authentik

[authentik](https://goauthentik.io) — an open-source **Identity Provider / SSO**: OAuth2 &
OpenID Connect, SAML, LDAP, proxy/forward-auth, MFA, and customizable login flows. Put it in
front of your apps for single sign-on. **All-in-one**: authentik's **server** and **worker**
plus **PostgreSQL** and **Redis**, in one host-networked Nomad job.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs \
  --var secret_key=$(openssl rand -base64 50) --var bootstrap_password=<secret>
nomad-pack run authentik --registry nomploy \
  --var secret_key=$(openssl rand -base64 50) --var bootstrap_password=<secret>
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `authentik`, set `secret_key`
(and `bootstrap_password`), then Deploy. Open `http://<node-ip>:9000`; if you didn't set a
bootstrap password, complete `/if/flow/initial-setup/`.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `ghcr.io/goauthentik/server:latest` | Pin a tag in production. |
| `port` | `9000` | Web UI / API (HTTP). |
| `secret_key` | placeholder | **Change it** (`openssl rand -base64 50`); keep it stable. |
| `bootstrap_password` / `bootstrap_email` | `""` / `admin@example.com` | Optional first-boot akadmin. |
| `db_password` | `authentik` | Postgres password. **Change this.** |
| `db_data_volume` | `authentik_db_data` | Users/apps/flows. Back it up. |
| `db_port` / `redis_port` | `5432` / `6379` | Bundled dependency ports. |
| `constraints` | `[]` | Pin to a node so the DB volume stays put. |

Per-task resources: `server_resources`, `worker_resources`, `postgres_resources`.

## Notes

- **Single node.** `count` is fixed to 1 (local Postgres volume). Pin with `constraints`.
- **Redis is ephemeral** (cache/queues) — fine to lose on restart.
- Serves plain **HTTP** — front with a reverse proxy for TLS (authentik strongly expects to
  run behind HTTPS for real use).
- Uploaded media (icons/backgrounds) isn't persisted in this minimal setup; add a shared
  `/media` volume if you need it.
