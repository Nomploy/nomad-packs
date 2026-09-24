# dufs

[Dufs](https://github.com/sigoden/dufs) — a tiny, fast file server in a single binary. Static serving,
uploads and downloads, search, resumable transfers, and full **WebDAV**, with optional per-path access
control. Perfect for quickly sharing a directory over HTTP or mounting it as a network drive.

Single host-networked Nomad service that serves a data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run dufs --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `5001` | File server port. |
| `allow_all` | `false` | Allow uploads/deletes/renames (`-A`). Default is **read-only**. |
| `auth` | `""` | Access-control rule (`-a`), e.g. `user:pass@/:rw`. Empty = no auth. |
| `data_volume` | `dufs_data` | `/data` — the served directory. |
| `image` | `sigoden/dufs:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 200, memory = 128 }` | Task resources. |

By default the volume is served **read-only to anyone** who can reach the port. Set `allow_all=true` for
write access and add an `auth` rule to require a login (e.g. `admin:secret@/:rw` for a read-write admin, or
`@/:ro` for public read-only). Mount it as WebDAV in your OS file manager. Serves plain HTTP — front it
with a reverse proxy for TLS or keep it internal. Pin the job to the node holding the volume with
`constraints`.
