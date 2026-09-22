# rustdesk

[RustDesk](https://rustdesk.com) Server — self-hosted infrastructure for the RustDesk
remote-desktop client. Runs the ID/rendezvous server (**hbbs**) and relay server (**hbbr**) in a
single supervised (s6) container, so you can run remote support with no third-party servers.

Host-networked, with a volume for the generated server keys.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run rustdesk --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `relay_host` | `""` | Public IP/hostname for the relay (`RELAY`), port 21117 appended. |
| `encrypted_only` | `0` | `ENCRYPTED_ONLY` — set `1` to reject unencrypted connections. |
| `data_volume` | `rustdesk_data` | `/data` — server keys + database. |
| `image` | `rustdesk/rustdesk-server-s6:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 128 }` | Task resources. |

Ports 21115–21119 (TCP) and 21116 (UDP) are exposed on the host. In the RustDesk client, set the
**ID Server** to this host and paste the server's **public key** (`/data/id_ed25519.pub`, printed
on first start). For internet access, forward those ports. Pin the job to the node holding the
volume with `constraints`.
