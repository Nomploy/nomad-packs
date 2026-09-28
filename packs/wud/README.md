# wud

[WUD (What's Up Docker)](https://getwud.github.io/wud/) keeps an eye on your
running Docker containers and tells you when a **newer image is available**. It
inspects tags and manifests across Docker Hub, GHCR, ECR, GCR/GAR, ACR, Quay,
GitLab, Gitea/Forgejo and any OCI registry, shows everything in a clean web UI,
and can fire 30+ triggers (Discord, Slack, MQTT, email, webhooks…) or even
auto-update containers.

This pack runs WUD as a single host-networked Nomad service.

## Deploy

```bash
nomad-pack run wud --registry=nomploy \
  --var admin_password=$(openssl rand -hex 12)
```

Open `http://<node-ip>:3000` and log in.

## Configuration

| Variable         | Default                | Description                                        |
| ---------------- | ---------------------- | -------------------------------------------------- |
| `image`          | `getwud/wud:latest`    | Container image (pin a tag in production).            |
| `port`           | `3000`                 | Host port for the web UI.                           |
| `admin_user`     | `admin`                | Web UI admin username.                              |
| `admin_password` | `wud_change_me`        | Web UI admin password — **change this**.            |
| `docker_sock`    | `/var/run/docker.sock` | Docker socket to watch (mounted read-only).         |
| `resources`      | 200 MHz / 256 MB       | CPU and memory for the task.                         |

WUD watches the Docker socket of the node it runs on — pin it there with
`constraints`. Add notification and auto-update behaviour via `WUD_TRIGGER_*` and
`WUD_WATCHER_*` environment variables.
