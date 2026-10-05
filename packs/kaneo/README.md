# kaneo

[Kaneo](https://kaneo.app) is an open-source **project management platform** — boards,
tasks, time tracking and team collaboration, kept deliberately simple.

This pack runs Kaneo **all-in-one** as a single host-networked Nomad job:

- **kaneo** — the app, which serves both the API and the web UI (`ghcr.io/usekaneo/kaneo:latest`)
- **postgres** — bundled database (prestart sidecar)

Both share the host network and talk over `127.0.0.1`, so no mesh networking is required.
Database migrations run automatically on first start.

## Quick start

```sh
nomad-pack run kaneo --registry=nomploy
```

Then open `http://<node-ip>:5173` and create the first account.

## Configuration

| Variable | Default | Notes |
|----------|---------|-------|
| `port` | `5173` | Web UI / API host port |
| `client_url` | `http://localhost:5173` | Public URL — set to your domain in production |
| `db_password` | *change me* | Bundled PostgreSQL password |
| `auth_secret` | `0000…` | Session signing key (`openssl rand -hex 32`) — keep stable |

Change `db_password` and `auth_secret` before deploying anywhere real, and keep
`auth_secret` stable across deploys (rotating it signs everyone out). The app derives its
database connection from the `POSTGRES_*` settings, so no separate `DATABASE_URL` is
needed.

Data persists in the `kaneo_db_data` named volume.
