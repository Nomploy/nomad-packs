# openui

[OpenUI](https://github.com/wandb/openui) — describe a user interface in **natural language** and watch it render live
in the browser, then tweak it by chatting and convert the result to React, Svelte, Web Components or plain HTML. A fun,
fast way to prototype UI, backed by the LLM of your choice.

Single **stateless** host-networked Nomad service (no volume).

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run openui --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `7878` | Web UI port. Fixed at `7878` inside the image. |
| `ollama_host` | `http://127.0.0.1:11434` | Ollama server for local models (`OLLAMA_HOST`). |
| `openai_api_key` | `""` | Optional OpenAI key (`OPENAI_API_KEY`) to enable OpenAI models. |
| `image` | `ghcr.io/wandb/openui:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> **Bring a model:** point `ollama_host` at a local [ollama](https://packs.nomploy.com/packs/ollama) for a fully
> self-hosted setup, or set `openai_api_key` (or add other provider keys like `ANTHROPIC_API_KEY`/`GROQ_API_KEY` to the
> task env). Being stateless, it needs no storage — put it behind an authenticating reverse proxy if it shouldn't be
> public.
