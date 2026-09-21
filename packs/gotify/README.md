# gotify

[Gotify](https://gotify.net) — a simple, self-hosted server for **push notifications**: send
messages via a REST API and receive them in the web UI or the Android app. A
self-contained alternative to `ntfy` with built-in users/apps and a database. Host-networked
Nomad service with a persistent volume.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run gotify --registry nomploy --var admin_password=<secret>
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `gotify`, set
`admin_password`, then Deploy.

Open `http://<node-ip>:8099`, log in, create an **application** to get a token, then:

```sh
curl "http://<node-ip>:8099/message?token=<app-token>" -F "title=Hi" -F "message=It works"
```

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `gotify/server:latest` | Pin a tag in production. |
| `port` | `8099` | Web UI / API (`GOTIFY_SERVER_PORT`). |
| `admin_user` / `admin_password` | `admin` / `admin` | Created on **first boot**. **Change the password.** |
| `data_volume` | `gotify_data` | SQLite DB + uploads. Back it up. |
| `constraints` | `[]` | Pin to a node so the local volume stays put. |
| `resources` | `cpu 200 / mem 128` | Lightweight. |

## Notes

- **Single node.** `count` is fixed to 1 (SQLite on a local volume). Pin with `constraints`.
- Gotify runs as root in the image, so a fresh volume is writable (no chown).
- Admin credentials apply only on first boot with an empty volume.
- vs `ntfy`: Gotify has built-in users/tokens/apps + its own database and Android app; `ntfy`
  is topic-based and lighter. Pick whichever fits.
