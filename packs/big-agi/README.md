# big-agi

[big-AGI](https://github.com/enricoros/big-AGI) — a feature-rich, **multi-model AI chat** suite. Talk to many
providers (OpenAI, Anthropic, Google, Groq, Ollama and more) from one polished UI, with personas, multi-model "beam"
comparisons, branching, code execution, image generation, text-to-speech and drawing. A power-user alternative to a
single-vendor chat app.

Single **stateless** host-networked Nomad service (no volume) — your API keys and settings live in your browser.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run big-agi --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3000` | Web UI port. |
| `image` | `ghcr.io/enricoros/big-agi:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> Add your provider API keys in the UI (Settings), or bake server-side defaults by adding env vars like
> `OPENAI_API_KEY` to the task. Point it at a local [ollama](https://packs.nomploy.com/packs/ollama) for fully
> self-hosted chat. Being stateless, it needs no storage — put it behind an authenticating reverse proxy if it
> shouldn't be public.
