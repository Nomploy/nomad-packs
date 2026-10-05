# papra

[Papra](https://papra.app) is a minimalistic self-hosted **document management and
archiving** platform — store, organize, tag and full-text search your documents for the
long term, like a digital archive.

This pack runs Papra as a single host-networked Nomad job with SQLite storage; its
database and your documents live in the `papra_data` volume (`/app/app-data`) — no external
database is required.

## Quick start

```sh
nomad-pack run papra --registry=nomploy
```

Then open `http://<node-ip>:1221` and create the first account.

## Configuration

| Variable | Default | Notes |
|----------|---------|-------|
| `port` | `1221` | Web UI host port |
| `app_base_url` | `http://localhost:1221` | Public URL — set to your domain in production |
| `auth_secret` | *change me* | **Required** session signing secret — keep stable |

Papra requires `auth_secret` to run — change it to a long random value before deploying
anywhere real and keep it stable. Data persists in the `papra_data` named volume.
