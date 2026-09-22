# verdaccio

[Verdaccio](https://verdaccio.org) — a lightweight private npm registry and proxy: publish
private packages, cache/proxy npmjs, and control access with users and scopes.

Single host-networked Nomad service. A busybox prestart task chowns the storage volume to
Verdaccio's UID (it runs non-root, uid 10001). The image's bundled `config.yaml` is used as-is
(it proxies npmjs); mount your own to customize.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run verdaccio --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `4873` | Registry / web UI port (`VERDACCIO_PORT`). |
| `uid` / `gid` | `10001` / `65533` | User Verdaccio runs as; storage volume is chown'd to it. |
| `storage_volume` | `verdaccio_storage` | `/verdaccio/storage` — packages + htpasswd. |
| `image` | `verdaccio/verdaccio:6` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

## Use

```sh
npm set registry http://<node-ip>:4873/
npm adduser --registry http://<node-ip>:4873/   # first user; then npm publish
```

The default config lets any logged-in user publish and proxies npmjs. To restrict access, mount
a custom `/verdaccio/conf/config.yaml`. Pin the job to the node holding the volume with
`constraints`.
