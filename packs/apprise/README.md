# apprise

[Apprise](https://github.com/caronc/apprise-api) — one notification gateway for everything. It relays
messages to 100+ services (Telegram, Discord, Slack, ntfy, Matrix, email, Pushover, webhooks, and
many more) through a single HTTP API, so your apps only ever need to know about Apprise.

Single host-networked Nomad service with a persistent `/config` volume for saved destinations.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run apprise --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8000` | API / web UI port. The container listens on 8000 — keep this unless you also change the image. |
| `stateful_mode` | `simple` | `APPRISE_STATEFUL_MODE` — how saved configs are stored (`simple` / `hash` / `disabled`). |
| `worker_count` | `1` | `APPRISE_WORKER_COUNT` — API workers. |
| `config_volume` | `apprise_config` | `/config` — saved notification configurations. |
| `image` | `caronc/apprise:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

Add a configuration in the web UI under a key, then trigger it from anywhere:

```sh
curl -X POST -d '{"body":"Deploy finished"}' -H "Content-Type: application/json" \
  http://<node-ip>:8000/notify/<your-config-key>
```

The API has **no authentication** — keep it internal or behind a reverse proxy. Pin the job to the
node holding the volume with `constraints`.
