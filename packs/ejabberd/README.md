# ejabberd

[ejabberd](https://www.ejabberd.im) is a battle-tested, massively scalable XMPP
(Jabber) server. It powers real-time one-to-one and group chat (MUC), presence,
push notifications, file transfer, MAM message archiving and more, with a web
admin, a rich command API, and support for millions of concurrent users.

This pack runs ejabberd (the official `ecs` image) as a single host-networked
Nomad service.

## Deploy

```bash
nomad-pack run ejabberd --registry=nomploy \
  --var xmpp_domain=chat.example.com \
  --var admin_password=$(openssl rand -hex 12)
```

Connect an XMPP client to `<node-ip>:5222` (domain = your `xmpp_domain`), or open
the web admin at `http://<node-ip>:5280/admin/`.

## Configuration

| Variable         | Default               | Description                                    |
| ---------------- | --------------------- | ---------------------------------------------- |
| `image`          | `ejabberd/ecs:latest` | Container image (pin a tag in production).         |
| `c2s_port`       | `5222`                | Client-to-server XMPP port.                     |
| `s2s_port`       | `5269`                | Server-to-server (federation) port.             |
| `admin_port`     | `5280`                | Web admin / HTTP API port.                      |
| `xmpp_domain`    | `localhost`           | Your XMPP virtual host.                          |
| `admin_user`     | `admin`               | Admin account localpart.                         |
| `admin_password` | `ejabberd_change_me`  | Admin password (first start) — **change this**.  |
| `data_volume`    | `ejabberd_data`       | Volume for the database (`/home/ejabberd/database`).|
| `resources`      | 500 MHz / 512 MB      | CPU and memory for the task.                     |

For remote clients and federation, set `xmpp_domain` to a real domain and publish
the matching DNS SRV records. Accounts and message data persist in `data_volume`.
