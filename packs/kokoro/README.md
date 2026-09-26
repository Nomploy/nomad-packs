# kokoro

[Kokoro-FastAPI](https://github.com/remsky/Kokoro-FastAPI) — a fast, **OpenAI-compatible text-to-speech** API server
powered by the open Kokoro model. Point any client that speaks the OpenAI `/v1/audio/speech` API at it to generate
natural speech in multiple voices — great for self-hosted assistants, audiobooks and accessibility.

Single **stateless** host-networked Nomad service (models are bundled in the image; no volume needed). This pack uses
the **CPU** image.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run kokoro --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8880` | API / web UI port. Fixed at `8880` inside the image. |
| `image` | `ghcr.io/remsky/kokoro-fastapi-cpu:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 2000, memory = 2048 }` | Task resources. CPU inference is heavy — give it cores. |

> Endpoints: API at `/v1/audio/speech`, interactive docs at `/docs`, a demo UI at `/web`. Works as a drop-in TTS
> backend for [open-webui](https://packs.nomploy.com/packs/open-webui) and other OpenAI-compatible clients. For much
> faster synthesis on an NVIDIA GPU, switch `image` to the `kokoro-fastapi-gpu` tag and add GPU scheduling.
