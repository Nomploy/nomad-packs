# jdownloader2

[JDownloader 2](https://jdownloader.org/) — a powerful, cross-platform **download manager**. It grabs direct links and
one-click-hoster links, handles link decryption and captcha assistance, resumes and parallelizes downloads, and can be
driven remotely via My.JDownloader. This pack runs it as a browser-streamed GUI (no VNC client needed).

Single host-networked Nomad service with config and output volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run jdownloader2 --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `5800` | Browser GUI port (`WEB_LISTENING_PORT`). |
| `image` | `jlesage/jdownloader-2:latest` | Container image. Pin a tag in production. |
| `data_volume` | `jdownloader2_data` | `/config` — application state and settings. |
| `output_volume` | `jdownloader2_output` | `/output` — downloaded files. |
| `user_id` / `group_id` | `1000` / `1000` | File ownership (`USER_ID`/`GROUP_ID`). |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> Open the GUI in your browser and (optionally) sign in with a My.JDownloader account for remote control. The GUI has
> no auth by default — put it behind an authenticating reverse proxy over TLS if exposed. Pin the job to the node
> holding the volumes with `constraints`.
