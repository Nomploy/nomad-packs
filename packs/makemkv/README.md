# makemkv

[MakeMKV](https://www.makemkv.com/) — rip **Blu-ray and DVD** discs to MKV, preserving all tracks, streamed to your
browser as a GUI (no VNC client needed). Pairs well with [handbrake](https://packs.nomploy.com/packs/handbrake) for a
second transcode pass and a media server for playback.

Single host-networked Nomad service with config and output volumes, plus optical-drive passthrough.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run makemkv --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `5800` | Browser GUI port (`WEB_LISTENING_PORT`). |
| `devices` | `[]` | **Set this.** Optical drive device paths to pass through, e.g. `["/dev/sr0", "/dev/sg2"]` (find with `lsscsi -g`). |
| `image` | `jlesage/makemkv:latest` | Container image. Pin a tag in production. |
| `data_volume` | `makemkv_data` | `/config` — settings. |
| `output_volume` | `makemkv_output` | `/output` — ripped MKV files. |
| `user_id` / `group_id` | `1000` / `1000` | File ownership (`USER_ID`/`GROUP_ID`). |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> **Needs a real optical drive:** set `devices` to your host's drive(s) and pin the job with `constraints` to the node
> that has them. MakeMKV's beta key must be entered in the GUI (it changes periodically). The GUI has no auth by
> default — put it behind an authenticating reverse proxy if exposed.
