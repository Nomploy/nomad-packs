# changedetection

[changedetection.io](https://changedetection.io) — watch web pages for changes and get notified:
price drops, restocks, content edits, and more, with visual diffs, CSS/XPath/JSON filters, and
90+ notification targets (via Apprise).

Single host-networked Nomad service with a `/datastore` volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run changedetection --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `5001` | Web UI port (`PORT`). |
| `base_url` | `""` | `BASE_URL` used in notification links. |
| `data_volume` | `changedetection_data` | `/datastore` — config + watch history. |
| `image` | `ghcr.io/dgtlmoon/changedetection.io:latest` | Image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. |

Add a URL, set an interval, and you get diffs + notifications on change. Set an app password under
**Settings** if it's reachable beyond your LAN. For JavaScript-heavy pages, run a separate
Playwright/Chrome container and set `PLAYWRIGHT_DRIVER_URL` (plain HTTP fetching works without it).
Pin the job to the node holding the volume with `constraints`.
