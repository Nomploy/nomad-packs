# Authoring a pack

This guide is for agents and humans adding a pack to this registry. Follow it and your
pack will pass `scripts/lint-packs.mjs` and the CI render/validate step.

## Quick start (scaffold)

For a standard single-service, host-networked pack, scaffold the six files:

```sh
node scripts/new-pack.mjs <id> --name "Name" --image "org/img:tag" --port 8080 [--volume /data] [--app-url URL]
```

It prints the three site-map lines to add (`site/src/lib/packs.js` CATEGORIES + GITHUB_REPO,
`site/src/lib/icons.js` BRAND). Then fill in the README/description, run
`node scripts/lint-packs.mjs`, and validate. For all-in-one packs (bundled DB/redis, a chown
init, config-from-vars) start from the scaffold and add tasks by hand per the patterns below.

## Principles

- **Batteries-included, one-click.** A pack should come up with sensible defaults and no
  manual steps. Bundle required dependencies (e.g. a DB) in the same job when the app is
  useless without them.
- **Single node by default.** State lives on a local Docker volume, so `count = 1` for
  anything stateful, and pin placement with a `constraints` variable. Note multi-node as
  out of scope in the README.
- **Host networking.** Services use `network_mode = "host"` and static host ports, and
  register a `provider = "nomad"` service for discovery. Co-located tasks reach each other
  on `127.0.0.1`.
- **Plain HTTP; TLS at the proxy.** Web UIs serve HTTP and are meant to sit behind a
  reverse proxy (Traefik) for TLS.

## nomad-pack v2 template syntax (important)

The deployed nomad-pack uses the **v2 parser**. Delimiters are `[[ ]]`, and you reference
variables with `var`:

- Scalar: `[[ var "port" . ]]`
- List → HCL list: `[[ var "datacenters" . | toStringList ]]`
- Object field: `[[ (var "resources" .).cpu ]]`
- Range: `[[- range $c := var "constraints" . ]] … [[- end ]]`
- Conditional: `[[- if ne (var "domain" .) "" ]] … [[- end ]]`
- A **literal `$`** in the rendered job (e.g. a regex or `${meta.x}`) must be written `$$`
  so Nomad HCL unescapes it — nomad-pack leaves `$` untouched.

Never use legacy v1 dotted access like `[[ .name ]]` or `[[ .packname.x ]]` — the linter
rejects it and the parser errors.

## Files (all required)

```
packs/<id>/
  metadata.hcl                 # name / description / version / urls
  variables.hcl                # inputs (must define job_name, namespace, datacenters)
  templates/<id>.nomad.tpl     # the job
  outputs.tpl                  # post-deploy hints
  README.md                    # usage, variables table, notes
  CHANGELOG.md                 # start at 0.1.0
```

`pack.name` in `metadata.hcl` must equal `<id>` (the directory name), and `pack.version`
must be semver (`0.1.0`).

## metadata.hcl

```hcl
app {
  url = "https://upstream-project.example"
}

pack {
  name        = "<id>"
  description = "One clear sentence: what it is + how it's deployed here."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/<id>"
  version     = "0.1.0"
}
```

## variables.hcl conventions

Always start with the standard trio, then the pack's inputs:

```hcl
variable "job_name"    { type = string       default = "<id>" }
variable "namespace"   { type = string       default = "default" }
variable "datacenters" { type = list(string) default = ["*"] }
```

Common patterns used across the registry: `image` (document "pin a tag in production"),
`port`/`*_port` (pick free defaults — check the port map in `packs/*/variables.hcl` to
avoid clashes), a `data_volume` (string) for stateful packs, a `constraints` list-of-object
for pinning, and a `resources` object `{ cpu, memory }`. Every variable should have a
`description`. Put secrets' defaults behind a clear "CHANGE THIS" note.

## Volumes & ownership

- Use a **named Docker volume** for state:
  ```hcl
  mount { type = "volume" source = "[[ var "data_volume" . ]]" target = "/var/lib/…" }
  ```
- A **fresh** named volume inherits the image directory's content **and ownership**, so if
  the image declares that dir as a `VOLUME` owned by its service user (postgres→999,
  grafana→472, mariadb→999, prometheus→65534, …) it's writable out of the box.
- If the image runs as **root**, a fresh volume is always writable.
- If the process runs as a **non-root uid but the dir isn't a pre-owned image VOLUME**
  (e.g. n8n→1000, loki→10001), add a `prestart` init task that `chown`s the volume:
  ```hcl
  task "init" {
    lifecycle { hook = "prestart" sidecar = false }
    config { image = "busybox:latest" command = "sh" args = ["-c", "chown -R 1000:1000 /path"] }
    mount { type = "volume" source = "[[ var "data_volume" . ]]" target = "/path" }
  }
  ```

## All-in-one packs (app + its dependencies)

Run dependencies as `prestart` **sidecars** so they start before the main task and share
the host network:

```hcl
task "postgres" {
  lifecycle { hook = "prestart" sidecar = true }
  …
}
task "app" { … }   # connects to 127.0.0.1:<db_port>
```

The main task may briefly start before the DB accepts connections. Either let Nomad's
`restart` block retry (self-heals), or wrap the entrypoint in a wait loop, e.g.
`until <migrate>; do sleep 3; done && exec <serve>`.

## Config files without host files

Render config from variables with a `template` stanza (it appears at `/local/…` in the
container), then point the process at it via args or env:

```hcl
template { destination = "local/config.yml" data = <<EOH
listen: 0.0.0.0:[[ var "port" . ]]
EOH
}
```

## outputs.tpl / README / CHANGELOG

- `outputs.tpl`: how to reach it (URL, ports), the discovery service name, where state
  lives, and any first-run step. It's rendered with the same `[[ var … ]]` syntax.
- `README.md`: a usage snippet (`nomad-pack run <id> --registry nomploy`), a key-variables
  table, and notes (single-node, backups, security, TLS).
- `CHANGELOG.md`: start at `0.1.0`; bump it (and `pack.version`) on any change.

## Validate before opening a PR

```bash
node scripts/lint-packs.mjs        # static format checks (no tools needed)
scripts/validate-packs.sh          # renders + `nomad job validate` each pack
```

`validate-packs.sh` needs `nomad-pack` in PATH (and `nomad` + a reachable agent for the
validate step). CI runs both on every PR touching `packs/**`.

## Submitting

Branch, commit, push, open a PR. Adding a pack needs **no** changes to the website or JSON
API — the build scans `packs/` automatically. Give it a category in
`site/src/lib/packs.js` (and a brand icon slug in `site/src/lib/icons.js`) if you want a
nicer tile; otherwise it falls back to "Other" + a monogram.

## Minimal skeleton (stateless single service)

`metadata.hcl`, `variables.hcl` (the trio + `image`, `port`, `resources`), and:

```hcl
job "[[ var "job_name" . ]]" {
  namespace   = "[[ var "namespace" . ]]"
  datacenters = [[ var "datacenters" . | toStringList ]]
  type        = "service"

  group "[[ var "job_name" . ]]" {
    count = 1
    network { mode = "host" port "http" { static = [[ var "port" . ]] } }
    service { name = "[[ var "job_name" . ]]" provider = "nomad" port = "http" }
    restart { attempts = 3 interval = "5m" delay = "15s" mode = "delay" }

    task "[[ var "job_name" . ]]" {
      driver = "docker"
      config { image = "[[ var "image" . ]]" network_mode = "host" ports = ["http"] }
      resources { cpu = [[ (var "resources" .).cpu ]] memory = [[ (var "resources" .).memory ]] }
    }
  }
}
```
