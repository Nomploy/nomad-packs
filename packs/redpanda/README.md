# redpanda

[Redpanda](https://redpanda.com) — a Kafka-compatible streaming data platform in a single binary
(no ZooKeeper, no JVM), with a Kafka API, HTTP (Panda) Proxy, and Schema Registry. A lighter
drop-in for Apache Kafka.

Single-node **dev-container** instance, host-networked with a data volume and a busybox chown init.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run redpanda --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `kafka_port` | `9092` | Kafka API. |
| `admin_port` | `9644` | Admin API. |
| `proxy_port` | `8082` | HTTP (Panda) Proxy. |
| `schema_port` | `8081` | Schema Registry. |
| `advertise_host` | `127.0.0.1` | Host advertised to Kafka clients — **set to the node IP for remote clients.** |
| `uid` | `101` | User Redpanda runs as; data volume is chown'd to it. |
| `data_volume` | `redpanda_data` | `/var/lib/redpanda/data`. |
| `image` | `redpandadata/redpanda:latest` | Image. Pin a tag in production. |
| `resources` | `{ cpu = 1000, memory = 1024 }` | Task resources. |

> **`advertise_host`** is the classic Kafka footgun: clients connect to the advertised address, so
> `127.0.0.1` only works for producers/consumers on the same host — set the node IP otherwise. This
> is a **single-node dev-container** deployment, not a production cluster. Ports `8081`/`8082`
> overlap some other packs' defaults; change them if co-locating. Pin the job with `constraints`.
