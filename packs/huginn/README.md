# huginn

[Huginn](https://github.com/huginn/huginn) is a system for building agents that
perform automated tasks online — a self-hosted alternative to IFTTT or Zapier.
Agents can watch websites for changes, scrape and transform data, poll APIs and
RSS feeds, run schedules, and chain together to send emails, push notifications
or trigger webhooks. Everything runs on your own server, keeping your data
private.

This pack runs the Huginn **all-in-one** image (application plus a bundled MySQL
and background workers) as a single host-networked Nomad service.

## Deploy

```bash
nomad-pack run huginn --registry=nomploy \
  --var admin_password=$(openssl rand -hex 12) \
  --var app_secret_token=$(openssl rand -hex 64) \
  --var domain=huginn.example.com
```

Open `http://<node-ip>:3000` and log in.

## Configuration

| Variable           | Default                       | Description                                  |
| ------------------ | ----------------------------- | -------------------------------------------- |
| `image`            | `ghcr.io/huginn/huginn:latest`| All-in-one image (pin a tag in production).     |
| `port`             | `3000`                        | Host port for the web UI.                     |
| `admin_user`       | `admin`                       | Seeded admin username.                        |
| `admin_password`   | `huginn_change_me`            | Seeded admin password — **change this**.      |
| `app_secret_token` | placeholder (128 hex)         | Cookie-signing secret — **change this**.      |
| `domain`           | `localhost:3000`              | Domain used in generated links.               |
| `data_volume`      | `huginn_data`                 | Volume for the bundled MySQL (`/var/lib/mysql`).|
| `resources`        | 1000 MHz / 1536 MB            | CPU and memory for the task.                   |

The bundled MySQL data persists in `data_volume`. For larger deployments, use the
`huginn/huginn-single-process` image with an external database instead.
