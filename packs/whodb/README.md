# whodb

[WhoDB](https://whodb.com) is a fast, lightweight database explorer with a
clean UI, an interactive **graph-based schema view** and natural-language
querying (via an LLM of your choice). It connects to PostgreSQL, MySQL/MariaDB,
SQLite, MongoDB, Redis, ClickHouse, ElasticSearch and more — a friendly
alternative to Adminer or phpMyAdmin.

This pack runs WhoDB as a single host-networked Nomad service.

## Deploy

```bash
nomad-pack run whodb --registry=nomploy \
  --var encryption_key=$(openssl rand -hex 32)
```

Open `http://<node-ip>:8080` and enter your database connection details.

## Configuration

| Variable         | Default              | Description                                    |
| ---------------- | -------------------- | ---------------------------------------------- |
| `image`          | `clidey/whodb:latest`| Container image (pin a tag in production).       |
| `port`           | `8080`               | Host port for the web UI.                        |
| `encryption_key` | placeholder (64 hex) | Encrypts saved login sessions — **change this**. |
| `data_volume`    | `whodb_data`         | Volume for persisted sessions (`/data`).         |
| `resources`      | 300 MHz / 256 MB     | CPU and memory for the task.                      |

WhoDB is a client that connects to your existing databases; connection details
are entered in the UI and (optionally) persisted, encrypted, in `data_volume`.
Set `WHODB_SECURE=true` when serving over HTTPS.
