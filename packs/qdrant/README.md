# qdrant

[Qdrant](https://qdrant.tech) — an open-source **vector database** and similarity-search
engine for embeddings: the storage/retrieval layer for semantic search and RAG. Host-networked
Nomad service with a persistent volume. Pairs with the `ollama` pack for a self-hosted AI stack.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run qdrant --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `qdrant`, custom registry
`github.com/Nomploy/nomad-packs`, then Deploy. Dashboard at `http://<node-ip>:6333/dashboard`.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `qdrant/qdrant:latest` | Pin a tag in production. |
| `http_port` / `grpc_port` | `6333` / `6334` | REST/dashboard + gRPC. |
| `api_key` | `""` | Empty = open; set to require an `api-key` header. |
| `data_volume` | `qdrant_data` | Collections + vectors. Back it up. |
| `constraints` | `[]` | Pin to a node so the local volume stays put. |
| `resources` | `cpu 500 / mem 512` | Raise memory for large collections. |

## Notes

- **Single node.** `count` is fixed to 1 (local volume). Pin with `constraints`.
- Qdrant runs as root in the image, so a fresh volume is writable (no chown).
- Set `api_key` and front with TLS before exposing it beyond a trusted network.
