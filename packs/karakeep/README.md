# karakeep

[Karakeep](https://github.com/karakeep-app/karakeep) (formerly Hoarder) — a self-hosted **bookmark-everything**
app. Save links, notes and images; Karakeep fetches a full-page snapshot, extracts the text, and makes everything
searchable. It can auto-tag content with an LLM, and offers browser extensions and mobile apps.

This pack is **batteries-included**: a single host-networked group running three tasks —

- **karakeep** — the web app (SQLite in `/data`, no external database needed).
- **meilisearch** — full-text search engine (loopback `127.0.0.1`).
- **chrome** — headless Chromium used to render and archive pages (loopback `127.0.0.1`).

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run karakeep --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3000` | Web UI port. |
| `nextauth_secret` | `change-me-…` | **Change this.** Session signing secret. `openssl rand -base64 36`. |
| `meili_master_key` | `change-me-…` | **Change this.** Shared by the app and Meilisearch. `openssl rand -base64 36`. |
| `base_url` | `""` | Public URL (`NEXTAUTH_URL`). Empty = `http://localhost:<port>`. Set to your real host. |
| `image` | `ghcr.io/karakeep-app/karakeep:release` | Web image. Pin a tag in production. |
| `meilisearch_image` | `getmeili/meilisearch:v1.13.3` | Search engine image. |
| `chrome_image` | `gcr.io/zenika/alpine-chrome:123` | Headless Chrome image. |
| `meili_port` / `chrome_port` | `7700` / `9222` | Loopback ports for the sidecars. |
| `data_volume` | `karakeep_data` | `/data` — database and assets. |
| `meili_data_volume` | `karakeep_meili` | `/meili_data` — the search index. |
| `resources` | `{ cpu = 500, memory = 512 }` | Web task resources. |
| `meilisearch_resources` | `{ cpu = 300, memory = 512 }` | Meilisearch resources. |
| `chrome_resources` | `{ cpu = 500, memory = 768 }` | Chrome resources (rendering is memory-hungry). |

> **AI tagging (optional):** to enable automatic tagging, add `OPENAI_API_KEY` (or point `OLLAMA_BASE_URL` at a
> local [ollama](https://packs.nomploy.com/packs/ollama) and set `INFERENCE_TEXT_MODEL`) to the `karakeep` task's
> `env`. See the Karakeep docs for the full list.

> All three tasks share the host network, so they must run together on one node. Pin the job to the node holding the
> volumes with `constraints`, and put Karakeep behind an authenticating reverse proxy over TLS before exposing it.
