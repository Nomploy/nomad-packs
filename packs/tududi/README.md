# tududi

[Tududi](https://tududi.com) is a self-hosted task and project management app. It
organises work into **areas → projects → tasks**, with notes, tags, recurring
tasks, due dates, a today/calendar view and multi-user sharing — a clean,
keyboard-friendly alternative to Todoist or Things that runs on your own server.

This pack runs Tududi as a single host-networked Nomad service backed by SQLite.

## Deploy

```bash
nomad-pack run tududi --registry=nomploy \
  --var admin_email=you@example.com \
  --var admin_password=$(openssl rand -hex 12) \
  --var session_secret=$(openssl rand -hex 64) \
  --var allowed_origins=https://tasks.example.com
```

Open `http://<node-ip>:3002` and sign in with your admin email/password.

## Configuration

| Variable          | Default                  | Description                                     |
| ----------------- | ------------------------ | ----------------------------------------------- |
| `image`           | `chrisvel/tududi:latest` | Container image (pin a tag in production).         |
| `port`            | `3002`                   | Host port for the web UI.                        |
| `admin_email`     | `admin@example.com`      | Seeded admin email.                              |
| `admin_password`  | `tududi_change_me`       | Seeded admin password — **change this**.         |
| `session_secret`  | placeholder              | Session signing secret — **change this**.        |
| `allowed_origins` | `http://localhost:3002`  | **Public URL(s)** allowed to call the API.        |
| `trust_proxy`     | `true`                   | Trust `X-Forwarded-*` (behind Traefik).          |
| `db_volume`       | `tududi_db`              | Volume for the SQLite database (`/app/db`).       |
| `resources`       | 300 MHz / 384 MB         | CPU and memory for the task.                      |

A prestart init task makes the volumes writable by the app user. The database,
uploads and backups persist across restarts. Set `allowed_origins` to the exact
URL you serve Tududi from, or the browser's requests will be rejected.
