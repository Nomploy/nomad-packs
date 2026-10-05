# pwpush

[Password Pusher](https://pwpush.com) lets you **securely share passwords and secret text**
via self-destructing links — set an expiry (days / views) so secrets don't linger in chat
or email. Also supports sharing files and URLs.

This pack runs Password Pusher as a single host-networked Nomad job with SQLite storage
(in the `pwpush_storage` volume) — no external database is required.

## Quick start

```sh
nomad-pack run pwpush --registry=nomploy
```

Then open `http://<node-ip>:5100`.

## Configuration

| Variable | Default | Notes |
|----------|---------|-------|
| `port` | `5100` | Web UI host port |
| `storage_volume` | `pwpush_storage` | SQLite database + uploads |

Since you're sending secrets through it, put Password Pusher behind HTTPS (a reverse
proxy). For higher volume you can switch to PostgreSQL and S3-compatible storage via the
`DATABASE_URL` / `PWP__*` environment variables (see the Password Pusher docs). Data
persists in the `pwpush_storage` named volume.
