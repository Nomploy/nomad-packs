# librechat

[LibreChat](https://www.librechat.ai) is a feature-rich, open-source AI chat
platform — a self-hosted, multi-user ChatGPT alternative. One UI talks to many
providers (OpenAI, Anthropic, Google, Azure, AWS Bedrock, Ollama and any
OpenAI-compatible endpoint), with conversation branching, presets, assistants
and agents, code interpreter, file uploads, prompt libraries and full user
authentication.

This pack deploys LibreChat **all-in-one** as a single host-networked Nomad job:
**MongoDB** (bundled as a prestart sidecar) plus the LibreChat app. Message
search (Meilisearch) is disabled by default to keep the footprint small.

## Deploy

```bash
nomad-pack run librechat --registry=nomploy \
  --var creds_key=$(openssl rand -hex 32) \
  --var creds_iv=$(openssl rand -hex 16) \
  --var jwt_secret=$(openssl rand -hex 32) \
  --var jwt_refresh_secret=$(openssl rand -hex 32)
```

Open `http://<node-ip>:3080`, register the first account, then add your provider
API keys in each endpoint (they default to `user_provided`, so users supply
their own).

## Configuration

| Variable             | Default                              | Description                                 |
| -------------------- | ------------------------------------ | ------------------------------------------- |
| `image`              | `ghcr.io/danny-avila/librechat:latest` | App image (pin a tag in production).         |
| `mongo_image`        | `mongo:7.0`                          | Bundled MongoDB (needs AVX for 5.0+).        |
| `port`               | `3080`                               | Host port for the web UI.                    |
| `mongo_port`         | `27017`                              | Host port for MongoDB.                       |
| `creds_key`          | placeholder (64 hex)                 | Credential-encryption key — **change this**. |
| `creds_iv`           | placeholder (32 hex)                 | Credential-encryption IV — **change this**.  |
| `jwt_secret`         | placeholder                          | JWT access-token secret — **change this**.   |
| `jwt_refresh_secret` | placeholder                          | JWT refresh-token secret — **change this**.  |
| `allow_registration` | `true`                               | Allow new users to sign up.                  |
| `resources`          | 1000 MHz / 2048 MB                   | App task resources.                          |

Data persists in separate volumes for MongoDB, app data, uploads, images and
logs. To enable message search, run Meilisearch and set `SEARCH=true` with the
appropriate `MEILI_*` env vars.
