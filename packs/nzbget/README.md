# nzbget

[NZBGet](https://nzbget.com/) — a fast, resource-efficient **Usenet (NZB) downloader** with a clean web UI. Low CPU and
memory use makes it a great download client for the *arr stack or standalone Usenet grabbing.

Single host-networked Nomad service with config and downloads volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run nzbget --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `6789` | Web UI port. |
| `username` | `nzbget` | Web UI username (`NZBGET_USER`). |
| `password` | `tegbzn6789` | **Change this.** Web UI password (`NZBGET_PASS`). |
| `image` | `lscr.io/linuxserver/nzbget:latest` | Container image. Pin a tag in production. |
| `data_volume` | `nzbget_data` | `/config` — settings. |
| `downloads_volume` | `nzbget_downloads` | `/downloads` — your downloads. |
| `puid` / `pgid` | `1000` / `1000` | User/group that owns the files (`PUID`/`PGID`). |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> Add your Usenet provider and indexers in the UI. **Pairs with** [prowlarr](https://packs.nomploy.com/packs/prowlarr)
> and the *arr apps — share the `/downloads` path so they can import. Change the default password, and pin the job to
> the node holding the volumes with `constraints`.
