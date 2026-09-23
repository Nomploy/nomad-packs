# lobe-chat

[Lobe Chat](https://lobehub.com) — a polished, open-source AI chat UI supporting many providers
(OpenAI, Anthropic, Ollama, and more), with plugins, vision, and text-to-image.

Stateless host-networked Nomad service (chats are stored in the browser). Pairs with the
[ollama](../ollama) pack for fully local chat.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run lobe-chat --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3210` | Web UI port (`PORT`). |
| `ollama_proxy_url` | `http://127.0.0.1:11434/v1` | Ollama OpenAI-compatible endpoint. |
| `openai_api_key` | `""` | Optional OpenAI key. |
| `access_code` | `""` | Optional password gate (`ACCESS_CODE`). |
| `image` | `lobehub/lobe-chat:latest` | Image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. |

This is the lightweight client edition — chats/settings live in the browser (no server database).
Set `access_code` to gate access and front with TLS for public use.
