# duplicati

[Duplicati](https://www.duplicati.com) — a backup client with a friendly web UI. Make **encrypted, incremental,
deduplicated** backups to local disk or a huge range of cloud/remote targets (S3, Backblaze B2, WebDAV, SFTP,
Google Drive, and more), on a schedule, with restore-browsing built in.

Single host-networked Nomad service with config, source, and backup volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run duplicati --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8210` | Web UI port. |
| `settings_encryption_key` | `change-me-…` | `SETTINGS_ENCRYPTION_KEY` — encrypts Duplicati's settings DB. **Change it, keep it stable.** |
| `config_volume` | `duplicati_config` | `/config` — jobs, schedules, settings DB. |
| `source_volume` | `duplicati_source` | `/source` — **the data to back up** (swap for a bind mount for real host paths). |
| `backups_volume` | `duplicati_backups` | `/backups` — local backup destinations (skip if backing up to cloud). |
| `puid` / `pgid` | `1000` / `1000` | User/group (`PUID`/`PGID`). |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `image` | `lscr.io/linuxserver/duplicati:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. |

Set a UI password, then create a backup job: pick a destination, select `/source`, set a schedule and a strong
**backup passphrase**. Keep that passphrase and `settings_encryption_key` safe — they're required to restore. A GUI
alternative to the restic-based `backrest` pack. Front the UI with a reverse proxy for TLS.
