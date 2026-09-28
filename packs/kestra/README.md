# kestra

[Kestra](https://kestra.io) is an open-source, event-driven **orchestration
platform** for data pipelines, scheduled jobs and general automation — an
alternative to Airflow, Temporal or Prefect. Flows are declared in YAML (with a
visual editor), triggered by schedules, events or webhooks, and run against 600+
plugins (databases, cloud, HTTP, shell, Docker and more), all observable from a
rich web UI.

This pack deploys Kestra **all-in-one** as a single host-networked Nomad job:
**PostgreSQL** (bundled as a prestart sidecar, backing Kestra's repository and
queue) plus the Kestra `server standalone` process. Schema is created
automatically on start.

## Deploy

```bash
nomad-pack run kestra --registry=nomploy \
  --var db_password=$(openssl rand -hex 16)
```

Open `http://<node-ip>:8080` and build your first flow.

## Configuration

| Variable         | Default                | Description                                        |
| ---------------- | ---------------------- | -------------------------------------------------- |
| `image`          | `kestra/kestra:latest` | App image (pin a tag in production).                 |
| `postgres_image` | `postgres:16-alpine`   | Bundled PostgreSQL image.                            |
| `port`           | `8080`                 | Host port for the web UI / API.                     |
| `db_port`        | `5432`                 | Host port for PostgreSQL.                            |
| `db_password`    | `kestra_change_me`     | PostgreSQL password — **change this**.               |
| `storage_volume` | `kestra_storage`       | Volume for internal storage (`/app/storage`).        |
| `docker_sock`    | `/var/run/docker.sock` | Docker socket for the Docker task runner; `""` off.  |
| `resources`      | 1000 MHz / 2048 MB     | Server task resources.                               |

> **Note:** The Docker socket lets Kestra run task containers directly on the
> host — grant it only on nodes you trust, or set `docker_sock=""` (script and
> process tasks still work).

Data persists in separate volumes for PostgreSQL and Kestra's internal storage.
