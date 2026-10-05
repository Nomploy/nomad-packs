# khoj

[Khoj](https://khoj.dev) is a self-hosted **AI second brain** — chat with your documents
and the web, run local (Ollama) or cloud LLMs, and search your notes semantically.

This pack runs Khoj **all-in-one** as a single host-networked Nomad job:

- **server** — the Khoj app, UI and API (`ghcr.io/khoj-ai/khoj:latest`)
- **postgres** — PostgreSQL with the **pgvector** extension (prestart sidecar)

Both share the host network and talk over `127.0.0.1`, so no mesh networking is required.
On first start Khoj downloads its embedding models into the `khoj_models` volume and runs
database migrations automatically.

## Requirements

Give the server task **~2 GB RAM** (embedding models) and some disk for the model cache.

## Quick start

```sh
nomad-pack run khoj --registry=nomploy
```

Then open `http://<node-ip>:42110`. Configure a chat model (a local Ollama endpoint or a
cloud API key) in the admin settings.

## Configuration

| Variable | Default | Notes |
|----------|---------|-------|
| `port` | `42110` | Web UI / API host port |
| `db_password` | *change me* | Bundled PostgreSQL password |
| `django_secret_key` | *change me* | Session signing key — keep stable |
| `admin_email` / `admin_password` | *change me* | Initial admin account |
| `searxng_url` | *(blank)* | Optional: enable web search (point at a searxng instance) |
| `terrarium_url` | *(blank)* | Optional: enable the code-execution sandbox |

## Security

This pack runs Khoj in `--anonymous-mode` (matching the upstream docker-compose), which
means **there is no login wall** — anyone who can reach the port has full access. Keep it
behind your VPN or a reverse proxy that enforces authentication.

## Optional services

Khoj's web search and code-execution features need two extra services that both default
to port 8080, so they aren't bundled here (they'd collide on host networking):

- **Web search** — run [SearXNG](https://github.com/Nomploy/nomad-packs/tree/main/packs/searxng)
  on its own port and set `searxng_url`.
- **Code sandbox** — run `ghcr.io/khoj-ai/terrarium` separately and set `terrarium_url`.

Data persists in the `khoj_db_data`, `khoj_config` and `khoj_models` named volumes.
