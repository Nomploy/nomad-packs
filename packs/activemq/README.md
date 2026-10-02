# activemq

[Apache ActiveMQ Artemis](https://activemq.apache.org) is a high-performance,
multi-protocol message broker. One broker speaks **AMQP, MQTT, STOMP, OpenWire
and core JMS**, with durable queues and topics, large-message and flow control,
clustering, and a web management console (Hawtio) for queues, addresses and
diagnostics.

This pack runs ActiveMQ Artemis as a single host-networked Nomad service.

## Deploy

```bash
nomad-pack run activemq --registry=nomploy \
  --var admin_password=$(openssl rand -hex 16)
```

Open `http://<node-ip>:8161/console` and log in as `admin`.

## Configuration

| Variable         | Default                                | Description                                   |
| ---------------- | -------------------------------------- | --------------------------------------------- |
| `image`          | `apache/activemq-artemis:latest-alpine`| Container image (pin a tag in production).        |
| `port`           | `8161`                                 | Web management console.                        |
| `core_port`      | `61616`                                | Core / OpenWire protocol.                      |
| `amqp_port`      | `5672`                                 | AMQP.                                           |
| `mqtt_port`      | `1883`                                 | MQTT.                                           |
| `stomp_port`     | `61613`                                | STOMP.                                          |
| `admin_user`     | `admin`                                | Broker admin username.                          |
| `admin_password` | `activemq_change_me`                   | Broker admin password — **change this**.        |
| `data_volume`    | `activemq_data`                        | Volume for the broker instance.                 |
| `resources`      | 1000 MHz / 1024 MB                     | CPU and memory for the task.                     |

The broker instance persists in `data_volume` at `/var/lib/artemis-instance`.
