# nomploy nomad-packs

A curated [Nomad Pack](https://developer.hashicorp.com/nomad/tools/nomad-pack)
registry for [nomploy](https://github.com/Nomploy/nomploy) — one-command,
batteries-included infrastructure for a Nomad cluster.

The community registry doesn't carry a container registry, so these packs fill the
gaps nomploy users hit (starting with a registry; monitoring/logging next).

## Use it

With the nomad-pack CLI:

```bash
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run zot --registry nomploy
```

In **nomploy**: create a Compose service, set the type to **Nomad Pack**, set the
pack (e.g. `zot`) and this repo as the custom registry — then Deploy.

## Packs

| Pack | Description |
|---|---|
| [`zot`](packs/zot) | OCI-native container image registry (anonymous pull / authenticated push). |

_Planned:_ `prometheus-grafana`, `loki`, and other common cluster infra.

## Layout

```
packs/<name>/
  metadata.hcl          # pack name / version / description
  variables.hcl         # inputs
  templates/<name>.nomad.tpl   # the job (Go template, [[ ]] delimiters)
  outputs.tpl           # post-deploy hints
  README.md · CHANGELOG.md
```

## License

Apache-2.0.
