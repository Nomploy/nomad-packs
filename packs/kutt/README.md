# kutt

[Kutt](https://kutt.it) is a modern, open-source URL shortener. It supports
custom domains, custom short URLs, link expiration and passwords, per-link
click stats, a REST API, browser extensions and a clean web UI — a self-hosted
alternative to Bitly.

This pack runs Kutt as a single host-networked Nomad service using SQLite, so
there's no separate database or Redis to run.

## Deploy

```bash
nomad-pack run kutt --registry=nomploy \
  --var default_domain=links.example.com \
  --var jwt_secret=$(openssl rand -hex 24)
```

Open `http://<node-ip>:3000` and register the first account.

## Configuration

| Variable         | Default              | Description                                   |
| ---------------- | -------------------- | --------------------------------------------- |
| `image`          | `kutt/kutt:latest`   | Container image (pin a tag in production).        |
| `port`           | `3000`               | Host port for the web UI.                      |
| `default_domain` | `localhost:3000`     | Domain used for generated short links.         |
| `site_name`      | `Kutt`               | Display name of the instance.                  |
| `jwt_secret`     | placeholder          | Auth-token secret — **change this**.           |
| `data_volume`    | `kutt_data`          | Volume for the SQLite database (`/var/lib/kutt`).|
| `resources`      | 300 MHz / 256 MB     | CPU and memory for the task.                    |

The database persists in `data_volume`. To send verification/reset emails or
scale out, enable the `MAIL_*` and `REDIS_*` settings from the Kutt docs.
