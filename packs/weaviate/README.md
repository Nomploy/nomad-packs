# weaviate

[Weaviate](https://weaviate.io) — an open-source vector database for semantic search and AI/RAG
apps, with REST + GraphQL + gRPC APIs and pluggable vectorizer modules.

Single host-networked Nomad service with a persistent data volume. Pairs with the
[ollama](../ollama) and [open-webui](../open-webui) packs for a local AI stack.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run weaviate --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8087` | REST + GraphQL API port. |
| `grpc_port` | `50051` | gRPC API port (v4 clients). |
| `anonymous_access` | `true` | Allow unauthenticated access (ignored if `api_key` set). |
| `api_key` | `""` | Enable API-key auth with this key (disables anonymous). |
| `data_volume` | `weaviate_data` | `/var/lib/weaviate`. |
| `image` | `cr.weaviate.io/semitechnologies/weaviate:latest` | Image. Pin a tag in production. |
| `resources` | `{ cpu = 1000, memory = 1024 }` | Task resources. |

The default vectorizer module is `none` — bring your own vectors, or enable a module plus its
inference service (e.g. embeddings from the ollama pack). Pin the job to the node holding the
volume with `constraints`.
