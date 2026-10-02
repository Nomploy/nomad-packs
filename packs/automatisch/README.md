# automatisch

[Automatisch](https://automatisch.io) is an open-source **workflow automation** tool — a
Zapier alternative you host yourself. Connect apps and build automations ("flows")
without writing code.

This pack runs Automatisch **all-in-one** as a single host-networked Nomad job:

- **web** — the UI / API (`automatischio/automatisch:latest`)
- **worker** — runs the automation queue (same image, `WORKER=true`)
- **postgres** — bundled database (prestart sidecar)
- **redis** — bundled queue (prestart sidecar)

All tasks share the host network and talk over `127.0.0.1`, so no mesh networking is
required. Database migrations run automatically on the web task's first start.

## Quick start

```sh
nomad-pack run automatisch --registry=nomploy
```

Then open `http://<node-ip>:3000` and create the first account.

## Configuration

| Variable | Default | Notes |
|----------|---------|-------|
| `port` | `3000` | Web UI / API host port |
| `host` | `localhost` | Public hostname (links, webhook URLs) |
| `protocol` | `http` | Public scheme (`http` / `https`) |
| `db_password` | *change me* | Bundled PostgreSQL password |
| `encryption_key` | *change me* | Encrypts stored credentials — keep stable |
| `webhook_secret_key` | *change me* | Signs webhook URLs — keep stable |
| `app_secret_key` | *change me* | Signs sessions/tokens — keep stable |

Change every secret before deploying anywhere real, and keep `encryption_key`,
`webhook_secret_key` and `app_secret_key` stable across deploys — rotating
`encryption_key` makes previously stored connection credentials unreadable.

Set `host`/`protocol` to the public hostname and scheme so the webhook URLs Automatisch
generates for triggers are reachable from the services you connect.

Data persists in the `automatisch_db_data` and `automatisch_storage` named volumes.
