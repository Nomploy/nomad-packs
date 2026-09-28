# checkmk

[Checkmk](https://checkmk.com) is a comprehensive IT infrastructure monitoring
system. The **Raw** (open-source) edition monitors servers, network devices,
cloud, containers and applications with powerful **auto-discovery**, thousands
of built-in check plugins, flexible dashboards, event handling and alerting via
email/SMS/webhooks — a strong alternative to Nagios/Zabbix.

This pack runs Checkmk Raw as a single host-networked Nomad service. On first
start it creates a monitoring site named `cmk`.

## Deploy

```bash
nomad-pack run checkmk --registry=nomploy \
  --var admin_password=$(openssl rand -hex 12) --var timezone=Europe/Bratislava
```

Open `http://<node-ip>:5000/cmk/` and log in as `cmkadmin`.

## Configuration

| Variable         | Default                          | Description                                  |
| ---------------- | -------------------------------- | -------------------------------------------- |
| `image`          | `checkmk/check-mk-raw:2.4.0-latest` | Container image (pin a tag in production).     |
| `port`           | `5000`                           | Host port for the web UI.                     |
| `admin_password` | `checkmk_change_me`              | `cmkadmin` password — **change this**.        |
| `timezone`       | `UTC`                            | Container timezone.                            |
| `data_volume`    | `checkmk_sites`                  | Volume for sites and data (`/omd/sites`).      |
| `resources`      | 1000 MHz / 2048 MB               | CPU and memory for the task.                   |

The `cmk` site, configuration and monitoring history persist in `data_volume`.
The admin password is applied on the first start only.
