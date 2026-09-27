# listmonk

[listmonk](https://listmonk.app) is a self-hosted, high-performance newsletter
and mailing-list manager — a self-hosted alternative to Mailchimp, Sendgrid
campaigns or Substack. It handles millions of subscribers, multi-threaded
delivery to any SMTP server, list segmentation with SQL queries, templated
HTML campaigns, subscriber import/export and a built-in analytics dashboard.

This pack deploys listmonk **all-in-one** as a single host-networked Nomad job:
**PostgreSQL** (bundled as a prestart sidecar) plus the listmonk app. The
database schema is installed automatically on first start and migrated on each
upgrade.

## Deploy

```bash
nomad-pack run listmonk --registry=nomploy \
  --var db_password=$(openssl rand -hex 16) \
  --var admin_password=$(openssl rand -hex 12)
```

Open `http://<node-ip>:9000` and sign in with the admin user/password you set.

## Configuration

| Variable         | Default                  | Description                                   |
| ---------------- | ------------------------ | --------------------------------------------- |
| `image`          | `listmonk/listmonk:latest` | App image (pin a tag in production).           |
| `postgres_image` | `postgres:17-alpine`     | Bundled PostgreSQL image.                       |
| `port`           | `9000`                   | Host port for the web UI.                       |
| `db_port`        | `5432`                   | Host port for PostgreSQL.                       |
| `db_password`    | `listmonk_change_me`     | PostgreSQL password — **change this**.          |
| `admin_user`     | `admin`                  | Super-admin username created on first start.    |
| `admin_password` | placeholder              | Super-admin password — **change this**.         |
| `resources`      | 500 MHz / 512 MB         | App task resources.                             |

Data persists in separate volumes for PostgreSQL and uploaded media. Configure
your SMTP server under **Settings** to start sending campaigns.
