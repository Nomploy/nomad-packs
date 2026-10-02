# pulsar

[Apache Pulsar](https://pulsar.apache.org) is a cloud-native, distributed
messaging and streaming platform. It unifies **pub/sub and queuing**, with
multi-tenancy, geo-replication, tiered storage, per-message acknowledgement and
Pulsar Functions — a powerful alternative to Kafka or RabbitMQ for event-driven
systems.

This pack runs Pulsar in **standalone** mode (broker + BookKeeper + metadata in
one container) as a single host-networked Nomad service — ideal for a single
node.

## Deploy

```bash
nomad-pack run pulsar --registry=nomploy
```

Clients connect to `pulsar://<node-ip>:6650`; the admin/REST API is on
`http://<node-ip>:8080`.

## Configuration

| Variable      | Default                              | Description                                 |
| ------------- | ------------------------------------ | ------------------------------------------- |
| `image`       | `apachepulsar/pulsar:latest`         | Container image (pin a tag in production).      |
| `broker_port` | `6650`                               | Binary protocol (`pulsar://`).               |
| `http_port`   | `8080`                               | Admin / REST HTTP service.                   |
| `pulsar_mem`  | `-Xms1g -Xmx1g -XX:MaxDirectMemorySize=512m` | JVM memory flags — raise for load.   |
| `data_volume` | `pulsar_data`                        | Volume for BookKeeper + metadata (`/pulsar/data`).|
| `resources`   | 1500 MHz / 2560 MB                   | CPU and memory for the task.                  |

> Standalone mode suits a single node. Data persists in `data_volume`. For a
> production cluster, deploy ZooKeeper/metadata, BookKeeper and brokers as
> separate jobs, and keep `pulsar_mem` within the task's memory limit.
