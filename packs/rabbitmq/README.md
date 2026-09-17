# rabbitmq

[RabbitMQ](https://www.rabbitmq.com) — a mature, widely-used message broker (AMQP 0-9-1,
with MQTT/STOMP available), deployed with its **management UI** enabled. A common
dependency for apps that need work queues, pub/sub, or task processing (Celery, Sidekiq,
etc.).

Host-networked Nomad service with a persistent Docker volume. The node name is pinned to
`rabbit@localhost` so the Mnesia data directory stays stable across reschedules.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run rabbitmq --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `rabbitmq`, custom
registry `github.com/Nomploy/nomad-packs`, then Deploy.

- **AMQP** — `amqp://admin:<password>@<node-ip>:5672/`
- **Management UI** — `http://<node-ip>:15672` (login with the same credentials)

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `rabbitmq:4-management` | Use a `-management` tag for the UI. Pin in production. |
| `amqp_port` | `5672` | Client connections. |
| `management_port` | `15672` | Web UI / HTTP API. |
| `default_user` / `default_password` | `admin` / `rabbitmq` | Admin created on **first boot**. Change the password. |
| `data_volume` | `rabbitmq_data` | Mnesia store. Back it up. |
| `constraints` | `[]` | Pin to a node so the local volume stays put. |
| `resources` | `cpu 500 / mem 512` | Raise for heavy throughput. |

## Notes

- **Single node.** `count` is fixed to 1 with local storage. Pin it with `constraints`.
  For a RabbitMQ cluster you need multiple coordinated nodes with a shared Erlang cookie —
  out of scope for this pack.
- The built-in `guest` user only works from `localhost`; remote clients must use
  `default_user`.
- Credentials/ports come from a rendered `rabbitmq.conf`. The admin user is created only
  on first boot with an empty data volume.
- **Backups:** snapshot the `data_volume`, and export definitions from the management UI
  (Overview → Export definitions) for a portable copy of vhosts/users/queues.
