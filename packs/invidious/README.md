# invidious

[Invidious](https://invidious.io) is an open-source, privacy-respecting
alternative front-end for YouTube. Watch and search videos, subscribe to
channels and build playlists without ads, tracking, or Google's JavaScript —
with lightweight pages, audio-only mode, and RSS feeds for channels.

This pack deploys Invidious **all-in-one** as a single host-networked Nomad job:
**PostgreSQL** (bundled as a prestart sidecar) plus the Invidious app. The
database schema is created automatically on first start.

## Deploy

```bash
nomad-pack run invidious --registry=nomploy \
  --var db_password=$(openssl rand -hex 16) \
  --var hmac_key=$(openssl rand -hex 16)
```

Open `http://<node-ip>:3000`.

## Configuration

| Variable         | Default                             | Description                                |
| ---------------- | ----------------------------------- | ------------------------------------------ |
| `image`          | `quay.io/invidious/invidious:latest`| App image (pin a tag in production).          |
| `postgres_image` | `postgres:14-alpine`                | Bundled PostgreSQL image.                    |
| `port`           | `3000`                              | Host port for the web UI.                    |
| `db_password`    | `invidious_change_me`               | PostgreSQL password — **change this**.        |
| `hmac_key`       | placeholder                         | Token-signing key — **change this**.          |
| `resources`      | 1000 MHz / 1024 MB                  | App task resources.                          |

> **Heads up:** YouTube actively rate-limits/blocks datacenter IPs. A fresh
> instance works, but keeping a public instance reliable may require additional
> configuration (`po_token`, `visitor_data`, or outbound proxies) — see the
> Invidious docs.

PostgreSQL data persists in `db_data_volume`.
