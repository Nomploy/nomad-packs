# searxng

[SearXNG](https://searxng.org) — a privacy-respecting, hackable metasearch engine. It queries 70+
search engines and aggregates the results, without profiling you, storing your searches, or serving
ads. A great private front-end for the web, and a popular search backend for self-hosted LLM tools.

Single host-networked Nomad service with a persistent settings volume (`/etc/searxng`).

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run searxng --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8080` | Web UI port. The container listens on 8080 — keep this unless you also change `server.port` in the settings volume. |
| `base_url` | `""` → `http://localhost:<port>/` | `SEARXNG_BASE_URL` — set to your public URL. |
| `secret_key` | `change-me-…` | `SEARXNG_SECRET` — **change it** (`openssl rand -hex 32`). |
| `data_volume` | `searxng_data` | `/etc/searxng` — holds `settings.yml`. |
| `image` | `searxng/searxng:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 256 }` | Task resources. |

On first boot SearXNG writes a default `settings.yml` into the volume. Edit it to tune engines,
change `server.port`, or enable the **JSON** format under `search.formats` (required if you point
Open WebUI or an LLM agent at SearXNG). Serves plain HTTP — front it with a reverse proxy for TLS.
Pin the job to the node holding the volume with `constraints`.
