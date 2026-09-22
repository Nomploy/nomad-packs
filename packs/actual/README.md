# actual

[Actual Budget](https://actualbudget.org) — a fast, privacy-focused, **local-first** personal
finance app (zero-based / envelope budgeting) with a self-hosted **sync server**. Your data
lives on your server and syncs to the web, desktop, and mobile apps. Host-networked Nomad
service with a persistent volume.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run actual --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `actual`, custom registry
`github.com/Nomploy/nomad-packs`, then Deploy. Open `http://<node-ip>:5006`, set a server
password on first visit, and create your budget.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `actualbudget/actual-server:latest` | Pin a tag in production. |
| `port` | `5006` | Web app / sync server (`ACTUAL_PORT`). |
| `data_volume` | `actual_data` | Budgets + sync DB. Back it up. |
| `constraints` | `[]` | Pin to a node so the local volume stays put. |
| `resources` | `cpu 300 / mem 256` | Lightweight. |

## Notes

- **Single node.** `count` is fixed to 1 (local volume). A prestart task chowns the volume to
  uid 1000. Pin with `constraints`.
- The server password (which gates access) is set in the UI on first use.
- Front with a reverse proxy for TLS — the clients sync over it.
- **Backups:** snapshot the `data_volume` (or use Actual's built-in export).
