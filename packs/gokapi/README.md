# gokapi

[Gokapi](https://github.com/Forceu/Gokapi) is a lightweight self-hosted **file-sharing
server** — a WeTransfer / Firefox Send alternative. Upload a file and get a shareable
link with an expiry time and a download limit; optionally end-to-end encrypt uploads.

This pack runs Gokapi as a single host-networked Nomad job. It stores uploads and its
SQLite database in the `gokapi_data` volume and config in `gokapi_config` — no external
database is required.

## Quick start

```sh
nomad-pack run gokapi --registry=nomploy
```

Then open `http://<node-ip>:53842/setup` and follow the setup wizard to create the admin
account and pick the encryption level.

## Configuration

| Variable | Default | Notes |
|----------|---------|-------|
| `port` | `53842` | Web UI host port |
| `data_volume` | `gokapi_data` | Uploads + SQLite database |
| `config_volume` | `gokapi_config` | Gokapi config |

The admin account and encryption settings are created in the one-time setup wizard. Keep
Gokapi behind your VPN or an authenticating reverse proxy if the upload UI shouldn't be
publicly reachable.
