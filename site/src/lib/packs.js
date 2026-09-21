// Build-time loader: scans the repo's packs/ and parses each pack's
// metadata.hcl, variables.hcl and README.md into structured data.
import { readFileSync, readdirSync, existsSync, statSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import { marked } from "marked";
import { resolveIcon } from "./icons.js";

const HERE = dirname(fileURLToPath(import.meta.url));
const PACKS_DIR = join(HERE, "..", "..", "..", "packs");
const REPO_URL = "https://github.com/Nomploy/nomad-packs";

export const REGISTRY_URL = "github.com/Nomploy/nomad-packs";
export { REPO_URL };

// Human categories for grouping/filtering (pack id -> category).
const CATEGORIES = {
  postgres: "Databases", mariadb: "Databases", redis: "Databases", clickhouse: "Databases",
  seaweedfs: "Object storage",
  rabbitmq: "Messaging", nats: "Messaging",
  monitoring: "Observability", loki: "Observability", grafana: "Observability", dozzle: "Observability",
  keycloak: "Identity", vaultwarden: "Identity",
  gitea: "Dev tools", zot: "Dev tools", adminer: "Dev tools", "it-tools": "Dev tools", "code-server": "Dev tools", cyberchef: "Dev tools", mailpit: "Dev tools",
  n8n: "Automation",
  metabase: "Analytics", umami: "Analytics", plausible: "Analytics",
  "uptime-kuma": "Apps", nginx: "Apps", excalidraw: "Apps", "stirling-pdf": "Apps", ghost: "Apps", nocodb: "Apps",
  fleet: "Device management",
  memcached: "Databases",
  meilisearch: "Search",
  ntfy: "Notifications",
  backup: "Backup",
  cloudflared: "Networking", whoami: "Networking",
};

const readIf = (p) => (existsSync(p) ? readFileSync(p, "utf8") : "");

function firstString(block, key) {
  const m = block.match(new RegExp(key + '\\s*=\\s*"((?:[^"\\\\]|\\\\.)*)"'));
  return m ? m[1].replace(/\\"/g, '"') : "";
}

function parseMetadata(hcl) {
  const packBlock = (hcl.match(/pack\s*\{([\s\S]*?)\n\}/) || [, ""])[1];
  const appBlock = (hcl.match(/app\s*\{([\s\S]*?)\n\}/) || [, ""])[1];
  return {
    name: firstString(packBlock, "name"),
    description: firstString(packBlock, "description"),
    version: firstString(packBlock, "version"),
    sourceUrl: firstString(packBlock, "url"),
    appUrl: firstString(appBlock, "url"),
  };
}

function parseVariables(hcl) {
  const re = /variable\s+"([^"]+)"\s*\{/g;
  const starts = [];
  let m;
  while ((m = re.exec(hcl))) starts.push({ name: m[1], at: m.index, bodyAt: re.lastIndex });
  return starts.map((s, i) => {
    const end = i + 1 < starts.length ? starts[i + 1].at : hcl.length;
    const body = hcl.slice(s.bodyAt, end);
    const typeM = body.match(/type\s*=\s*(.+)/);
    let type = typeM ? typeM[1].trim() : "";
    if (/^object\(|^list\(|^\{/.test(type)) type = type.replace(/\s+/g, " ").slice(0, 40) + (type.length > 40 ? "…" : "");
    const defM = body.match(/default\s*=\s*(.+)/);
    let def = defM ? defM[1].trim() : "";
    if (/[\{\[]\s*$/.test(def)) def = def + " … }";
    return { name: s.name, description: firstString(body, "description"), type, default: def };
  });
}

let cache;
export function getPacks() {
  if (cache) return cache;
  cache = readdirSync(PACKS_DIR)
    .filter((d) => statSync(join(PACKS_DIR, d)).isDirectory())
    .map((d) => {
      const dir = join(PACKS_DIR, d);
      const meta = parseMetadata(readIf(join(dir, "metadata.hcl")));
      const readme = readIf(join(dir, "README.md"));
      const name = meta.name || d;
      const category = CATEGORIES[d] || "Other";
      const icon = resolveIcon(d, name, category);
      return {
        id: d,
        name,
        description: meta.description,
        version: meta.version,
        sourceUrl: meta.sourceUrl || `${REPO_URL}/tree/main/packs/${d}`,
        appUrl: meta.appUrl,
        category,
        registry: REGISTRY_URL,
        runCommand: `nomad-pack run ${d} --registry nomploy`,
        variables: parseVariables(readIf(join(dir, "variables.hcl"))),
        icon: icon.compact,
        iconSvg: icon.svg,
        readme,
        readmeHtml: readme ? marked.parse(readme) : "",
      };
    })
    .sort((a, b) => a.name.localeCompare(b.name));
  return cache;
}

export function getCategories() {
  return [...new Set(getPacks().map((p) => p.category))].sort();
}
