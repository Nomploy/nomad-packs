# chroma

[Chroma](https://www.trychroma.com) — an open-source embedding (vector) database for AI apps. Store
embeddings with metadata and run fast similarity search — the retrieval half of a RAG or semantic-search
stack. Simple HTTP API with official Python and JavaScript clients.

Single host-networked Nomad service with a persistent on-disk store.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run chroma --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8000` | HTTP API port. The container listens on 8000. |
| `data_volume` | `chroma_data` | `/chroma/chroma` — collections and embeddings (persistent). |
| `image` | `chromadb/chroma:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. Bump memory for large collections. |

Connect from Python with `chromadb.HttpClient(host="<node-ip>", port=8000)`. Pairs with the `ollama`
and `open-webui` packs for a fully local RAG stack. The API is **unauthenticated** by default — keep it
on an internal network, or enable token auth via the `CHROMA_SERVER_AUTHN_CREDENTIALS` /
`CHROMA_SERVER_AUTHN_PROVIDER` env vars. Pin the job to the node holding the volume with `constraints`.
