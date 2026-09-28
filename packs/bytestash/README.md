# bytestash

[ByteStash](https://github.com/jordan-dalby/ByteStash) is a self-hosted app for
storing, organising and sharing your code snippets. It offers syntax
highlighting for many languages, tags and full-text search, version history,
public/private sharing links, and a clean, fast UI — a tidy home for all those
snippets you keep losing in chat and gists.

This pack runs ByteStash as a single host-networked Nomad service backed by
SQLite.

## Deploy

```bash
nomad-pack run bytestash --registry=nomploy \
  --var jwt_secret=$(openssl rand -hex 24)
```

Open `http://<node-ip>:5000` and register the first account.

## Configuration

| Variable             | Default                              | Description                              |
| -------------------- | ------------------------------------ | ---------------------------------------- |
| `image`              | `ghcr.io/jordan-dalby/bytestash:latest` | Container image (pin a tag).             |
| `port`               | `5000`                               | Host port for the web UI.                 |
| `jwt_secret`         | placeholder                          | Auth-token secret — **change this**.      |
| `allow_new_accounts` | `true`                               | Allow new account registration.           |
| `data_volume`        | `bytestash_data`                     | Volume for the DB and snippets (`/data/snippets`).|
| `resources`          | 200 MHz / 256 MB                     | CPU and memory for the task.              |

Snippets and the SQLite database persist in `data_volume`. Set
`allow_new_accounts=false` once your users are registered.
