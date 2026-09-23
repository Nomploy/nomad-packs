# opencode

[OpenCode](https://opencode.ai) — an open-source AI coding agent, here run in **headless server mode**
(`opencode serve`). It exposes an HTTP API that the OpenCode TUI, editor extensions, and other clients
connect to.

Single host-networked Nomad service with config and data volumes. Bring an LLM provider key.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run opencode --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `4096` | Headless server port. |
| `anthropic_api_key` | `""` | `ANTHROPIC_API_KEY`. |
| `openai_api_key` | `""` | `OPENAI_API_KEY`. |
| `config_volume` | `opencode_config` | `/root/.config/opencode`. |
| `data_volume` | `opencode_data` | `/root/.local/share/opencode` — auth, sessions, state. |
| `image` | `ghcr.io/anomalyco/opencode:latest` | Image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. |

Set a provider key, or configure OpenCode to use a local OpenAI-compatible endpoint (the
[litellm](../litellm) / [ollama](../ollama) packs). Connect the OpenCode TUI/extension to
`http://<node-ip>:4096`. **No built-in auth** — keep it internal or behind TLS+auth. Pin the job to
the node holding the volumes with `constraints`.
