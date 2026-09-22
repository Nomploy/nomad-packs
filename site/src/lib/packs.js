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
  rabbitmq: "Messaging", nats: "Messaging", mosquitto: "Messaging",
  monitoring: "Observability", loki: "Observability", grafana: "Observability", dozzle: "Observability", alertmanager: "Observability", victoriametrics: "Observability", jaeger: "Observability", gatus: "Observability", pushgateway: "Observability", "victoria-logs": "Observability", influxdb: "Observability", "blackbox-exporter": "Observability", "postgres-exporter": "Observability", "redis-exporter": "Observability", "mysqld-exporter": "Observability",
  keycloak: "Identity", vaultwarden: "Identity", authentik: "Identity",
  gitea: "Dev tools", zot: "Dev tools", adminer: "Dev tools", "it-tools": "Dev tools", "code-server": "Dev tools", cyberchef: "Dev tools", mailpit: "Dev tools", pgadmin: "Dev tools", pocketbase: "Dev tools", redisinsight: "Dev tools",
  n8n: "Automation", "node-red": "Automation",
  metabase: "Analytics", umami: "Analytics", plausible: "Analytics",
  "uptime-kuma": "Apps", nginx: "Apps", excalidraw: "Apps", "stirling-pdf": "Apps", ghost: "Apps", nocodb: "Apps", homepage: "Apps", vikunja: "Apps", miniflux: "Apps", docmost: "Apps", directus: "Apps", actual: "Apps", glance: "Apps", navidrome: "Apps", syncthing: "Apps",
  fleet: "Device management",
  ollama: "AI", qdrant: "AI", "open-webui": "AI",
  memcached: "Databases", ferretdb: "Databases", timescaledb: "Databases", surrealdb: "Databases", neo4j: "Databases", valkey: "Databases", couchdb: "Databases", dragonfly: "Databases",
  meilisearch: "Search", typesense: "Search",
  ntfy: "Notifications", gotify: "Notifications",
  backup: "Backup", "rest-server": "Backup",
  cloudflared: "Networking", whoami: "Networking",
  openbao: "Secrets",
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

// Upstream GitHub repo (owner/repo) per pack, for the star badge. Omit where the
// project isn't primarily on GitHub. A wrong/missing repo just hides the badge.
const GITHUB_REPO = {
  clickhouse: "ClickHouse/ClickHouse", mariadb: "MariaDB/server", redis: "redis/redis",
  seaweedfs: "seaweedfs/seaweedfs", rabbitmq: "rabbitmq/rabbitmq-server", nats: "nats-io/nats-server",
  grafana: "grafana/grafana", loki: "grafana/loki", monitoring: "prometheus/prometheus",
  keycloak: "keycloak/keycloak", vaultwarden: "dani-garcia/vaultwarden",
  gitea: "go-gitea/gitea", zot: "project-zot/zot", adminer: "vrana/adminer",
  n8n: "n8n-io/n8n", metabase: "metabase/metabase", "uptime-kuma": "louislam/uptime-kuma",
  fleet: "fleetdm/fleet", backup: "restic/restic", meilisearch: "meilisearch/meilisearch",
  umami: "umami-software/umami", ntfy: "binwiederhier/ntfy", dozzle: "amir20/dozzle",
  "it-tools": "CorentinTh/it-tools", memcached: "memcached/memcached", "code-server": "coder/code-server",
  excalidraw: "excalidraw/excalidraw", cyberchef: "gchq/CyberChef", plausible: "plausible/analytics",
  "stirling-pdf": "Stirling-Tools/Stirling-PDF", mailpit: "axllent/mailpit",
  cloudflared: "cloudflare/cloudflared", whoami: "traefik/whoami", gotify: "gotify/server",
  homepage: "gethomepage/homepage", ollama: "ollama/ollama", vikunja: "go-vikunja/vikunja",
  ferretdb: "FerretDB/FerretDB", openbao: "openbao/openbao", miniflux: "miniflux/v2",
  alertmanager: "prometheus/alertmanager", victoriametrics: "VictoriaMetrics/VictoriaMetrics",
  jaeger: "jaegertracing/jaeger", gatus: "TwiN/gatus", pushgateway: "prometheus/pushgateway",
  pgadmin: "pgadmin-org/pgadmin4", "victoria-logs": "VictoriaMetrics/VictoriaLogs",
  docmost: "docmost/docmost", directus: "directus/directus", pocketbase: "pocketbase/pocketbase",
  redisinsight: "RedisInsight/RedisInsight",
  qdrant: "qdrant/qdrant", "open-webui": "open-webui/open-webui", timescaledb: "timescale/timescaledb",
  typesense: "typesense/typesense", surrealdb: "surrealdb/surrealdb", mosquitto: "eclipse/mosquitto",
  "node-red": "node-red/node-red", influxdb: "influxdata/influxdb", neo4j: "neo4j/neo4j",
  valkey: "valkey-io/valkey", couchdb: "apache/couchdb", dragonfly: "dragonflydb/dragonfly",
  authentik: "goauthentik/authentik", actual: "actualbudget/actual",
  glance: "glanceapp/glance", "blackbox-exporter": "prometheus/blackbox_exporter",
  "postgres-exporter": "prometheus-community/postgres_exporter", "redis-exporter": "oliver006/redis_exporter", "mysqld-exporter": "prometheus/mysqld_exporter",
  navidrome: "navidrome/navidrome", syncthing: "syncthing/syncthing", "rest-server": "restic/rest-server",
};

function formatStars(n) {
  if (n >= 1000000) return (n / 1000000).toFixed(1).replace(/\.0$/, "") + "M";
  if (n >= 1000) return (n / 1000).toFixed(1).replace(/\.0$/, "") + "k";
  return String(n);
}

// Fetch a repo's star count at build time. Returns null on any failure so the
// build never breaks (badge is simply omitted). Uses GITHUB_TOKEN when present.
async function fetchStars(repo) {
  try {
    const headers = {
      "Accept": "application/vnd.github+json",
      "User-Agent": "nomploy-nomad-packs-site",
    };
    const token = process.env.GITHUB_TOKEN;
    if (token) headers.Authorization = `Bearer ${token}`;
    const ctrl = new AbortController();
    const t = setTimeout(() => ctrl.abort(), 8000);
    const res = await fetch(`https://api.github.com/repos/${repo}`, { headers, signal: ctrl.signal });
    clearTimeout(t);
    if (!res.ok) return null;
    const data = await res.json();
    return typeof data.stargazers_count === "number" ? data.stargazers_count : null;
  } catch {
    return null;
  }
}

let cache;
export async function getPacks() {
  if (cache) return cache;
  const packs = readdirSync(PACKS_DIR)
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
        repo: GITHUB_REPO[d] || null,
        stars: null,
        starsLabel: null,
        variables: parseVariables(readIf(join(dir, "variables.hcl"))),
        icon: icon.compact,
        iconSvg: icon.svg,
        readme,
        readmeHtml: readme ? marked.parse(readme) : "",
      };
    })
    .sort((a, b) => a.name.localeCompare(b.name));

  // Fetch stars in parallel for packs with a known repo (best-effort).
  await Promise.all(
    packs.filter((p) => p.repo).map(async (p) => {
      const stars = await fetchStars(p.repo);
      if (stars != null) {
        p.stars = stars;
        p.starsLabel = formatStars(stars);
      }
    })
  );

  cache = packs;
  return cache;
}

export async function getCategories() {
  return [...new Set((await getPacks()).map((p) => p.category))].sort();
}
