# arcane

[Arcane](https://getarcane.app) is a modern, easy-to-use **Docker management UI** — a
Portainer alternative. Manage containers, images, networks, volumes, Compose stacks and
logs from the browser.

This pack runs Arcane as a single host-networked Nomad job. It reads the host's Docker
socket to manage Docker, and stores its own state in SQLite inside the `arcane_data`
volume — no external database is required.

## Quick start

```sh
nomad-pack run arcane --registry=nomploy
```

Then open `http://<node-ip>:3552` and create the first admin account.

## Configuration

| Variable | Default | Notes |
|----------|---------|-------|
| `port` | `3552` | Web UI host port |
| `app_url` | `http://localhost:3552` | Public URL — set to your domain in production |
| `encryption_key` | *change me* | **Exactly 32 characters** — encrypts stored secrets, keep stable |
| `jwt_secret` | *change me* | Session signing key — keep stable |
| `docker_socket` | `/var/run/docker.sock` | Host Docker socket to manage |

Change `encryption_key` (exactly 32 chars) and `jwt_secret` before deploying anywhere real,
and keep them stable.

## Security

Arcane mounts the Docker socket, which is equivalent to root on the node. Keep it behind
your VPN or an authenticating reverse proxy and restrict access. Data persists in the
`arcane_data` named volume.
