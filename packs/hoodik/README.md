# hoodik

[Hoodik](https://github.com/hudikhq/hoodik) — a self-hosted, **end-to-end encrypted file storage** and sharing app.
Files are encrypted in the browser before upload, so the server only ever holds ciphertext; share links stay private
too. A lightweight, privacy-first alternative to cloud drives, with a clean web UI.

Single host-networked Nomad service with a persistent data volume. Serves **HTTPS** directly (self-signed by default).

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run hoodik --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `5443` | Web UI port (HTTPS, `HTTP_PORT`). |
| `base_url` | `""` | **Set for real use.** Public URL (`APP_URL`) — must match what users open. Empty = `https://localhost:<port>`. |
| `jwt_secret` | `change-me-…` | **Change this and keep it stable.** Signs session tokens. `openssl rand -base64 36`. |
| `image` | `hudik/hoodik:latest` | Container image. Pin a tag in production. |
| `data_volume` | `hoodik_data` | `/data` — database, files and the self-signed TLS cert. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> **Serves its own HTTPS.** Hoodik generates a self-signed certificate in the data volume on first run. Behind a
> reverse proxy, route to it over HTTPS (allow the self-signed cert), or supply your own via `SSL_CERT_FILE`/
> `SSL_KEY_FILE`. Set `base_url`/`APP_URL` to the exact address users open, and pin the job to the node holding the
> volume with `constraints`.
