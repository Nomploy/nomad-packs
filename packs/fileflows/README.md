# fileflows

[FileFlows](https://fileflows.com) is a file-processing automation tool. You
build **visual flows** — chains of nodes that transcode video and audio with
FFmpeg, convert images, rename and reorganise files, and more — that run
automatically as files arrive in a watched library. It can distribute work
across multiple processing nodes for heavy transcoding.

This pack runs the FileFlows server as a single host-networked Nomad service.

## Deploy

```bash
nomad-pack run fileflows --registry=nomploy
```

Open `http://<node-ip>:5000`, accept the EULA, then create a flow and a library
pointing at `/media`.

## Configuration

| Variable      | Default                  | Description                                    |
| ------------- | ------------------------ | ---------------------------------------------- |
| `image`       | `revenz/fileflows:latest`| Container image (pin a tag in production).        |
| `port`        | `5000`                   | Host port for the web UI.                       |
| `data_volume` | `fileflows_data`         | Volume for config/database/logs (`/app/Data`).  |
| `media_volume`| `fileflows_media`        | Volume for the media library (`/media`).         |
| `temp_volume` | `fileflows_temp`         | Volume for temporary processing files (`/temp`). |
| `resources`   | 2000 MHz / 2048 MB       | CPU and memory (transcoding is CPU-heavy).       |

Mount your existing media library at `/media` (point your flow's library there).
Processing workers only run after you accept the EULA in the UI. For hardware
transcoding or extra processing nodes, see the FileFlows docs.
