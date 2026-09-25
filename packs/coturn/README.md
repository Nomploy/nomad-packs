# coturn

[coturn](https://github.com/coturn/coturn) — a mature **TURN and STUN** server. It relays WebRTC media when two
peers can't connect directly (behind NAT or strict firewalls), which is what makes self-hosted **video calls**
reliable — the missing piece for Jitsi, Nextcloud Talk, and Matrix (Element) calls.

Single host-networked Nomad service with static long-term credentials.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run coturn --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3478` | Main TURN/STUN port (TCP + UDP). |
| `realm` | `turn.example.com` | TURN realm — usually your domain (`--realm`). |
| `turn_user` / `turn_password` | `turn` / `change-me-…` | Long-term credentials (`--user`). **Change the password.** |
| `external_ip` | `""` | Public IP to advertise (`--external-ip`); set it if behind 1:1 NAT. |
| `min_port` / `max_port` | `49160` / `49200` | UDP relay port range. **Open it on the firewall.** |
| `image` | `coturn/coturn:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 128 }` | Task resources. |

Point your app's ICE config at `turn:<realm>:3478` with the username/password. **The UDP relay range
(`min_port`–`max_port`) must be reachable from the internet**, and set `external_ip` for nodes behind 1:1 NAT.
Because the pack is host-networked, the relay ports bind directly with no per-port docker-proxy. Keep the range
small unless you expect many concurrent calls.
