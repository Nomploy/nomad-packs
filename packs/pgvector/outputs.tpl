PostgreSQL + pgvector deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Connect:   psql postgres://[[ var "db_user" . ]]:<password>@<node-ip>:[[ var "port" . ]]/[[ var "db_name" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (/var/lib/postgresql/data) — back it up

Enable the extension once per database, then create a vector column:
  CREATE EXTENSION IF NOT EXISTS vector;
  CREATE TABLE items (id bigserial PRIMARY KEY, embedding vector(1536));
Query nearest neighbors with the <-> / <=> operators. Great as the store for the ollama / open-webui packs.
Serves an unencrypted SQL port — keep it internal.
