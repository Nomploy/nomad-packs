# litellm

[LiteLLM](https://docs.litellm.ai) — an LLM **gateway/proxy** that exposes 100+ providers (OpenAI,
Anthropic, Ollama, and more) behind one **OpenAI-compatible API**, with a master key, routing,
fallbacks, and usage tracking.

Stateless host-networked Nomad service with a rendered `config.yaml`, pre-wired to the
[ollama](../ollama) pack.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run litellm --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `4000` | OpenAI-compatible API port. |
| `master_key` | `sk-change-me-…` | `LITELLM_MASTER_KEY` clients authenticate with. **Change it.** |
| `ollama_base` | `http://127.0.0.1:11434` | Ollama server to expose (`ollama/*` models). |
| `config` | proxies all Ollama models | Full `config.yaml`; add provider models/keys. |
| `image` | `ghcr.io/berriai/litellm:main-latest` | Image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. |

Point any OpenAI SDK at `http://<node-ip>:4000` with the master key as the API key. Edit `config`
to add OpenAI/Anthropic/etc. models. Stateless — add a Postgres DB for virtual keys/budgets (see the
LiteLLM docs).
