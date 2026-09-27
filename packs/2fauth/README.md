# 2fauth

[2FAuth](https://2fauth.app/) — a self-hosted web app to manage your **two-factor authentication** accounts and
generate TOTP/HOTP security codes. Import from other authenticators, organize with groups, scan QR codes, and access
your codes from any device — with your secrets encrypted at rest. Uses SQLite, so it runs as a single container.

Single host-networked Nomad service with a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run 2fauth --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8000` | Web UI port. |
| `app_key` | `0123…` | **Change this** (exactly 32 chars) and keep it stable — it encrypts stored secrets (`APP_KEY`). |
| `base_url` | `""` | Public URL (`APP_URL`). Empty = `http://localhost:<port>`. |
| `image` | `2fauth/2fauth:latest` | Container image. Pin a tag in production. |
| `data_volume` | `2fauth_data` | `/2fauth` — the SQLite database. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> **Set a stable 32-character `app_key`** before storing accounts — it encrypts your 2FA secrets, so changing it later
> makes them unreadable. A prestart init task makes the data volume writable. Because it holds your 2FA secrets, always
> put 2FAuth behind an authenticating reverse proxy over TLS, and pin the job to the node holding the volume with
> `constraints`.
