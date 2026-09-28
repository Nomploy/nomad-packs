# infisical

[Infisical](https://infisical.com) is an open-source secrets management
platform — a self-hosted alternative to HashiCorp Vault, Doppler or AWS Secrets
Manager. Teams use it to store, organise and sync application secrets and
configs across environments, with secret versioning and rotation, point-in-time
recovery, dynamic secrets, a web UI, CLI, SDKs and Kubernetes/CI integrations.

This pack deploys Infisical **all-in-one** as a single host-networked Nomad job:
**PostgreSQL** and **Redis** (bundled as prestart sidecars) plus the Infisical
app. Database migrations run automatically on start.

## Deploy

```bash
nomad-pack run infisical --registry=nomploy \
  --var db_password=$(openssl rand -hex 16) \
  --var encryption_key=$(openssl rand -hex 16) \
  --var auth_secret=$(openssl rand -base64 32) \
  --var site_url=https://secrets.example.com
```

Open `http://<node-ip>:8080` and create the first admin account.

## Configuration

| Variable         | Default                     | Description                                     |
| ---------------- | --------------------------- | ----------------------------------------------- |
| `image`          | `infisical/infisical:latest`| App image (pin a tag in production).              |
| `postgres_image` | `postgres:14-alpine`        | Bundled PostgreSQL image.                         |
| `redis_image`    | `redis:7-alpine`            | Bundled Redis image.                             |
| `port`           | `8080`                      | Host port for the web UI / API.                  |
| `db_password`    | `infisical_change_me`       | PostgreSQL password — **change this**.            |
| `encryption_key` | placeholder (32 hex)        | Secrets encryption key — **change & keep stable**.|
| `auth_secret`    | placeholder (base64)        | Auth-token secret — **change & keep stable**.     |
| `site_url`       | `http://localhost:8080`     | Public URL of the instance.                       |
| `resources`      | 1000 MHz / 1024 MB          | App task resources.                               |

> **Important:** `encryption_key` and `auth_secret` must remain constant for the
> life of the deployment — changing them makes previously stored secrets
> unreadable.

Data persists in separate volumes for PostgreSQL and Redis.
