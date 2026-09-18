# meilisearch

[Meilisearch](https://www.meilisearch.com) — a fast, typo-tolerant open-source search
engine with instant full-text search and a simple REST API. Drop-in search for your apps.
Host-networked Nomad service with a persistent Docker volume.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run meilisearch --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `meilisearch`, custom
registry `github.com/Nomploy/nomad-packs`, then Deploy.

API at `http://<node-ip>:7700` (`/health` to check).

## Authentication

Follows the optional-auth pattern:

- `master_key` empty → **development** mode, API is **open** (no auth). Fine on a trusted
  network.
- `master_key` set (≥ 16 bytes) → **production** mode; clients send
  `Authorization: Bearer <master_key>`. Derive scoped API keys from `/keys`.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `getmeili/meilisearch:latest` | Pin a tag in production. |
| `port` | `7700` | HTTP API host port. |
| `master_key` | `""` | Set for production auth; empty = open dev mode. |
| `data_volume` | `meilisearch_data` | `/meili_data`. Back it up. |
| `constraints` | `[]` | Pin to a node so the local volume stays put. |
| `resources` | `cpu 500 / mem 512` | Raise memory for large indexes. |

## Notes

- **Single node.** `count` is fixed to 1 (local volume). Pin with `constraints`.
- Meilisearch runs as root in the image, so a fresh volume is writable (no chown).
- **Backups:** snapshot the `data_volume`, or use Meilisearch dumps.
