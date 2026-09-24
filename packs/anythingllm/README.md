# anythingllm

[AnythingLLM](https://anythingllm.com) — an all-in-one AI application for chatting with your documents.
Connect any LLM (Ollama, OpenAI, Anthropic, local models…) and vector database, upload documents for
retrieval-augmented chat (RAG), and organize everything into workspaces with agents and a built-in API.

Single host-networked Nomad service with a persistent storage volume. A prestart task chowns the volume so
the app (uid 1000) can write it, and `SYS_ADMIN` is added for the document collector.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run anythingllm --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3001` | Web UI / API port (`SERVER_PORT`). |
| `storage_volume` | `anythingllm_storage` | `/app/server/storage` — SQLite DB, vector cache, uploaded documents. |
| `image` | `mintplexlabs/anythingllm:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 1000, memory = 1024 }` | Task resources. |

On first run, a setup wizard walks you through choosing an LLM provider and embedding/vector settings.
For a **fully local stack**, point it at the co-located `ollama` pack (`http://127.0.0.1:11434`) and the
`chroma` or `qdrant` packs, then create a workspace and upload documents. Serves plain HTTP — front it with
a reverse proxy for TLS. Pin the job to the node holding the volume with `constraints`.
