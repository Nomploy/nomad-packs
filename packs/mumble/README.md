# mumble

[Mumble](https://www.mumble.info) — a low-latency, high-quality voice chat server (Murmur) for gaming
and teams, with channels, ACLs, and strong encryption.

Single host-networked Nomad service with a data volume. A busybox prestart task chowns the data
volume to the server's UID.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run mumble --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `64738` | Server port (TCP + UDP). |
| `superuser_password` | `changeme-please` | SuperUser admin password. **Change it.** |
| `uid` | `1000` | User the server runs as; data volume is chown'd to it. |
| `data_volume` | `mumble_data` | `/data` — server database + config. |
| `image` | `mumblevoip/mumble-server:latest` | Image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 128 }` | Task resources. |

Connect any Mumble client to `<node-ip>:64738`. Log in as **SuperUser** to administer. For internet
use, forward TCP+UDP `64738`. Pin the job to the node holding the volume with `constraints`.
