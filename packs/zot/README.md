# zot

Deploys [zot](https://zotregistry.dev) — a lightweight, OCI-native container image
registry — as a Nomad `service` job. Host-networked, so it's reachable at
`<node-ip>:<port>`. Storage is local disk (bind-mounted) with dedup, GC and an
untagged-retention policy on by default. **Anonymous pull, authenticated push** is
the recommended setup for a registry that only listens on a private/overlay network.

## Usage

```bash
# add this registry once
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs

# open (no auth) — fine only on a trusted private network
nomad-pack run zot --registry nomploy

# anonymous pull + authenticated push (recommended)
#   generate the hash first:  htpasswd -bnBC10 pushuser 'a-strong-pass'
nomad-pack run zot --registry nomploy \
  --var 'htpasswd=pushuser:$2y$10$....' \
  --var 'anonymous_pull=true'
```

### On a nomploy cluster

Pin it to the control plane so the blob store stays on one node, and let nomploy
manage pull credentials cluster-wide:

```bash
nomad-pack run zot --registry nomploy \
  --var 'htpasswd=pushuser:$2y$10$....' \
  --var 'constraints=[{attribute="${meta.nomploy_control_plane}",operator="=",value="true"}]'
```

Then **Settings → Registry → Add Registry** (`URL <node-ip>:5000`, prefix `apps`,
your push user/pass). nomploy publishes the creds to Consul KV and consul-template
renders them onto every node — private multi-node pulls with no creds in job specs.

> It serves **HTTP**, so each node's Docker daemon needs the address in
> `insecure-registries` (a real TLS cert would remove that). This is a per-node
> daemon setting, not a per-job one.

## Variables

| Variable | Default | Description |
|---|---|---|
| `job_name` | `zot` | Nomad job name |
| `namespace` | `default` | Nomad namespace |
| `datacenters` | `["*"]` | Datacenters to deploy to |
| `image` | `ghcr.io/project-zot/zot-linux-amd64:v2.1.5` | zot image (per-arch) |
| `port` | `5000` | Host port |
| `count` | `1` | Instances (keep 1 for local storage) |
| `data_dir` | `/opt/zot` | Host dir for the blob store |
| `constraints` | `[]` | Placement constraints (pin for stable storage) |
| `anonymous_pull` | `true` | Allow unauthenticated pulls (needs `htpasswd` set) |
| `htpasswd` | `""` | `user:bcrypthash` for push; empty = fully open |
| `resources` | `{cpu=500, memory=512}` | Task resources |

## Notes

- The host bind mount for `data_dir` requires the Docker task driver's
  `volumes { enabled = true }`.
- To enable CVE scanning, add zot's `extensions.search.cve` to the config and
  raise `resources.memory` (Trivy needs headroom).
