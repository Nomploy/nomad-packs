# memcached

[Memcached](https://memcached.org) — a high-performance, distributed in-memory key/value
cache, commonly used to speed up dynamic web apps by caching query results and objects.
Host-networked Nomad service; purely in-memory (nothing persists).

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run memcached --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `memcached`, custom registry
`github.com/Nomploy/nomad-packs`, then Deploy.

Point your app's memcached client at `<node-ip>:11211`.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `memcached:alpine` | Pin a tag in production. |
| `port` | `11211` | Listen port. |
| `memory_limit` | `256` | Max cache size in MB (`-m`); LRU eviction when full. |
| `constraints` | `[]` | Placement. |
| `resources` | `cpu 200 / mem 320` | Keep task memory above `memory_limit`. |

## Notes

- **No persistence** — it's a cache; a restart empties it. That's expected.
- **No auth.** Memcached has no authentication; keep it on a trusted/internal network.
- Prefer `redis` if you need persistence, data structures, or pub/sub; `memcached` is for
  simple, volatile object caching.
