# adminer

[Adminer](https://www.adminer.org) — a full-featured database management tool in a single
PHP file. Manage PostgreSQL, MySQL/MariaDB, SQLite, and more from a web UI. A handy
companion to the `postgres` and `mariadb` packs. **Stateless** — no volume.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run adminer --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `adminer`, custom registry
`github.com/Nomploy/nomad-packs`, then Deploy.

Open `http://<node-ip>:8083`, pick the database system, and enter the server host:port and
credentials.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `adminer:latest` | Pin a tag in production. |
| `port` | `8083` | Web UI host port (off 8080 to dodge clashes). |
| `default_server` | `""` | Pre-fill the login server, e.g. `127.0.0.1:5432`. |
| `design` | `""` | Adminer theme (e.g. `dracula`, `nette`). |
| `count` | `1` | Stateless, so >1 is fine on distinct ports/nodes. |
| `resources` | `cpu 200 / mem 128` | Tiny. |

## Notes

- **Security:** Adminer exposes database login to anyone who can reach the port. Don't
  expose it publicly without auth — keep it internal or front it with an authenticating
  reverse proxy.
- Connect to the `postgres` pack at `127.0.0.1:5432` (same node) and `mariadb` at
  `:3306`.
