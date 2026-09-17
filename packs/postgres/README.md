# postgres

PostgreSQL as a host-networked Nomad `service` with a **persistent Docker named
volume**, so data survives restarts and reschedules.

## Usage

```
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run postgres --registry nomploy \
  --var db_password=change-me --var db_name=myapp
```

Or in nomploy: **Create → Nomad Pack**, pick `postgres` from the Nomploy registry.

## Variables

| Variable | Default | Description |
|---|---|---|
| `job_name` | `postgres` | Nomad job name |
| `image` | `postgres:16-alpine` | Container image |
| `port` | `5432` | Host port (pick a free one per node) |
| `count` | `1` | Keep at 1 (local-disk storage) |
| `db_name` | `app` | Initial database |
| `db_user` | `app` | Superuser role |
| `db_password` | `postgres` | **Change this** |
| `data_volume` | `postgres_data` | Docker named volume for `/var/lib/postgresql/data` |
| `constraints` | `[]` | Pin placement so the local volume stays put |
| `resources` | `{cpu=500, memory=512}` | Task resources |

## Notes

- **Persistence:** uses a Docker named volume (not an alloc bind), so a fresh
  volume is initialized from the image's data dir (ownership included) and the DB
  can write it. Pin the job with `constraints` so it always lands on the node that
  holds the volume.
- **Password** is baked into the job env — rotate it and prefer a Nomad variable
  or Vault for real deployments.
