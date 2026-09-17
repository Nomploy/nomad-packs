# seaweedfs

[SeaweedFS](https://seaweedfs.com) — a fast, **Apache-2.0** distributed file/object
store with an S3-compatible API. A lightweight, fully open-source alternative to MinIO
for object storage: backup targets, a storage backend for Loki / the zot registry /
Fleet software installers, or app assets.

This pack is **single-node all-in-one**: it runs `weed server -s3`, which starts the
master, a volume server, a filer and the S3 gateway in one process, host-networked,
with all state on a persistent Docker volume.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run seaweedfs --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `seaweedfs`, custom
registry `github.com/Nomploy/nomad-packs`, then Deploy.

## Endpoints

- **S3 API** — `http://<node-ip>:8333` (use **path-style** addressing).
- **Master UI** — `http://<node-ip>:9333`
- **Filer UI** — `http://<node-ip>:8888`

SeaweedFS also binds the gRPC ports `master_port+10000`, `volume_port+10000`,
`filer_port+10000` on the host.

## Authentication

Follows the same optional-auth pattern as the `zot` pack:

- Leave **both** `access_key` and `secret_key` empty → S3 runs **open** (Allow-All,
  anonymous). Fine for a trusted internal network.
- Set **both** → an `admin` identity with full permissions is rendered into the S3
  config, and authentication becomes mandatory for every S3 request.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `chrislusf/seaweedfs:latest` | Pin a tag in production. |
| `s3_port` | `8333` | The S3 endpoint. |
| `master_port` / `volume_port` / `filer_port` | `9333` / `8080` / `8888` | Change `volume_port` if `8080` is taken. |
| `access_key` / `secret_key` | `""` | Both empty = open; both set = auth required. |
| `data_volume` | `seaweedfs_data` | All state — back it up. |
| `constraints` | `[]` | Pin to a node so the local volume stays put. |
| `resources` | `cpu 500 / mem 512` | Raise memory for large datasets. |

## Quick test

```sh
aws --endpoint-url http://<node-ip>:8333 s3 mb s3://test
aws --endpoint-url http://<node-ip>:8333 s3 cp ./file s3://test/
aws --endpoint-url http://<node-ip>:8333 s3 ls s3://test/
```

With auth enabled, configure the access/secret key first (`aws configure`) and keep
`--endpoint-url` path-style.

## Notes

- **Single node.** `count` is fixed to 1 and data is on a local volume — pin the job
  with `constraints`. For a scale-out cluster, run separate master/volume/filer jobs.
- **Backups:** snapshot the `data_volume`; it holds both objects and metadata.
