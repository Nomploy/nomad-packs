# kroki

[Kroki](https://kroki.io) — a unified API that turns text into diagrams: PlantUML, Graphviz,
Mermaid, BPMN, Excalidraw, and 20+ more, from a single HTTP endpoint.

Stateless host-networked Nomad service. Pairs with the [docmost](../docmost), [wikijs](../wikijs),
and [hedgedoc](../hedgedoc) packs (all can point at a Kroki server for diagrams).

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run kroki --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8125` | HTTP API port (`MICRONAUT_SERVER_PORT`). |
| `image` | `yuzutech/kroki:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. |

```sh
curl http://<node-ip>:8125/graphviz/svg -d 'digraph { a -> b }'
```

The core image covers PlantUML/Graphviz/Mermaid/etc.; BPMN and Excalidraw need companion containers
(add them if needed). Stateless — no volume.
