# ollama

[Ollama](https://ollama.com) — run open large language models (Llama, Mistral, Gemma, Qwen,
DeepSeek, …) locally behind a simple REST API. Host-networked Nomad service with a
persistent volume for downloaded models.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run ollama --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `ollama`, custom registry
`github.com/Nomploy/nomad-packs`, then Deploy.

```sh
curl http://<node-ip>:11434/api/pull    -d '{"name":"llama3.2"}'
curl http://<node-ip>:11434/api/generate -d '{"model":"llama3.2","prompt":"hi"}'
```

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `ollama/ollama:latest` | Pin a tag in production. |
| `port` | `11434` | REST API (`OLLAMA_HOST`). |
| `data_volume` | `ollama_data` | Downloaded models (can be many GB). |
| `constraints` | `[]` | Pin to a node with enough RAM (or a GPU) and to keep the model volume. |
| `resources` | `cpu 2000 / mem 4096` | **Raise substantially** for real models — a 7B model needs several GB of RAM on CPU. |

## Notes

- **Single node.** `count` is fixed to 1 (local model volume). Pin with `constraints` to a
  node that has the resources.
- **CPU by default** — inference is slow for large models. GPU acceleration needs Nomad
  device plugin config (`device "nvidia/gpu"`), which isn't set here.
- **No authentication** — the API is open; keep it on an internal network or front it with
  an authenticating proxy.
- Pairs with a chat UI (e.g. Open WebUI) pointed at `http://<node-ip>:11434`.
