# adguardhome

[AdGuard Home](https://adguard.com/adguard-home/overview.html) — a network-wide DNS server that
blocks ads, trackers, and malware for every device on your network, with a web dashboard, filter
lists, DNS-over-HTTPS/TLS, and per-client rules.

Single host-networked Nomad service with `work` and `conf` volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run adguardhome --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `dns_port` | `53` | DNS server port (TCP + UDP). |
| `setup_port` | `3000` | First-run setup wizard port. |
| `web_port` | `80` | Admin dashboard port (pick this in the wizard). |
| `work_volume` | `adguardhome_work` | `/opt/adguardhome/work` — query log, stats, filters. |
| `conf_volume` | `adguardhome_conf` | `/opt/adguardhome/conf` — configuration. |
| `image` | `adguard/adguardhome:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

## First run

Open `http://<node-ip>:3000`, run the wizard, keep the admin interface on `web_port` and DNS on
`dns_port`, and create your login. Then set your router's (or devices') DNS to `<node-ip>`.

> Port `53` must be free on the host — a `systemd-resolved` stub listener commonly holds it;
> disable `DNSStubListener` or choose another `dns_port`. Pin the job to the node holding the
> volumes with `constraints`.
