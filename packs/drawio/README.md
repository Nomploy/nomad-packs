# drawio

[draw.io (diagrams.net)](https://www.drawio.com) — a full-featured diagram editor for flowcharts,
network diagrams, UML, and more, self-hosted with no account required.

Stateless host-networked Nomad service — diagrams run entirely in the browser and are stored
client-side or in files you save.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run drawio --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8080` | Editor port (Tomcat; see note). |
| `image` | `jgraph/drawio:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 512 }` | Task resources. |

Nothing is stored server-side. The image's Tomcat binds `8080` (no env to change it) — front it with
a reverse proxy (`caddy` / `nginx-proxy-manager`) for another port/domain; note 8080 overlaps several
other packs' defaults.
