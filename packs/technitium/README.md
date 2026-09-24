# technitium

[Technitium DNS Server](https://technitium.com/dns/) — a full-featured, self-hosted DNS server. It works
as an authoritative server for your own zones **and** a recursive/forwarding resolver, with network-wide
ad-blocking, DNS-over-HTTPS/TLS/QUIC, an optional DHCP server, query logs, and a polished web console. A
powerful Pi-hole / NextDNS alternative that can also host real DNS zones.

Single host-networked Nomad service with a persistent config volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run technitium --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `dns_port` | `53` | DNS query port (UDP + TCP). |
| `web_port` | `5380` | Web console port (`DNS_SERVER_WEB_SERVICE_HTTP_PORT`). |
| `admin_password` | `change-me-please` | Console admin password (`DNS_SERVER_ADMIN_PASSWORD`). **Change it.** |
| `data_volume` | `technitium_config` | `/etc/dns` — settings and zones. |
| `image` | `technitium/dns-server:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 256 }` | Task resources. |

Log in to the console as `admin`, set forwarders, enable ad-block lists, or add your own zones, then
point clients' DNS at `<node-ip>`.

> **Port 53:** binding it requires that nothing else on the node already listens there. On many Linux
> hosts you must first disable systemd-resolved's stub listener (`DNSStubListener=no` in
> `/etc/systemd/resolved.conf`). Pin the job to the node holding the volume with `constraints`.
