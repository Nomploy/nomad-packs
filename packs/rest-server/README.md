# rest-server

[Restic REST Server](https://github.com/restic/rest-server) — a high-performance HTTP backend
for [restic](https://restic.net) backups. Faster than the SFTP/S3 backends, and its
**append-only** mode means a compromised client can create and read snapshots but never delete
them.

Single host-networked Nomad service with a data volume for repositories. Pairs with the
[backup](../backup) pack as its restic target (an alternative to the S3/SeaweedFS route).

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run rest-server --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8000` | REST API / repository endpoint. |
| `data_volume` | `rest_server_data` | `/data` — repositories + `.htpasswd`. |
| `disable_auth` | `true` | Disable HTTP basic auth (trusted network). Set `false` and create users otherwise. |
| `append_only` | `true` | Clients can't delete snapshots; prune server-side. |
| `extra_options` | `""` | Extra server flags, e.g. `--private-repos`, `--prometheus`. |
| `image` | `restic/rest-server:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 128 }` | Task resources. |

## Use from restic

```sh
export RESTIC_REPOSITORY="rest:http://<node-ip>:8000/myrepo"
export RESTIC_PASSWORD="..."
restic init && restic backup /path
```

With `disable_auth = false`, create users (writes `.htpasswd` on the volume):

```sh
nomad alloc exec -task rest-server <alloc> create_user <username>
```

then use `rest:http://<user>:<pass>@<node-ip>:8000/`. Auth-off should stay on a trusted network
or behind TLS + auth. Pin the job to the node holding `data_volume` with `constraints`.
