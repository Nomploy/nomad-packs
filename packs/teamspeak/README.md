# teamspeak

[TeamSpeak 3](https://www.teamspeak.com) — a low-latency **voice-chat** server popular with gamers and
communities. Hierarchical channels, fine-grained permissions, server groups, and a ServerQuery admin API.

Single host-networked Nomad service with a persistent data volume. Uses the **free, non-commercial** TeamSpeak
license (`TS3SERVER_LICENSE=accept`).

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run teamspeak --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `voice_port` | `9987` | UDP voice port. |
| `query_port` | `10011` | TCP ServerQuery (admin) port. |
| `filetransfer_port` | `30033` | TCP file-transfer port. |
| `data_volume` | `teamspeak_data` | `/var/ts3server` — database, config, files. |
| `image` | `teamspeak:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

**First boot:** the server logs a one-time **ServerAdmin privilege key** — read it with `nomad alloc logs` and
paste it into your TeamSpeak client to claim admin. Connect clients to `<node-ip>:9987` (UDP). This is the
free non-commercial edition (max 32 slots). Pin the job to the node holding the volume with `constraints`.
