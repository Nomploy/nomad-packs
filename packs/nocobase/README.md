# nocobase

[NocoBase](https://www.nocobase.com) is an open-source no-code/low-code platform
for building internal tools, business applications and admin panels. Unlike
spreadsheet-style tools, it's **data-model-driven** and plugin-based: define
collections, then compose blocks (tables, forms, kanban, calendars, charts) with
fine-grained roles and permissions, on top of your own PostgreSQL.

This pack deploys NocoBase **all-in-one** as a single host-networked Nomad job:
**PostgreSQL** (bundled as a prestart sidecar) plus the NocoBase app. Built-in
plugins are installed automatically on first start.

## Deploy

```bash
nomad-pack run nocobase --registry=nomploy \
  --var db_password=$(openssl rand -hex 16) \
  --var app_key=$(openssl rand -hex 32)
```

Open `http://<node-ip>:13000` (first boot takes a minute to install plugins) and
sign in with `admin@nocobase.com` / `admin`, then change the password.

## Configuration

| Variable         | Default                   | Description                                      |
| ---------------- | ------------------------- | ------------------------------------------------ |
| `image`          | `nocobase/nocobase:latest`| App image (pin a tag in production).               |
| `postgres_image` | `postgres:16-alpine`      | Bundled PostgreSQL image.                          |
| `port`           | `13000`                   | Host port for the web UI.                         |
| `db_password`    | `nocobase_change_me`      | PostgreSQL password — **change this**.             |
| `app_key`        | placeholder               | Token/crypto secret — **change & keep stable**.    |
| `storage_volume` | `nocobase_storage`        | Volume for uploads (`/app/nocobase/storage`).      |
| `resources`      | 1000 MHz / 1024 MB        | App task resources.                               |

PostgreSQL data persists in `db_data_volume`; uploaded files in `storage_volume`.
