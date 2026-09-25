# ddns-updater

[DDNS Updater](https://github.com/qdm12/ddns-updater) — keeps your **dynamic-DNS** records pointed at your current
public IP. It supports dozens of providers (Cloudflare, Namecheap, DuckDNS, DigitalOcean, Gandi, deSEC, and many
more), checks your IP on a schedule, updates records only when they change, and shows status + history in a small web
dashboard.

Single host-networked Nomad service with a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run ddns-updater --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8000` | Web UI port (`LISTENING_ADDRESS`). |
| `config_json` | `""` | Optional inline JSON config (`CONFIG` env). Takes precedence over the file. See below. |
| `image` | `qmcgaw/ddns-updater:latest` | Container image. Pin a tag in production. |
| `data_volume` | `ddns_updater_data` | `/updater/data` — `config.json` and update history. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> **You must add your records.** Two ways: set `config_json` to your provider config (recommended for GitOps), e.g.
> `{"settings":[{"provider":"cloudflare","zone_identifier":"...","domain":"example.com","host":"@","ttl":300,"token":"..."}]}`,
> or leave it empty and edit `config.json` in the data volume (the pack seeds an empty `{"settings":[]}`). See the
> provider docs for the exact fields. A prestart init task chowns the volume to uid `1000`.
