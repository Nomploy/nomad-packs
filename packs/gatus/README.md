# gatus

[Gatus](https://gatus.io) — an automated, developer-oriented **health/uptime dashboard**:
declare endpoints and pass/fail conditions in YAML and get a clean status page plus
alerting. A config-as-code alternative to the `uptime-kuma` pack. Stateless host-networked
Nomad service; its config is rendered from variables.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run gatus --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `gatus`, custom registry
`github.com/Nomploy/nomad-packs`, then Deploy. Open `http://<node-ip>:8101`.

## Configuring what to monitor

Set the `endpoints` variable to the `endpoints:` section of a Gatus config, e.g.:

```yaml
- name: my-api
  url: "https://api.example.com/health"
  interval: 30s
  conditions:
    - "[STATUS] == 200"
    - "[RESPONSE_TIME] < 300"
```

See [gatus.io](https://gatus.io) for groups, TCP/DNS/ICMP checks, and `alerting:` (which you
can add by extending the rendered config).

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `twinproduction/gatus:latest` | Pin a tag in production. |
| `port` | `8101` | Status page (also set as the config's `web.port`). |
| `endpoints` | sample | The `endpoints:` YAML — replace with your services. |
| `constraints` | `[]` | Gatus probes from its node — pin accordingly. |
| `resources` | `cpu 200 / mem 128` | Lightweight. |

## Notes

- **Stateless** by default (in-memory results). For history across restarts, add a storage
  backend (sqlite/postgres) in the config + a volume — not configured here.
- vs `uptime-kuma`: Gatus is config-as-code (YAML in git), Uptime Kuma is UI-driven. Pick
  whichever fits your workflow.
