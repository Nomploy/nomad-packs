# filebrowser

[File Browser](https://filebrowser.org) — a clean web file manager for a directory: browse,
upload, download, edit, preview, share, and manage files and users from the browser.

Single host-networked Nomad service with a files volume (`/srv`) and a database volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run filebrowser --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8103` | Web UI port (`FB_PORT`). |
| `files_volume` | `filebrowser_files` | `/srv` — the files you manage. |
| `data_volume` | `filebrowser_data` | `/database` — the File Browser database. |
| `image` | `filebrowser/filebrowser:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 128 }` | Task resources. |

First start creates the database and an admin account — check the task logs for the generated
admin password (older images use `admin` / `admin`) and change it immediately. Pin the job to
the node holding the volumes with `constraints`.
