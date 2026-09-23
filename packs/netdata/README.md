# netdata

[Netdata](https://www.netdata.cloud) — real-time, per-second monitoring for systems and containers.
Thousands of metrics are auto-detected with zero configuration, rendered as interactive charts, with
built-in health alarms and anomaly detection. Runs fully self-hosted — no cloud account required.

Single host-networked Nomad service. It reads the host's `/proc`, `/sys`, `/etc/os-release`, and the
Docker socket (all read-only) and keeps its state in persistent volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run netdata --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `19999` | Web UI / API port (`NETDATA_LISTENER_PORT`). |
| `config_volume` | `netdata_config` | `/etc/netdata` — your config overrides. |
| `lib_volume` | `netdata_lib` | `/var/lib/netdata` — the metrics database. |
| `cache_volume` | `netdata_cache` | `/var/cache/netdata`. |
| `image` | `netdata/netdata:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. Bump memory for longer retention. |

The job adds the `SYS_PTRACE` capability and `apparmor=unconfined` so Netdata can read per-process
metrics — standard for the official image. The dashboard has **no authentication**; keep it internal
or behind a reverse proxy. Deploy one instance on **each node** you want to monitor (pin with
`constraints`), or connect several agents to a parent for a single view.
