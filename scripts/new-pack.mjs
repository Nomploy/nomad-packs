#!/usr/bin/env node
// Scaffold a new single-service, host-networked pack.
//
// Usage:
//   node scripts/new-pack.mjs <id> [--name "Name"] [--desc "..."] [--image img:tag]
//                                  [--port N] [--app-url URL] [--volume /path]
//
// Creates packs/<id>/ with the six standard files, then prints the exact snippets to add
// to the site maps (site/src/lib/packs.js and icons.js). Run the lint + validate afterwards:
//   node scripts/lint-packs.mjs && scripts/validate-packs.sh
import { mkdirSync, writeFileSync, existsSync } from "node:fs";
import { join, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const ROOT = join(dirname(fileURLToPath(import.meta.url)), "..");

const argv = process.argv.slice(2);
const id = argv.find((a) => !a.startsWith("--"));
if (!id || !/^[a-z0-9][a-z0-9-]*$/.test(id)) {
  console.error("usage: node scripts/new-pack.mjs <id> [--name ..] [--desc ..] [--image ..] [--port N] [--app-url ..] [--volume /path]");
  console.error("(<id> must be lower-kebab-case)");
  process.exit(1);
}
const opt = (flag, def) => {
  const i = argv.indexOf(flag);
  return i !== -1 && argv[i + 1] ? argv[i + 1] : def;
};

const name = opt("--name", id);
const desc = opt("--desc", `${name} — TODO one-line description. Deployed as a single host-networked Nomad service.`);
const image = opt("--image", `${id}:latest`);
const port = opt("--port", "8080");
const appUrl = opt("--app-url", "");
const volume = opt("--volume", ""); // container path; adds a named volume + mount when set

const dir = join(ROOT, "packs", id);
if (existsSync(dir)) {
  console.error(`packs/${id} already exists — aborting.`);
  process.exit(1);
}
mkdirSync(join(dir, "templates"), { recursive: true });

const volVar = volume
  ? `
variable "data_volume" {
  description = "Named volume mounted at ${volume}."
  type        = string
  default     = "${id.replace(/-/g, "_")}_data"
}
`
  : "";

const volMount = volume
  ? `
        mount {
          type   = "volume"
          target = "${volume}"
          source = "[[ var "data_volume" . ]]"
        }`
  : "";

const appBlock = appUrl ? `\n  url = "${appUrl}"\n` : `\n  url = "https://example.com/TODO"\n`;

const files = {
  "metadata.hcl": `app {${appBlock}}

pack {
  name        = "${id}"
  description = "${desc.replace(/"/g, '\\"')}"
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/${id}"
  version     = "0.1.0"
}
`,
  "variables.hcl": `variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "${id}"
}

variable "namespace" {
  description = "The Nomad namespace to deploy into."
  type        = string
  default     = "default"
}

variable "datacenters" {
  description = "The datacenters to deploy to."
  type        = list(string)
  default     = ["*"]
}

variable "image" {
  description = "The ${name} container image. Pin a tag in production."
  type        = string
  default     = "${image}"
}

variable "port" {
  description = "Host port for the ${name} web UI."
  type        = number
  default     = ${port}
}
${volVar}
variable "constraints" {
  description = "Placement constraints. On a nomploy cluster: attribute = \\"$\${meta.nomploy_control_plane}\\", operator = \\"=\\", value = \\"true\\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}

variable "resources" {
  description = "The task resources."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
  }
}
`,
  [`templates/${id}.nomad.tpl`]: `job "[[ var "job_name" . ]]" {
  namespace   = "[[ var "namespace" . ]]"
  datacenters = [[ var "datacenters" . | toStringList ]]
  type        = "service"

  [[- range $c := var "constraints" . ]]
  constraint {
    attribute = "[[ $c.attribute ]]"
    operator  = "[[ $c.operator ]]"
    value     = "[[ $c.value ]]"
  }
  [[- end ]]

  group "[[ var "job_name" . ]]" {
    count = 1

    network {
      mode = "host"
      port "http" {
        static = [[ var "port" . ]]
      }
    }

    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "http"
    }

    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "delay"
    }

    task "${id}" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]${volMount}
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
`,
  "outputs.tpl": `${name} deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
`,
  "README.md": `# ${id}

TODO: describe ${name} and what this pack deploys.

## Deploy

\`\`\`sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run ${id} --registry=nomploy
\`\`\`

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| \`port\` | \`${port}\` | Web UI port. |
| \`image\` | \`${image}\` | Container image. Pin a tag in production. |
| \`resources\` | \`{ cpu = 300, memory = 256 }\` | Task resources. |
`,
  "CHANGELOG.md": `# Changelog

## 0.1.0

- Initial release: ${name} as a single host-networked Nomad service.
`,
};

for (const [rel, content] of Object.entries(files)) writeFileSync(join(dir, rel), content);

console.log(`Created packs/${id}/ (${Object.keys(files).length} files).`);
console.log(`\nNow wire the site maps (site/src/lib/):`);
console.log(`  packs.js  CATEGORIES  ->  ${id}: "Apps",              // pick a real category`);
console.log(`  packs.js  GITHUB_REPO ->  ${id}: "owner/repo",         // for the ★ stars badge (optional)`);
console.log(`  icons.js  BRAND       ->  ${id}: "simpleiconsslug",    // optional; omit for a monogram`);
console.log(`\nThen:`);
console.log(`  node scripts/lint-packs.mjs`);
console.log(`  scripts/validate-packs.sh   # needs nomad-pack + a dev nomad agent`);
