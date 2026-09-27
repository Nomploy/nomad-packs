# kener

[Kener](https://kener.ing) is a modern, self-hosted status page for monitoring
your services and keeping users informed. It runs its own uptime monitors
(HTTP, TCP, ping, DNS, SSL and more), manages incidents and maintenance
windows, supports subscriptions and webhooks, multiple languages and themes,
and exposes a full API — all behind a genuinely good-looking UI.

This pack deploys Kener **all-in-one** as a single host-networked Nomad job:
**Redis** (bundled as a prestart sidecar, used for the scheduler and caching)
plus the Kener app with its default SQLite database.

## Deploy

```bash
nomad-pack run kener --registry=nomploy \
  --var origin=https://status.example.com \
  --var secret_key=$(openssl rand -base64 32)
```

Open `http://<node-ip>:3000` and create the admin account at `/manage/signin`.

## Configuration

| Variable      | Default                  | Description                                       |
| ------------- | ------------------------ | ------------------------------------------------- |
| `image`       | `rajnandan1/kener:latest`| App image (pin a tag in production).                |
| `redis_image` | `redis:7-alpine`         | Bundled Redis image.                                |
| `port`        | `3000`                   | Host port for the web UI.                           |
| `redis_port`  | `6379`                   | Host port for Redis.                                |
| `origin`      | `http://localhost:3000`  | **Public URL** of the instance (CSRF protection).   |
| `secret_key`  | placeholder              | Session signing key — **change this**.              |
| `data_volume` | `kener_data`             | Volume for the SQLite database (`/app/database`).   |
| `resources`   | 500 MHz / 512 MB         | App task resources.                                 |

By default Kener uses SQLite; point `DATABASE_URL` at PostgreSQL or MySQL via a
custom env if you prefer. Data persists in separate volumes for Kener and Redis.
