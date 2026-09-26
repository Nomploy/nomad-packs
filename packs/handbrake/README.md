# handbrake

[HandBrake](https://handbrake.fr/) — the popular open-source **video transcoder**, here with a browser-streamed GUI (no
VNC client needed) plus an automatic **watch-folder** converter. Rip and re-encode video to modern codecs with presets,
manually via the GUI or automatically by dropping files into a watch folder.

Single host-networked Nomad service with config, source, watch and output volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run handbrake --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `5800` | Browser GUI port (`WEB_LISTENING_PORT`). |
| `automated_conversion` | `1` | Auto-convert files dropped in `/watch` (`AUTOMATED_CONVERSION`): `1` on, `0` off. |
| `image` | `jlesage/handbrake:latest` | Container image. Pin a tag in production. |
| `data_volume` | `handbrake_data` | `/config` — settings. |
| `storage_volume` | `handbrake_storage` | `/storage` — source media to pick in the GUI. |
| `watch_volume` | `handbrake_watch` | `/watch` — drop files here for auto-conversion. |
| `output_volume` | `handbrake_output` | `/output` — converted files. |
| `user_id` / `group_id` | `1000` / `1000` | File ownership (`USER_ID`/`GROUP_ID`). |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `resources` | `{ cpu = 4000, memory = 2048 }` | Task resources. Transcoding is CPU-heavy — give it cores. |

> The GUI has no auth by default — put it behind an authenticating reverse proxy over TLS if exposed. For hardware
> acceleration, pass the render device through and use a QSV/NVENC/VAAPI preset. Pin the job to the node holding the
> volumes with `constraints`.
