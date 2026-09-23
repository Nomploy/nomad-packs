# jupyter

[Jupyter](https://jupyter.org) — JupyterLab / Jupyter Notebook for interactive Python, data
analysis, and scientific computing in the browser. Live code, equations, visualizations, and
narrative text in shareable notebooks.

Single host-networked Nomad service with token auth and a persistent `work` volume. A prestart
task chowns the volume so the `jovyan` user (uid 1000 / gid 100) can write it.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run jupyter --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8110` | Web UI port. |
| `token` | `change-me-…` | Login token (`JUPYTER_TOKEN`). **Change it** — the server is a Python shell. |
| `image` | `quay.io/jupyter/minimal-notebook:latest` | Jupyter image. Use `scipy-notebook` / `datascience-notebook` for a batteries-included stack. |
| `work_volume` | `jupyter_work` | `/home/jovyan/work` — your notebooks and files. |
| `resources` | `{ cpu = 1000, memory = 1024 }` | Task resources. Bump memory for real data workloads. |

Open `http://<node-ip>:8110/?token=<your-token>`. Serves plain HTTP — put a reverse proxy in
front for TLS. Pin the job to the node holding the volume with `constraints`. To add Python
packages permanently, build your own image `FROM` a Jupyter image with the extra deps baked in.
