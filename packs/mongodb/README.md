# mongodb

[MongoDB](https://www.mongodb.com/community) is a widely used, general-purpose
document (NoSQL) database. It stores flexible JSON-like documents, scales
horizontally and is the backend for a huge range of self-hosted applications.

This pack runs a single MongoDB instance as a host-networked Nomad service with
**authentication enabled** via a root account.

## Deploy

```bash
nomad-pack run mongodb --registry=nomploy \
  --var root_password=$(openssl rand -hex 16)
```

Connect with `mongodb://root:<password>@<node-ip>:27017/?authSource=admin`.

## Configuration

| Variable        | Default            | Description                                   |
| --------------- | ------------------ | --------------------------------------------- |
| `image`         | `mongo:7.0`        | Container image (5.0+ needs AVX; pin a tag).    |
| `port`          | `27017`            | Host port for MongoDB.                          |
| `root_username` | `root`             | Root username created on first start.           |
| `root_password` | `mongodb_change_me`| Root password — **change this**.                |
| `data_volume`   | `mongodb_data`     | Volume for data (`/data/db`).                    |
| `resources`     | 500 MHz / 1024 MB  | CPU and memory for the task.                     |

> **Note:** MongoDB 5.0+ requires a CPU with AVX support. On older CPUs, pin
> `image` to `mongo:4.4`.

Data persists in `data_volume`. The root account is created only on the very
first start (when the data directory is empty).
