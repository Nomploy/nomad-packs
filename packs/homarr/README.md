# homarr

[Homarr](https://homarr.dev) — a sleek, self-hosted **dashboard** for your homelab. A customizable start page
with drag-and-drop widgets, **live integrations** for your apps (Docker, the *arr suite, media servers,
download clients, and more), search, and per-user boards with authentication built in.

Single host-networked Nomad service with a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run homarr --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `7575` | Web UI port (`PORT`). |
| `secret_encryption_key` | `change-me-…` | 64-hex-char key (`SECRET_ENCRYPTION_KEY`) encrypting stored secrets. **Change it and keep it stable** (`openssl rand -hex 32`). |
| `data_volume` | `homarr_data` | `/appdata` — database, boards, and config. |
| `image` | `ghcr.io/homarr-labs/homarr:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. |

Create the admin account on first visit, then build your board and connect integrations. **Keep
`secret_encryption_key` stable** — changing it makes stored credentials unreadable. A richer, integration-driven
alternative to the `homepage`, `glance`, and `flame` packs. Serves plain HTTP — front it with a reverse proxy
for TLS. Pin the job to the node holding the volume with `constraints`.
