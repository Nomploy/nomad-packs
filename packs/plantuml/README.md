# plantuml

[PlantUML Server](https://github.com/plantuml/plantuml-server) — a web service that renders **UML and other diagrams**
from plain PlantUML text: sequence, class, activity, component, state, ER, mind-map, Gantt and more. It ships a live
in-browser editor and a stable image URL API, so wikis, docs and chat tools can embed diagrams that render on demand.

Single **stateless** host-networked Nomad service (no volume).

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run plantuml --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8080` | Web UI / API port. Fixed at `8080` inside the Jetty image. |
| `image` | `plantuml/plantuml-server:jetty` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. The JVM needs some headroom. |

> Open `http://<host>:8080` for the editor, or POST/GET encoded diagrams at `/svg/…`, `/png/…`, `/txt/…`. Being
> stateless, it needs no storage and scales horizontally. Pairs well with wikis like
> [wikijs](https://packs.nomploy.com/packs/wikijs) or [hedgedoc](https://packs.nomploy.com/packs/hedgedoc).
