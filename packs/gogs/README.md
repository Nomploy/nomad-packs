# gogs

[Gogs](https://gogs.io) is a painless, self-hosted Git service designed to be
lightweight — it runs as a single binary with a tiny memory footprint and uses
SQLite by default, so it's happy on the smallest hardware. It offers
repositories, issues, pull requests, wikis, webhooks, and a clean web UI.

This pack runs Gogs as a single host-networked Nomad service.

## Deploy

```bash
nomad-pack run gogs --registry=nomploy
```

Open `http://<node-ip>:3000` and complete the one-time install form (the SQLite
defaults work as-is), then create the admin account.

## Configuration

| Variable      | Default           | Description                                       |
| ------------- | ----------------- | ------------------------------------------------- |
| `image`       | `gogs/gogs:latest`| Container image (pin a tag in production).            |
| `http_port`   | `3000`            | Host port for the web UI.                          |
| `ssh_port`    | `2222`            | Git-over-SSH port (kept off 22 / the host sshd).   |
| `data_volume` | `gogs_data`       | Volume for repos, SQLite DB and config (`/data`).  |
| `resources`   | 300 MHz / 256 MB  | CPU and memory for the task.                        |

Everything (repositories, database, config) persists in `data_volume`. For
larger instances you can point Gogs at an external MySQL/PostgreSQL during the
install step instead of SQLite.
