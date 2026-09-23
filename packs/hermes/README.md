# hermes

[Hermes Agent](https://hermes-agent.nousresearch.com) — Nous Research's open-source, self-hosted
personal AI agent: one gateway with persistent memory, skills, and scheduled jobs, reachable over an
**OpenAI-compatible API** (and 20+ chat platforms).

Single host-networked Nomad service with a data volume. Bring your own LLM provider.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run hermes --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8642` | Gateway API / health port. |
| `openai_api_key` | `""` | `OPENAI_API_KEY`. |
| `anthropic_api_key` | `""` | `ANTHROPIC_API_KEY`. |
| `openai_base_url` | `""` | `OPENAI_BASE_URL` — point at a local provider (litellm/ollama). |
| `auth_token` | `""` | `HERMES_AUTH_TOKEN` securing the API. |
| `data_volume` | `hermes_data` | `/opt/data` — persistent memory, config, keys. |
| `image` | `nousresearch/hermes-agent:latest` | Image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. |

Set at least one provider (`openai_api_key` / `anthropic_api_key`) or `openai_base_url` to a local
OpenAI-compatible endpoint — e.g. the [litellm](../litellm) pack (`http://127.0.0.1:4000/v1`) fronting
[ollama](../ollama). Set `auth_token` and front with TLS before exposing it. Pin the job to the node
holding the volume with `constraints`.
