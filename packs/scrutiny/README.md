# scrutiny

[Scrutiny](https://github.com/AnalogJ/scrutiny) — a modern web dashboard for hard-drive **S.M.A.R.T.** health
monitoring. It goes beyond raw `smartctl` output: historical trends per attribute, sane thresholds informed by
real-world failure data (Backblaze), and clear pass/warn/fail status per disk. This pack uses the **omnibus** image,
which bundles the web UI, the metrics collector, and InfluxDB in one container.

Single host-networked Nomad service with persistent config and time-series volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run scrutiny --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8080` | Web UI port (`SCRUTINY_WEB_LISTEN_PORT`). |
| `disks` | `["/dev/sda"]` | **Set this.** Host disk device paths to monitor — run `lsblk -d` and list your real devices. |
| `cap_add` | `["SYS_RAWIO", "SYS_ADMIN"]` | Capabilities the collector needs for S.M.A.R.T. commands. |
| `image` | `ghcr.io/analogj/scrutiny:master-omnibus` | Container image. Pin a tag in production. |
| `data_volume` | `scrutiny_data` | `/opt/scrutiny/config`. |
| `influx_volume` | `scrutiny_influxdb` | `/opt/scrutiny/influxdb` — the history store. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> **Disk access:** the collector needs the raw block devices passed through (`disks`) plus `SYS_RAWIO` (SATA/SAS) and
> `SYS_ADMIN` (many NVMe drives). It reads `/run/udev` (bind, read-only) to resolve model/serial. Because it reads
> physical disks, pin the job with `constraints` to the specific node whose drives you want to monitor — one Scrutiny
> instance per node. The collector runs on a schedule; the dashboard fills in after the first collection.
