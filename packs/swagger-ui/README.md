# swagger-ui

[Swagger UI](https://swagger.io/tools/swagger-ui/) — renders any OpenAPI/Swagger specification into
clean, interactive, "try it out" API documentation in the browser. Point it at a spec URL and share
explorable docs for your API.

Single host-networked Nomad service. **Stateless** — no volumes, so you can raise `count`.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run swagger-ui --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8112` | Web server port (`PORT`). |
| `spec_url` | Petstore demo | URL of the OpenAPI/Swagger spec to render (`URL`). Point at your API. |
| `count` | `1` | Instances to run (stateless — safe to scale). |
| `image` | `swaggerapi/swagger-ui:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 200, memory = 128 }` | Task resources. |

Set `spec_url` to your API's spec (e.g. `https://api.example.com/openapi.json`). If the spec lives on
another origin, that server must return permissive CORS headers so the browser can fetch it. To serve
a spec file baked into the image instead, mount it and set the `SWAGGER_JSON` env var.
