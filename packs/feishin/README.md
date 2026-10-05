# feishin

[Feishin](https://github.com/jeffvli/feishin) is a modern self-hosted **music player** web
UI for [Jellyfin](https://github.com/Nomploy/nomad-packs/tree/main/packs/jellyfin),
[Navidrome](https://github.com/Nomploy/nomad-packs/tree/main/packs/navidrome) or any
Subsonic-compatible server.

This pack runs Feishin as a single host-networked Nomad job. It's a **front-end only** —
it streams from your existing music server; settings (including the server you connect to)
are stored in the browser, so the container is **stateless** (no database, no volumes).

## Quick start

```sh
nomad-pack run feishin --registry=nomploy
```

Then open `http://<node-ip>:9180` and add your music server, or pre-fill it with
`server_type` + `server_url`.

## Configuration

| Variable | Default | Notes |
|----------|---------|-------|
| `port` | `9180` | Web UI host port |
| `server_type` | *(blank)* | `jellyfin`, `navidrome` or `subsonic` |
| `server_url` | *(blank)* | Backend server URL to pre-fill |
| `server_lock` | `false` | `true` locks the server settings in the UI |
| `count` | `1` | Instances (stateless — scale freely) |

Since Feishin is just a client, pair it with a music server pack (Navidrome, Jellyfin) and
point it at that server.
