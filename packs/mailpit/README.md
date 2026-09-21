# mailpit

[Mailpit](https://mailpit.axllent.org) — a developer/test **SMTP server** that captures
outgoing email into a web UI (with a searchable inbox, HTML/source view, and API) instead
of delivering it. Point your apps at it in staging so test emails never reach real inboxes.
Stateless host-networked Nomad service.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run mailpit --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `mailpit`, custom registry
`github.com/Nomploy/nomad-packs`, then Deploy.

- **Web UI** — `http://<node-ip>:8025`
- **SMTP** — `<node-ip>:1025` (no auth/TLS needed) — set this as your app's mail host/port.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `axllent/mailpit:latest` | Pin a tag in production. |
| `ui_port` | `8025` | Web UI / API. |
| `smtp_port` | `1025` | SMTP listener. |
| `constraints` | `[]` | Placement. |
| `resources` | `cpu 200 / mem 128` | Lightweight. |

## Notes

- **Stateless** — captured messages are held in memory and cleared on restart (for
  persistent capture you'd add a volume + `MP_DATABASE`; not configured here).
- This is a **testing** mail trap, not a real mail server — it never delivers mail onward.
- No auth on the UI by default; keep it internal.
