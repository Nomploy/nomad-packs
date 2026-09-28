# sillytavern

[SillyTavern](https://sillytavern.app) is a powerful, locally hosted frontend
for chatting and roleplaying with large language models. It connects to a wide
range of backends (OpenAI, Anthropic, Google, Mistral, OpenRouter, Ollama,
KoboldAI, text-generation-webui and more) and adds rich character cards, group
chats, world info/lorebooks, prompt tooling, TTS and a big extension ecosystem.

This pack runs SillyTavern as a single host-networked Nomad service.

## Deploy

```bash
nomad-pack run sillytavern --registry=nomploy \
  --var basic_auth=true --var basic_auth_password=$(openssl rand -hex 12)
```

Open `http://<node-ip>:8000` and add your backend API keys in the connections
panel.

## Configuration

| Variable              | Default                                    | Description                              |
| --------------------- | ------------------------------------------ | ---------------------------------------- |
| `image`               | `ghcr.io/sillytavern/sillytavern:latest`   | Container image (pin a tag in production). |
| `port`                | `8000`                                     | Host port for the web UI.                 |
| `basic_auth`          | `false`                                    | Enable HTTP basic authentication.         |
| `basic_auth_user`     | `user`                                     | Basic-auth username.                      |
| `basic_auth_password` | placeholder                                | Basic-auth password — **change this**.    |
| `config_volume`       | `sillytavern_config`                       | Volume for config.                        |
| `data_volume`         | `sillytavern_data`                         | Volume for chats/characters/settings.     |
| `resources`           | 500 MHz / 512 MB                           | CPU and memory for the task.               |

> **Security:** This pack disables whitelist mode so the UI is reachable over the
> network. If it's exposed beyond a trusted LAN, enable `basic_auth` or put it
> behind an authenticating reverse proxy.

Config, data, plugins and extensions each persist in their own volume.
