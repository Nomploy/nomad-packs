# open-webui

[Open WebUI](https://openwebui.com) — a feature-rich, self-hosted **ChatGPT-style interface**
for local LLMs via **Ollama** (and any OpenAI-compatible API): multi-model chats, RAG over
your documents, prompts, and user management. Host-networked Nomad service with a persistent
volume. Pairs with the `ollama` pack.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run open-webui --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `open-webui`, custom registry
`github.com/Nomploy/nomad-packs`, then Deploy. Open `http://<node-ip>:3008` and create the
admin account (the first user is the admin).

Run the **ollama** pack alongside it (and `ollama pull <model>`), so there's a model to chat
with. By default Open WebUI talks to Ollama at `http://127.0.0.1:11434` (same node).

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `ghcr.io/open-webui/open-webui:main` | Pin a tag in production. |
| `port` | `3008` | Web app. |
| `ollama_base_url` | `http://127.0.0.1:11434` | The ollama pack on the same node. |
| `secret_key` | `""` | Set a stable random value in production. |
| `data_volume` | `open_webui_data` | Chats/users/settings. Back it up. |
| `constraints` | `[]` | Pin to a node (ideally the one running ollama). |
| `resources` | `cpu 500 / mem 512` | Raise for heavy use / RAG. |

## Notes

- **Single node.** `count` is fixed to 1 (local volume). Pin with `constraints`.
- Runs as root in the image, so a fresh volume is writable (no chown).
- Front with a reverse proxy for TLS. First registered user becomes the admin.
