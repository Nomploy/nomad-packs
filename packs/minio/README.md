# minio

[MinIO](https://min.io) — a high-performance, S3-compatible object storage server. Use it as a
drop-in S3 backend for backups, application uploads, build artifacts, and anything that speaks the
S3 API, with a web console for managing buckets, users, and access keys.

Single host-networked Nomad service with a persistent `/data` volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run minio --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `9000` | S3 API port (`--address`). |
| `console_port` | `9001` | Web console port (`--console-address`). |
| `root_user` | `minioadmin` | `MINIO_ROOT_USER` (≥ 3 chars). |
| `root_password` | `change-me-…` | `MINIO_ROOT_PASSWORD` — **change it** (≥ 8 chars). |
| `data_volume` | `minio_data` | `/data` — all buckets and objects. |
| `image` | `minio/minio:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. |

Open the console at `http://<node-ip>:9001`, or point an S3 client at
`http://<node-ip>:9000` (region `us-east-1`). Serves plain HTTP — front it with a reverse proxy for
TLS. This is a **single-node** deployment (great for backups/artifacts/app storage); pin it to the
node holding the volume with `constraints`. Pairs well with the `backup` pack (restic → S3).
