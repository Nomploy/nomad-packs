# kafka

[Apache Kafka](https://kafka.apache.org) is a distributed event-streaming
platform used for high-throughput publish/subscribe messaging, stream
processing, log aggregation and event sourcing. This pack runs a **single-node
KRaft broker** (combined broker + controller, no ZooKeeper) — perfect for
development, testing and small self-hosted workloads.

## Deploy

```bash
nomad-pack run kafka --registry=nomploy --var advertised_host=10.0.0.5
```

Connect a client to `<advertised_host>:9092`, e.g.:

```bash
kafka-console-producer.sh --bootstrap-server <node-ip>:9092 --topic demo
```

## Configuration

| Variable          | Default              | Description                                       |
| ----------------- | -------------------- | ------------------------------------------------- |
| `image`           | `apache/kafka:3.9.1` | Container image (pin a tag in production).           |
| `port`            | `9092`               | Host port for the PLAINTEXT client listener.       |
| `controller_port` | `9093`               | Host port for the KRaft controller listener.       |
| `advertised_host` | `localhost`          | Address clients use to reach the broker.           |
| `data_volume`     | `kafka_data`         | Volume for log data (`/var/lib/kafka/data`).        |
| `resources`       | 1000 MHz / 1536 MB   | CPU and memory for the task.                        |

> **Important:** Set `advertised_host` to the node's reachable IP/DNS name so
> external clients can connect; with the default `localhost` only clients on the
> same node work. This single-node broker uses replication factor 1 — not
> redundant. The image auto-formats KRaft storage on first start.
