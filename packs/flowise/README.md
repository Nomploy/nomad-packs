# flowise

[Flowise](https://flowiseai.com) — a low-code, drag-and-drop builder for LLM apps and agents:
chains, RAG pipelines, tools, and chatbots you can embed or call via API.

Single host-networked Nomad service with a data volume and optional app login. Pairs with the
[ollama](../ollama), [qdrant](../qdrant), and [weaviate](../weaviate) packs for a local AI stack.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run flowise --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3014` | Web UI / API port (`PORT`). |
| `username` / `password` | `admin` / `changeme-please` | App login (`FLOWISE_USERNAME`/`PASSWORD`). Empty username = no login. **Change the password.** |
| `data_volume` | `flowise_data` | `/root/.flowise` — database, API keys, files. |
| `image` | `flowiseai/flowise:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 1000, memory = 1024 }` | Task resources. |

Point LLM nodes at the ollama pack (`http://127.0.0.1:11434`) and vector stores at qdrant/weaviate.
Pin the job to the node holding the volume with `constraints`.
