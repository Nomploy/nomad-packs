# wishlist

[Wishlist](https://github.com/cmintey/wishlist) — a self-hosted **wish-list and gift registry** for families and
groups. Everyone keeps a list; others can claim gifts (optionally hidden from the list owner so surprises stay
intact), add items by URL, and share invite links. Great for birthdays and the holidays.

Single host-networked Nomad service with database and uploads volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run wishlist --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3280` | Web UI port (`PORT`). |
| `base_url` | `""` | **Set for real use.** Public URL (`ORIGIN`) — must match what users open, incl. port. Empty = `http://localhost:<port>`. |
| `token_time` | `72` | Hours until login/invite tokens expire (`TOKEN_TIME`). |
| `default_currency` | `USD` | ISO 4217 default currency (`DEFAULT_CURRENCY`). |
| `image` | `ghcr.io/cmintey/wishlist:latest` | Container image. Pin a tag in production. |
| `data_volume` | `wishlist_data` | `/usr/src/app/data` — the SQLite database. |
| `uploads_volume` | `wishlist_uploads` | `/usr/src/app/uploads` — item images. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> **`base_url` matters:** if `ORIGIN` doesn't match your real address (host + port), sign-in and uploads fail. A
> prestart init task chowns both volumes to uid `1000`. The first account you create becomes the admin. Pin the job to
> the node holding the volumes with `constraints`.
