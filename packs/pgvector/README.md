# pgvector

[pgvector](https://github.com/pgvector/pgvector) on PostgreSQL — a ready-to-use Postgres server with the
**pgvector** extension for storing embeddings and running vector similarity search directly in your relational
database. Keep your app data and your vectors in one place — ideal as the retrieval store for RAG and semantic
search.

Single host-networked Nomad service with a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run pgvector --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `5432` | PostgreSQL port. |
| `db_name` | `app` | Initial database (`POSTGRES_DB`). |
| `db_user` | `postgres` | Superuser (`POSTGRES_USER`). |
| `db_password` | `change-me-please` | Password (`POSTGRES_PASSWORD`). **Change it.** |
| `data_volume` | `pgvector_data` | `/var/lib/postgresql/data` — all databases and vectors. |
| `image` | `pgvector/pgvector:pg16` | Image (match the tag to your Postgres major version). Pin in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. |

Enable the extension once per database, then use vector columns:

```sql
CREATE EXTENSION IF NOT EXISTS vector;
CREATE TABLE items (id bigserial PRIMARY KEY, embedding vector(1536));
-- nearest neighbors: ORDER BY embedding <-> '[...]' LIMIT 5;
```

A drop-in vector store for the `ollama` / `open-webui` / `anythingllm` packs. Serves an **unencrypted** SQL
port — keep it on an internal network. Pin the job to the node holding the volume with `constraints`.
