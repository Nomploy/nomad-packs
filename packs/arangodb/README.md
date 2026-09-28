# arangodb

[ArangoDB](https://arangodb.com) is a multi-model database that combines three
data models — **documents, graphs and key/value** — in one engine, queried with
a single declarative language (AQL). It ships with a polished web UI, graph
traversals, full-text search (ArangoSearch) and Foxx microservices.

This pack runs a single ArangoDB instance as a host-networked Nomad service.

## Deploy

```bash
nomad-pack run arangodb --registry=nomploy \
  --var root_password=$(openssl rand -hex 16)
```

Open `http://<node-ip>:8529` and log in as `root`.

## Configuration

| Variable        | Default                    | Description                                  |
| --------------- | -------------------------- | -------------------------------------------- |
| `image`         | `arangodb/arangodb:3.12.12`| Container image (pin a tag in production).      |
| `port`          | `8529`                     | Host port for the server / web UI.            |
| `root_password` | `arangodb_change_me`       | Root password — **change this**.              |
| `data_volume`   | `arangodb_data`            | Volume for database files (`/var/lib/arangodb3`).|
| `apps_volume`   | `arangodb_apps`            | Volume for Foxx apps.                          |
| `resources`     | 1000 MHz / 2048 MB         | CPU and memory for the task.                   |

Data and Foxx apps persist across restarts and upgrades. The root password is
set only on the first start (empty data directory).
