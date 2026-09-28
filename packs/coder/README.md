# coder

[Coder](https://coder.com) provisions **self-hosted cloud development
environments** on your own infrastructure. Developers get on-demand remote
workspaces — VS Code (desktop or web), JetBrains, or a browser terminal — defined
as code with Terraform templates, so environments are consistent, disposable and
kept close to your data.

This pack deploys Coder **all-in-one** as a single host-networked Nomad job:
**PostgreSQL** (bundled as a prestart sidecar) plus the Coder server. The Docker
socket is mounted so the built-in Docker template can create workspaces on the
node.

## Deploy

```bash
nomad-pack run coder --registry=nomploy \
  --var db_password=$(openssl rand -hex 16) \
  --var access_url=http://10.0.0.5:7080
```

Open `http://<node-ip>:7080` and create the first admin account.

## Configuration

| Variable         | Default                     | Description                                       |
| ---------------- | --------------------------- | ------------------------------------------------- |
| `image`          | `ghcr.io/coder/coder:latest`| Server image (pin a tag in production).             |
| `postgres_image` | `postgres:17-alpine`        | Bundled PostgreSQL image.                           |
| `port`           | `7080`                      | Host port for the web UI / API.                    |
| `db_password`    | `coder_change_me`           | PostgreSQL password — **change this**.              |
| `access_url`     | `http://localhost:7080`     | Public URL clients use (set to the node address).   |
| `docker_sock`    | `/var/run/docker.sock`      | Docker socket for workspace templates; `""` to disable.|
| `resources`      | 1000 MHz / 1024 MB          | Server task resources.                              |

> **Note:** The Docker socket lets Coder create workspace containers on the host —
> grant it only on nodes you trust. Set `access_url` to a reachable address so the
> CLI and workspaces can connect (otherwise a temporary tunnel is created).

Data persists in separate volumes for PostgreSQL and the Coder home directory.
