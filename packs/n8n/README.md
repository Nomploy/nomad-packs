# n8n

[n8n](https://n8n.io) — a fair-code workflow automation tool: a visual editor, 400+
integrations, webhooks, and scheduling to wire your services together. Deployed as a
host-networked Nomad service with a persistent Docker volume, using the **bundled SQLite**
database (no external dependency) — ideal for a single node.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run n8n --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `n8n`, custom registry
`github.com/Nomploy/nomad-packs`, then Deploy.

Open `http://<node-ip>:5678` and create the owner account on first visit.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `n8nio/n8n:latest` | Pin a tag in production. |
| `port` | `5678` | Editor + webhook listener. |
| `host` / `webhook_url` | `""` | Set when fronting with a domain so generated URLs / webhooks are correct. |
| `encryption_key` | `""` | Empty = auto-generated and persisted in the volume. **Back it up** — credentials can't be restored without it. |
| `secure_cookie` | `false` | Keep false for `http://<ip>` login; set true behind HTTPS. |
| `timezone` | `UTC` | e.g. `Europe/Bratislava`. |
| `data_volume` | `n8n_data` | SQLite DB + encryption key. Back it up. |
| `constraints` | `[]` | Pin to a node so the local volume stays put. |

## Notes

- **Single node.** `count` is fixed to 1 (SQLite on a local volume). A prestart task
  chowns the volume to uid 1000 (the `node` user) so n8n can write it. Pin with
  `constraints`.
- **Secure cookie:** n8n refuses non-HTTPS logins with the secure cookie on. This pack
  defaults it off so IP/HTTP access works; turn it on once you serve n8n over TLS.
- **Encryption key:** guard it. Losing it (and the volume) makes stored credentials
  unreadable. Set it explicitly if you want to move data to a fresh volume.
- For heavy/queued workloads, switch n8n to Postgres + a Redis queue (extra env) — not
  configured here.
