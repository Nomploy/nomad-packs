# typesense

[Typesense](https://typesense.org) — a fast, typo-tolerant open-source **search engine**, an
open alternative to Algolia/Elasticsearch with a simple API and instant, relevant results.
Host-networked Nomad service with a persistent volume.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run typesense --registry nomploy --var api_key=<secret>
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `typesense`, set `api_key`,
then Deploy. API at `http://<node-ip>:8108` (send `X-TYPESENSE-API-KEY`).

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `typesense/typesense:27.1` | Pin a tag in production. |
| `port` | `8108` | HTTP API. |
| `api_key` | `changeme` | **Required admin key — change it.** |
| `data_volume` | `typesense_data` | The search index. Back it up. |
| `constraints` | `[]` | Pin to a node so the local volume stays put. |
| `resources` | `cpu 500 / mem 512` | Raise memory for large indexes. |

## Notes

- **Single node.** `count` is fixed to 1 (local volume). Pin with `constraints`. (Typesense
  also supports clustering with a nodes file — out of scope here.)
- Typesense runs as root in the image, so a fresh volume is writable (no chown).
- vs `meilisearch`: both are fast, typo-tolerant search engines; pick whichever API/features
  fit. Front with TLS before exposing beyond a trusted network.
