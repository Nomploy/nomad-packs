# libretranslate

[LibreTranslate](https://libretranslate.com) — a free, open-source machine-translation API that runs
**entirely on your own hardware** (no calls to any cloud). Powered by Argos Translate, it offers a simple
web UI and a REST API — a self-hosted Google Translate / DeepL alternative that keeps your text private.

Single host-networked Nomad service with a persistent models volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run libretranslate --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `5000` | Web UI / API port. |
| `load_only` | `en,es,de,fr,sk,cs` | Languages to load (`LT_LOAD_ONLY`). Fewer = faster start, less disk. Empty = all (large). |
| `api_keys_enabled` | `false` | Require API keys (`LT_API_KEYS`); add them with `ltmanage keys add` in the container. |
| `models_volume` | `libretranslate_models` | `/home/libretranslate/.local` — downloaded language models. |
| `image` | `libretranslate/libretranslate:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 1000, memory = 1024 }` | Task resources. Translation is CPU-bound. |

Translate via the UI or `POST /translate` with `q`, `source`, `target`. **First boot downloads the models**
named in `load_only` (needs internet, can take a while); everything runs locally afterward. Great as a
backend for the `open-webui` pack or your own apps. Serves plain HTTP — front it with a reverse proxy for
TLS. Pin the job to the node holding the volume with `constraints`.
