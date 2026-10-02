# langfuse

[Langfuse](https://langfuse.com) is an open-source LLM engineering platform — tracing,
evaluations, prompt management, datasets and metrics for AI applications (an open
alternative to LangSmith).

This pack runs Langfuse **all-in-one** as a single host-networked Nomad job:

- **web** — the Langfuse UI / API (`docker.langfuse.com/langfuse/langfuse:4`)
- **worker** — background processing (`docker.langfuse.com/langfuse/langfuse-worker:4`)
- **postgres** — transactional store (prestart sidecar)
- **clickhouse** — analytics / OLAP store for traces (prestart sidecar)
- **redis** — cache and queue (prestart sidecar)
- **minio** — S3-compatible blob store for events and media (prestart sidecar)

All tasks share the host network and talk to each other over `127.0.0.1`, so no mesh
networking is required. Database and ClickHouse migrations run automatically on first
start.

## Requirements

This is a heavy stack (six containers). Schedule it on a node with **~8 GB free RAM**.
On a nomploy cluster, pin it to the control plane with a constraint on
`${meta.nomploy_control_plane}` (see `constraints`).

## Quick start

```sh
nomad-pack run langfuse --registry=nomploy
```

Then open `http://<node-ip>:3000` and create the first user and organization.

## Configuration

| Variable | Default | Notes |
|----------|---------|-------|
| `port` | `3000` | Web UI / API host port |
| `nextauth_url` | `http://localhost:3000` | Public URL (auth callbacks, links) |
| `nextauth_secret` | *change me* | Session signing secret — keep stable |
| `salt` | *change me* | API-key hashing salt — keep stable |
| `encryption_key` | `0000…` | 64 hex chars (`openssl rand -hex 32`) — keep stable |
| `db_password` | *change me* | Bundled PostgreSQL password |
| `clickhouse_password` | *change me* | Bundled ClickHouse password |
| `redis_password` | *change me* | Bundled Redis password |
| `minio_root_password` | *change me* | Bundled MinIO root/secret password |
| `s3_public_endpoint` | `http://localhost:9100` | Browser-reachable MinIO URL for media links |

Change every secret before deploying anywhere real, and keep `nextauth_secret`,
`salt` and `encryption_key` stable across deploys (rotating `encryption_key` makes
previously stored secrets unreadable).

Data persists in the `langfuse_db_data`, `langfuse_clickhouse_data` and
`langfuse_minio_data` named volumes.
