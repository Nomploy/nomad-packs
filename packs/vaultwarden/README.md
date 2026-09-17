# vaultwarden

[Vaultwarden](https://github.com/dani-garcia/vaultwarden) — a lightweight, Rust-based
server that implements the Bitwarden API, so you can self-host a password manager and use
the official Bitwarden apps/extensions against it. Host-networked Nomad service with a
persistent Docker volume; uses the **bundled SQLite** database.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run vaultwarden --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `vaultwarden`, custom
registry `github.com/Nomploy/nomad-packs`, then Deploy.

Open the web vault, create your account, then point Bitwarden clients at the same URL.

## Serve it over HTTPS

Vaultwarden serves plain HTTP here, but in practice you **must** front it with a reverse
proxy that terminates TLS — browser crypto (unlock, WebAuthn) and the Bitwarden clients
require HTTPS. Set `domain` to your public `https://…` URL so links, WebAuthn and the admin
page work.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `vaultwarden/server:latest` | Pin a tag in production. |
| `port` | `8280` | Web vault / API host port (off 8222 to dodge the nats pack). |
| `domain` | `""` | Public `https://` URL — strongly recommended. |
| `signups_allowed` | `true` | Turn off after your users register (or invite from /admin). |
| `admin_token` | `""` | Empty = `/admin` disabled. Set a strong token to enable it. |
| `data_volume` | `vaultwarden_data` | SQLite DB + keys + attachments. **Back it up.** |
| `constraints` | `[]` | Pin to a node so the local volume stays put. |
| `resources` | `cpu 300 / mem 256` | Lightweight. |

## Notes

- **Single node.** `count` is fixed to 1 (SQLite on a local volume). Pin with
  `constraints`. Vaultwarden runs as root, so a fresh volume is writable (no chown).
- **Backups are critical:** the `/data` volume holds the SQLite DB *and* the RSA keys. Snapshot it
  regularly; without it, vaults are unrecoverable.
- Lock down access: turn `signups_allowed` off once set up, and keep `admin_token` unset
  unless you need the admin page.
