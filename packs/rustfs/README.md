# rustfs

[RustFS](https://github.com/rustfs/rustfs) — a high-performance, **S3-compatible object storage** server written in
Rust, with a built-in web console. Apache-2.0 licensed, it's a drop-in MinIO alternative for backups, app storage
and static assets — use it with any S3 client or SDK.

Single host-networked Nomad service exposing the S3 API and the console, backed by one persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run rustfs --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `9000` | S3 API port (`RUSTFS_ADDRESS`). |
| `console_port` | `9001` | Web console port (`RUSTFS_CONSOLE_ADDRESS`). |
| `access_key` | `rustfsadmin` | **Change this.** Root access key (`RUSTFS_ACCESS_KEY`). |
| `secret_key` | `rustfsadmin` | **Change this.** Root secret key (`RUSTFS_SECRET_KEY`). |
| `image` | `rustfs/rustfs:latest` | Container image. Pin a tag in production. |
| `data_volume` | `rustfs_data` | `/data` — object storage. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. Bump for heavy workloads. |

> A prestart init task chowns the data volume to uid `10001` (RustFS runs unprivileged). Point S3 clients at
> `http://<host>:9000` with the access/secret keys; the console is on `:9001`. Pin the job to the node holding the
> volume with `constraints` and back it up.
