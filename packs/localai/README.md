# localai

[LocalAI](https://localai.io/) — a free, self-hosted, **OpenAI-compatible inference server**. Run LLMs (chat and
embeddings), image generation, speech-to-text and text-to-speech locally, and point any OpenAI SDK/client at it as a
drop-in replacement — no API keys, no data leaving your server. Runs on CPU, with optional GPU acceleration.

Single host-networked Nomad service with a persistent models volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run localai --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8080` | API / web UI port (`ADDRESS`). OpenAI-compatible at `/v1`. |
| `image` | `localai/localai:latest` | Container image (CPU). Pin a tag in production. |
| `data_volume` | `localai_data` | `/models` — downloaded model files (`MODELS_PATH`). |
| `resources` | `{ cpu = 4000, memory = 4096 }` | Task resources. Inference is heavy — give it cores and RAM. |

> **Bring models:** install from the built-in model gallery (UI or `POST /models/apply`), e.g. a small chat model, then
> call `/v1/chat/completions`. Models download into the volume, which can grow large. For a batteries-included start,
> use an `-aio-cpu` image tag (bundles curated models). Point [open-webui](https://packs.nomploy.com/packs/open-webui)
> or [big-agi](https://packs.nomploy.com/packs/big-agi) at it. For GPUs, switch to a CUDA image tag and add GPU
> scheduling. Pin the job to the node holding the volume with `constraints`.
