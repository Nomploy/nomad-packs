# infinity

[Infinity](https://github.com/michaelfeil/infinity) — a fast, **OpenAI-compatible** inference server for **text
embeddings and rerankers**, serving any embedding/reranker model from Hugging Face. It's the ideal embeddings backend
for RAG: point tools like AnythingLLM, Open WebUI or a pgvector pipeline at its `/embeddings` endpoint. This pack uses
the CPU image.

Single host-networked Nomad service with a persistent model cache.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run infinity --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `7997` | OpenAI-compatible API port. |
| `model_id` | `BAAI/bge-small-en-v1.5` | Hugging Face model to serve (`--model-id`). Comma-separate to serve several. |
| `image` | `michaelf34/infinity:latest-cpu` | Container image (CPU). Pin a tag in production. |
| `data_volume` | `infinity_data` | `/app/.cache` — the Hugging Face model cache. |
| `resources` | `{ cpu = 2000, memory = 2048 }` | Task resources. Inference is CPU/RAM heavy. |

> The model downloads into the cache on first start. Endpoints follow the OpenAI API (`/embeddings`, plus `/rerank`);
> interactive docs at `/docs`. Pairs with [anythingllm](https://packs.nomploy.com/packs/anythingllm),
> [open-webui](https://packs.nomploy.com/packs/open-webui) and [pgvector](https://packs.nomploy.com/packs/pgvector). For
> a GPU, switch `image` to the CUDA tag and add GPU scheduling. Pin the job to the node holding the cache with
> `constraints`.
