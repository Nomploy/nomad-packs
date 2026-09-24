# maloja

[Maloja](https://github.com/krateng/maloja) — a self-hosted music scrobble database. It records what
you listen to and builds personal statistics and charts (top artists, tracks, listening history) — a
private, no-tracking alternative to Last.fm. Accepts scrobbles from many players and apps via a simple
API, including a Last.fm-compatible endpoint.

Single host-networked Nomad service with a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run maloja --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `42010` | Web UI / API port. The container listens on 42010. |
| `force_password` | `change-me-please` | Admin password set on first boot (`MALOJA_FORCE_PASSWORD`). **Change it.** |
| `data_volume` | `maloja_data` | `/mljdata` — scrobble database, settings, API keys. |
| `image` | `krateng/maloja:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. |

Log in with your password, create an API key under Settings, and point your scrobbler at
`http://<node-ip>:42010`. Many players support Maloja directly; others can use a Last.fm-compatible
bridge. Serves plain HTTP — front it with a reverse proxy for TLS. Pin the job to the node holding the
volume with `constraints`.
