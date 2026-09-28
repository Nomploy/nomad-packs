# twenty

[Twenty](https://twenty.com) is a modern, open-source CRM — a self-hosted
alternative to Salesforce and HubSpot. It offers fully customizable objects and
fields, table and kanban views, rich filtering, a keyboard-driven UI, timeline
and notes, email/calendar sync and a GraphQL/REST API, all under an open license.

This pack deploys Twenty **all-in-one** as a single host-networked Nomad job:

- **PostgreSQL** and **Redis** — bundled as prestart sidecars
- **server** — the API and web UI (runs DB migrations on start)
- **worker** — background job processor

All four share one allocation and talk over `127.0.0.1`.

## Deploy

```bash
nomad-pack run twenty --registry=nomploy \
  --var db_password=$(openssl rand -hex 16) \
  --var app_secret=$(openssl rand -base64 32) \
  --var server_url=https://crm.example.com
```

Open `http://<node-ip>:3000` and create the first workspace.

## Configuration

| Variable         | Default                  | Description                                    |
| ---------------- | ------------------------ | ---------------------------------------------- |
| `image`          | `twentycrm/twenty:latest`| Server + worker image (pin a tag in production). |
| `postgres_image` | `postgres:16`            | Bundled PostgreSQL image.                        |
| `redis_image`    | `redis:7-alpine`         | Bundled Redis image.                             |
| `port`           | `3000`                   | Host port for the web UI / API.                  |
| `db_password`    | `twenty_change_me`       | PostgreSQL password — **change this**.            |
| `app_secret`     | placeholder              | Token-signing secret — **change & keep stable**.  |
| `server_url`     | `http://localhost:3000`  | Public URL of the instance.                       |
| `resources`      | 1000 MHz / 2048 MB       | Server task resources.                            |
| `worker_resources`| 500 MHz / 1024 MB       | Worker task resources.                            |

Data persists in separate volumes for PostgreSQL and local file storage (shared
by server and worker).
