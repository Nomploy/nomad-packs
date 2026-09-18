# excalidraw

[Excalidraw](https://excalidraw.com) — a virtual whiteboard with a hand-drawn feel, for
sketching diagrams, wireframes, and flows. Stateless host-networked Nomad service; the app
runs entirely client-side.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run excalidraw --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `excalidraw`, custom
registry `github.com/Nomploy/nomad-packs`, then Deploy.

Open `http://<node-ip>:8094`.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `excalidraw/excalidraw:latest` | Pin a tag in production. |
| `port` | `8094` | Web app host port (rebinds nginx via a rendered config). |
| `count` | `1` | Stateless, so >1 is fine on distinct ports/nodes. |
| `resources` | `cpu 200 / mem 128` | Lightweight. |

## Notes

- **Stateless** — no volume. Drawings are stored in the browser (local storage / export).
- This is the **standalone** whiteboard. Real-time collaboration needs the separate
  Excalidraw collaboration/storage services (not included here).
- The image serves on port 80 internally; this pack renders an nginx `server` block so it
  listens on `port`.
