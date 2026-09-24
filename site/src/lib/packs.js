// Build-time loader: scans the repo's packs/ and parses each pack's
// metadata.hcl, variables.hcl and README.md into structured data.
import { readFileSync, readdirSync, existsSync, statSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import { execSync } from "node:child_process";
import { marked } from "marked";
import { resolveIcon } from "./icons.js";

const HERE = dirname(fileURLToPath(import.meta.url));
const PACKS_DIR = join(HERE, "..", "..", "..", "packs");
const REPO_ROOT = join(HERE, "..", "..", "..");

// Git-derived first-seen (added) and last-changed (updated) dates for every pack,
// from one `git log` pass over packs/. Needs full history (fetch-depth: 0 in CI);
// falls back to empty on any failure so the build never breaks.
let _gitDates;
function gitDates() {
  if (_gitDates) return _gitDates;
  const added = {}, updated = {};
  try {
    const out = execSync(
      'git -C "' + REPO_ROOT + '" log --diff-filter=AM --name-only --format="C:%cI" -- packs/',
      { encoding: "utf8", maxBuffer: 64 * 1024 * 1024, stdio: ["ignore", "pipe", "ignore"] }
    );
    let date = null;
    for (const line of out.split("\n")) {
      if (line.startsWith("C:")) { date = line.slice(2).trim(); continue; }
      const m = line.match(/^packs\/([^/]+)\//);
      if (!m || !date) continue;
      const id = m[1];
      if (!updated[id]) updated[id] = date; // log is newest-first → first seen = latest
      added[id] = date;                      // keep overwriting → ends on oldest
    }
  } catch {}
  _gitDates = { added, updated };
  return _gitDates;
}

// Last commit date at which each pack's container image default was changed (added
// or bumped). One `git log -p` pass over the variables.hcl files, matching added
// `default = "…"` lines that look like an image reference. Best-effort; empty on failure.
let _imgDates;
function imageBumpDates() {
  if (_imgDates) return _imgDates;
  const bumped = {};
  try {
    const out = execSync(
      'git -C "' + REPO_ROOT + '" log --format="C:%cI" -p -- "packs/*/variables.hcl"',
      { encoding: "utf8", maxBuffer: 128 * 1024 * 1024, stdio: ["ignore", "pipe", "ignore"] }
    );
    let date = null, id = null;
    for (const line of out.split("\n")) {
      if (line.startsWith("C:")) { date = line.slice(2).trim(); continue; }
      if (line.startsWith("diff --git")) { id = null; continue; }
      const f = line.match(/^\+\+\+ b\/packs\/([^/]+)\/variables\.hcl/);
      if (f) { id = f[1]; continue; }
      if (!id || !date) continue;
      const m = line.match(/^\+\s*default\s*=\s*"([^"]+)"/);
      if (!m) continue;
      const v = m[1];
      // container ref: no spaces, has a registry path or a :tag, not a URL/email/secret
      if (!/^[a-z0-9][\w.\-/]*(?::[\w.\-]+)?(?:@sha256:[a-f0-9]+)?$/.test(v)) continue;
      if (!(v.includes("/") || /:[\w.\-]+$/.test(v))) continue;
      if (!bumped[id]) bumped[id] = date; // newest-first → first hit = last bump
    }
  } catch {}
  _imgDates = bumped;
  return _imgDates;
}

// Split a container image reference into repo + tag/digest, and flag whether it is
// pinned to a concrete version (anything other than empty or "latest").
function parseImageRef(image) {
  const s = (image || "").trim();
  if (!s) return { repo: "", tag: "", pinned: false };
  const digest = s.match(/@(sha256:[a-f0-9]+)$/);
  const bare = digest ? s.slice(0, digest.index) : s;
  const slash = bare.lastIndexOf("/");
  const colon = bare.indexOf(":", slash + 1); // colon after the last '/' is the tag
  const repo = colon === -1 ? bare : bare.slice(0, colon);
  const tag = colon === -1 ? "" : bare.slice(colon + 1);
  const label = digest ? (tag ? `${tag}@${digest[1].slice(0, 14)}…` : `${digest[1].slice(0, 14)}…`) : tag;
  const pinned = Boolean(digest) || (tag !== "" && tag !== "latest");
  return { repo, tag: label, pinned };
}

const REPO_URL = "https://github.com/Nomploy/nomad-packs";

export const REGISTRY_URL = "github.com/Nomploy/nomad-packs";
export { REPO_URL };

// Human categories for grouping/filtering (pack id -> category).
const CATEGORIES = {
  postgres: "Databases", mariadb: "Databases", mysql: "Databases", redis: "Databases", clickhouse: "Databases",
  seaweedfs: "Object storage", minio: "Object storage",
  rabbitmq: "Messaging", nats: "Messaging", mosquitto: "Messaging", emqx: "Messaging", redpanda: "Messaging", soketi: "Messaging", mumble: "Messaging", conduit: "Messaging",
  monitoring: "Observability", loki: "Observability", grafana: "Observability", dozzle: "Observability", alertmanager: "Observability", victoriametrics: "Observability", jaeger: "Observability", gatus: "Observability", pushgateway: "Observability", "victoria-logs": "Observability", influxdb: "Observability", "blackbox-exporter": "Observability", "postgres-exporter": "Observability", "redis-exporter": "Observability", "mysqld-exporter": "Observability", glances: "Observability", beszel: "Observability", statping: "Observability", netdata: "Observability", healthchecks: "Observability",
  keycloak: "Identity", vaultwarden: "Identity", authentik: "Identity", "pocket-id": "Identity", lldap: "Identity",
  gitea: "Dev tools", zot: "Dev tools", adminer: "Dev tools", "it-tools": "Dev tools", "code-server": "Dev tools", cyberchef: "Dev tools", mailpit: "Dev tools", pgadmin: "Dev tools", pocketbase: "Dev tools", redisinsight: "Dev tools", filebrowser: "Dev tools", verdaccio: "Dev tools", pgweb: "Dev tools", cloudbeaver: "Dev tools", opengist: "Dev tools", wakapi: "Dev tools", kroki: "Dev tools", microbin: "Dev tools", jupyter: "Dev tools", gotenberg: "Dev tools", dbgate: "Dev tools", "swagger-ui": "Dev tools", semaphore: "Dev tools", postgrest: "Dev tools", dufs: "Dev tools",
  n8n: "Automation", "node-red": "Automation", changedetection: "Automation", "home-assistant": "Automation", esphome: "Automation",
  metabase: "Analytics", umami: "Analytics", plausible: "Analytics", matomo: "Analytics",
  "uptime-kuma": "Apps", nginx: "Apps", excalidraw: "Apps", "stirling-pdf": "Apps", ghost: "Apps", nocodb: "Apps", homepage: "Apps", vikunja: "Apps", miniflux: "Apps", docmost: "Apps", directus: "Apps", actual: "Apps", glance: "Apps", navidrome: "Apps", syncthing: "Apps", jellyfin: "Apps", photoprism: "Apps", "paperless-ngx": "Apps", trilium: "Apps", wikijs: "Apps", hedgedoc: "Apps", grist: "Apps", planka: "Apps", memos: "Apps", jellyseerr: "Apps", linkwarden: "Apps", audiobookshelf: "Apps", homebox: "Apps", radicale: "Apps", mattermost: "Apps", flame: "Apps", shiori: "Apps", "firefly-iii": "Apps", kimai: "Apps", drawio: "Apps", komga: "Apps", pairdrop: "Apps", owncast: "Apps", rallly: "Apps", snappymail: "Apps", mealie: "Apps", cefiro: "Apps", kavita: "Apps", linkding: "Apps", maloja: "Apps", docuseal: "Apps", "joplin-server": "Apps", filestash: "Apps", ghostfolio: "Apps", shlink: "Apps", "pingvin-share": "Apps", copyparty: "Apps", "owntracks-recorder": "Apps", siyuan: "Apps", teammapper: "Apps",
  fleet: "Device management",
  ollama: "AI", qdrant: "AI", "open-webui": "AI", weaviate: "AI", flowise: "AI", "lobe-chat": "AI", litellm: "AI", hermes: "AI", opencode: "AI", chroma: "AI", libretranslate: "AI", "whisper-asr": "AI", anythingllm: "AI",
  memcached: "Databases", ferretdb: "Databases", timescaledb: "Databases", surrealdb: "Databases", neo4j: "Databases", valkey: "Databases", couchdb: "Databases", dragonfly: "Databases", cockroachdb: "Databases", questdb: "Databases", etcd: "Databases", dolt: "Databases", immudb: "Databases", libsql: "Databases", rqlite: "Databases",
  meilisearch: "Search", typesense: "Search", whoogle: "Search", searxng: "Search",
  ntfy: "Notifications", gotify: "Notifications", apprise: "Notifications",
  backup: "Backup", "rest-server": "Backup",
  cloudflared: "Networking", whoami: "Networking", adguardhome: "Networking", caddy: "Networking", rustdesk: "Networking", headscale: "Networking", consul: "Networking", "nginx-proxy-manager": "Networking", "cloudflare-ddns": "Networking", openspeedtest: "Networking", technitium: "Networking", traefik: "Networking",
  openbao: "Secrets", "step-ca": "Secrets",
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

// Capture a bracket-balanced substring of `text` starting at its first char
// (an opener), honoring string literals so braces inside strings don't count.
function sliceBalanced(text, open, close) {
  let depth = 0, inStr = false, q = "";
  for (let i = 0; i < text.length; i++) {
    const c = text[i];
    if (inStr) {
      if (c === "\\") { i++; continue; }
      if (c === q) inStr = false;
      continue;
    }
    if (c === '"' || c === "'") { inStr = true; q = c; continue; }
    else if (c === open) depth++;
    else if (c === close && --depth === 0) return text.slice(0, i + 1);
  }
  return text;
}

// Extract the full RHS value of an assignment: single line, heredoc, object, or list.
function extractValue(rest) {
  rest = rest.replace(/^[ \t]+/, "");
  const hd = rest.match(/^<<-?\s*"?(\w+)"?[ \t]*\n/);
  if (hd) {
    const after = rest.slice(hd[0].length);
    const endM = after.match(new RegExp("^[ \\t]*" + hd[1] + "[ \\t]*$", "m"));
    if (endM) return rest.slice(0, hd[0].length + endM.index + endM[0].length);
  }
  if (rest[0] === "{") return sliceBalanced(rest, "{", "}");
  if (rest[0] === "[") return sliceBalanced(rest, "[", "]");
  const nl = rest.indexOf("\n");
  return (nl === -1 ? rest : rest.slice(0, nl)).trim();
}

const KINDS = /^(string|number|bool|list|map|object|set|tuple|any)/;

function parseVariables(hcl) {
  const re = /variable\s+"([^"]+)"\s*\{/g;
  const starts = [];
  let m;
  while ((m = re.exec(hcl))) starts.push({ name: m[1], at: m.index, bodyAt: re.lastIndex });
  return starts.map((s, i) => {
    const end = i + 1 < starts.length ? starts[i + 1].at : hcl.length;
    const body = hcl.slice(s.bodyAt, end);

    const tIdx = body.search(/(^|\n)[ \t]*type[ \t]*=/);
    let type = "", kind = "string";
    if (tIdx !== -1) {
      const rest = body.slice(body.indexOf("=", tIdx) + 1).replace(/^[ \t]+/, "");
      const km = rest.match(KINDS);
      kind = km ? km[1] : "string";
      const p = rest.indexOf("(");
      const nl = rest.indexOf("\n");
      type = p !== -1 && (nl === -1 || p < nl)
        ? (km ? km[0] : "") + sliceBalanced(rest.slice(p), "(", ")").replace(/\s+/g, " ")
        : (nl === -1 ? rest : rest.slice(0, nl)).trim();
    }

    const dIdx = body.search(/(^|\n)[ \t]*default[ \t]*=/);
    let def = "";
    if (dIdx !== -1) def = extractValue(body.slice(body.indexOf("=", dIdx) + 1));

    const placeholder = /change|replace|your[-_]|generate|example\.com/i.test(def);
    const sensitive = /(password|secret|token|htpasswd|api[_-]?key|_key\b)/i.test(s.name);

    return { name: s.name, description: firstString(body, "description"), type, kind, default: def, placeholder, sensitive };
  });
}

// Extract quick facts from a rendered-ish job template: exposed static ports (with
// their variable defaults resolved), named-volume mount targets, and the task count.
function parseFacts(tpl, variables) {
  const defs = Object.fromEntries(variables.map((v) => [v.name, (v.default || "").replace(/^"|"$/g, "")]));
  if (!tpl) return { ports: [], volumes: [], volumeNames: [], tasks: 0, bundledDb: false, image: defs.image || "", cpu: 0, memory: 0 };
  const resolve = (raw) => {
    raw = raw.trim().replace(/,$/, "").trim();
    const vm = raw.match(/\[\[\s*var\s+"([^"]+)"/);
    return vm ? defs[vm[1]] ?? "" : raw.replace(/^"|"$/g, "");
  };
  const ports = [];
  let m;
  const pre = /port\s+"([^"]+)"\s*\{([\s\S]*?)\}/g;
  while ((m = pre.exec(tpl))) {
    const sm = m[2].match(/static\s*=\s*([^\n]+)/);
    if (sm) ports.push({ name: m[1], port: resolve(sm[1]) });
  }
  const volumes = [];
  const volumeNames = [];
  const vre = /mount\s*\{([\s\S]*?)\}/g;
  while ((m = vre.exec(tpl))) {
    if (!/type\s*=\s*"volume"/.test(m[1])) continue;
    const tm = m[1].match(/target\s*=\s*"([^"]+)"/);
    if (tm && !volumes.includes(tm[1])) volumes.push(tm[1]);
    const sm = m[1].match(/source\s*=\s*([^\n]+)/);
    if (sm) { const nm = resolve(sm[1]); if (nm && !volumeNames.includes(nm)) volumeNames.push(nm); }
  }
  const tasks = (tpl.match(/task\s+"[^"]+"\s*\{/g) || []).length;
  // A bundled database sidecar (all-in-one packs): a task named after a common DB engine.
  const bundledDb = /task\s+"(postgres(?:ql)?|mariadb|mysql|redis|valkey|mongo(?:db)?|clickhouse|couchdb|database|db)"/i.test(tpl);
  // Estimate CPU/RAM from the resources object variables (main + sidecars).
  let cpu = 0, memory = 0;
  for (const v of variables) {
    if (!/resources$/i.test(v.name)) continue;
    const mm = (v.default || "").match(/memory\s*=\s*(\d+)/);
    const cc = (v.default || "").match(/cpu\s*=\s*(\d+)/);
    if (mm) memory += parseInt(mm[1], 10);
    if (cc) cpu += parseInt(cc[1], 10);
  }
  return { ports, volumes, volumeNames, tasks, bundledDb, image: defs.image || "", cpu, memory };
}

// "Pairs with" relationships. Listed one-directionally; buildRelated() makes them
// symmetric, drops unknown ids, and caps each list. Referencing a pack that pairs
// naturally (a DB + its exporter/admin UI, an app + its companion) makes the catalog
// navigable.
const RELATED = {
  monitoring: ["grafana", "loki", "alertmanager", "blackbox-exporter", "postgres-exporter", "redis-exporter", "mysqld-exporter", "pushgateway"],
  grafana: ["loki", "victoriametrics", "influxdb"],
  loki: ["grafana", "victoria-logs", "seaweedfs"],
  alertmanager: ["ntfy", "gotify"],
  "postgres-exporter": ["postgres"],
  "redis-exporter": ["redis", "valkey", "dragonfly"],
  "mysqld-exporter": ["mariadb"],
  victoriametrics: ["victoria-logs", "grafana"],
  backup: ["rest-server", "seaweedfs", "postgres", "mariadb"],
  ollama: ["open-webui", "qdrant", "weaviate"],
  qdrant: ["weaviate", "open-webui"],
  jellyfin: ["navidrome", "photoprism"],
  navidrome: ["syncthing"],
  photoprism: ["syncthing"],
  filebrowser: ["syncthing"],
  postgres: ["pgadmin", "adminer"],
  mariadb: ["adminer"],
  redis: ["redisinsight", "valkey"],
  valkey: ["redisinsight", "dragonfly"],
  adminer: ["clickhouse"],
  keycloak: ["authentik"],
  mosquitto: ["emqx", "node-red"],
  emqx: ["nats"],
  ntfy: ["gotify", "uptime-kuma", "gatus"],
  "uptime-kuma": ["gatus"],
  vaultwarden: ["openbao"],
  gitea: ["zot", "verdaccio"],
  n8n: ["node-red"],
  meilisearch: ["typesense"],
  docmost: ["wikijs", "hedgedoc", "trilium"],
  wikijs: ["hedgedoc"],
  nocodb: ["directus", "grist"],
  jupyter: ["code-server", "ollama"],
  rallly: ["vikunja", "planka", "radicale"],
  snappymail: ["radicale"],
  gotenberg: ["stirling-pdf", "paperless-ngx", "docmost"],
  searxng: ["open-webui", "whoogle"],
  netdata: ["grafana", "beszel", "glances"],
  minio: ["backup", "rest-server", "seaweedfs"],
  apprise: ["ntfy", "gotify", "uptime-kuma"],
  cefiro: ["mealie"],
  kavita: ["komga", "audiobookshelf"],
  linkding: ["shiori", "linkwarden"],
  dbgate: ["postgres", "mariadb", "adminer"],
  dolt: ["adminer", "dbgate"],
  maloja: ["navidrome", "jellyfin"],
  healthchecks: ["ntfy", "gotify", "uptime-kuma", "apprise"],
  "swagger-ui": ["gitea", "kroki"],
  chroma: ["ollama", "open-webui", "litellm"],
  semaphore: ["gitea", "n8n"],
  technitium: ["adguardhome", "cloudflared"],
  docuseal: ["paperless-ngx", "stirling-pdf"],
  lldap: ["keycloak", "authentik", "pocket-id"],
  postgrest: ["postgres", "pgadmin", "pgweb"],
  "joplin-server": ["trilium", "memos", "docmost"],
  "step-ca": ["caddy", "openbao", "cloudflared"],
  filestash: ["seaweedfs", "minio", "filebrowser"],
  immudb: ["postgres"],
  dufs: ["filebrowser", "syncthing"],
  ghostfolio: ["actual", "firefly-iii"],
  "pingvin-share": ["pairdrop", "filebrowser"],
  copyparty: ["filebrowser", "dufs", "filestash"],
  "owntracks-recorder": ["home-assistant"],
  libsql: ["pocketbase"],
  libretranslate: ["open-webui"],
  "whisper-asr": ["open-webui", "ollama"],
  traefik: ["consul", "whoami"],
  rqlite: ["libsql"],
  siyuan: ["trilium", "memos", "joplin-server"],
  teammapper: ["excalidraw", "drawio"],
  anythingllm: ["ollama", "open-webui", "chroma"],
};

// Build a symmetric adjacency (a→b implies b→a) from a one-directional map,
// dropping unknown ids and capping each list.
function buildGraph(map, allIds, cap = 8) {
  const idset = new Set(allIds);
  const adj = {};
  const add = (a, b) => {
    if (a === b) return;
    (adj[a] ??= new Set()).add(b);
  };
  for (const [a, list] of Object.entries(map)) for (const b of list) { add(a, b); add(b, a); }
  const out = {};
  for (const id of allIds) out[id] = [...(adj[id] ?? [])].filter((x) => idset.has(x)).sort().slice(0, cap);
  return out;
}

// "Alternatives" — packs that do essentially the same job (pick one). Grouped;
// buildGraph makes every member an alternative of the others.
const ALTERNATIVES = {
  redis: ["valkey", "dragonfly", "memcached"],
  valkey: ["dragonfly", "memcached"],
  postgres: ["mariadb", "cockroachdb"],
  timescaledb: ["postgres", "influxdb", "questdb"],
  mosquitto: ["emqx"],
  meilisearch: ["typesense"],
  qdrant: ["weaviate"],
  "open-webui": ["lobe-chat"],
  keycloak: ["authentik", "pocket-id"],
  plausible: ["umami", "matomo"],
  linkwarden: ["shiori"],
  docmost: ["wikijs", "hedgedoc"],
  trilium: ["memos"],
  "uptime-kuma": ["gatus", "statping"],
  monitoring: ["beszel"],
  glances: ["beszel", "netdata"],
  netdata: ["glances", "beszel"],
  whoogle: ["searxng"],
  minio: ["seaweedfs"],
  apprise: ["ntfy", "gotify"],
  mealie: ["cefiro"],
  kavita: ["komga"],
  linkding: ["shiori", "linkwarden"],
  dbgate: ["cloudbeaver", "adminer", "pgweb"],
  healthchecks: ["uptime-kuma", "gatus"],
  chroma: ["qdrant", "weaviate"],
  technitium: ["adguardhome"],
  lldap: ["keycloak", "authentik"],
  "joplin-server": ["trilium", "memos"],
  filestash: ["filebrowser"],
  dufs: ["filebrowser", "copyparty"],
  ghostfolio: ["firefly-iii"],
  "pingvin-share": ["pairdrop"],
  traefik: ["caddy", "nginx-proxy-manager"],
  rqlite: ["libsql"],
  siyuan: ["trilium", "joplin-server"],
  anythingllm: ["open-webui", "lobe-chat"],
  ntfy: ["gotify"],
  caddy: ["nginx-proxy-manager"],
  opengist: ["microbin"],
  homepage: ["glance", "flame"],
  adminer: ["cloudbeaver"],
  pgweb: ["pgadmin"],
  actual: ["firefly-iii"],
  directus: ["nocodb", "grist"],
  jellyseerr: [],
  drawio: ["excalidraw"],
};

function buildRelated(allIds) { return buildGraph(RELATED, allIds); }
function buildAlternatives(allIds) { return buildGraph(ALTERNATIVES, allIds, 6); }

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
  glances: "nicolargo/glances", jellyfin: "jellyfin/jellyfin", photoprism: "photoprism/photoprism",
  "paperless-ngx": "paperless-ngx/paperless-ngx", trilium: "TriliumNext/Trilium", wikijs: "requarks/wiki",
  filebrowser: "filebrowser/filebrowser", hedgedoc: "hedgedoc/hedgedoc", grist: "gristlabs/grist-core",
  adguardhome: "AdguardTeam/AdGuardHome", verdaccio: "verdaccio/verdaccio", cockroachdb: "cockroachdb/cockroach",
  weaviate: "weaviate/weaviate", changedetection: "dgtlmoon/changedetection.io", emqx: "emqx/emqx",
  planka: "plankanban/planka", beszel: "henrygd/beszel", caddy: "caddyserver/caddy",
  memos: "usememos/memos", questdb: "questdb/questdb", jellyseerr: "fallenbagel/jellyseerr", linkwarden: "linkwarden/linkwarden", audiobookshelf: "advplyr/audiobookshelf",
  pgweb: "sosedoff/pgweb", rustdesk: "rustdesk/rustdesk-server", homebox: "sysadminsmedia/homebox",
  flowise: "FlowiseAI/Flowise", headscale: "juanfont/headscale", statping: "statping-ng/statping-ng",
  radicale: "Kozea/Radicale", "pocket-id": "pocket-id/pocket-id", mattermost: "mattermost/mattermost",
  redpanda: "redpanda-data/redpanda", cloudbeaver: "dbeaver/cloudbeaver", soketi: "soketi/soketi",
  "home-assistant": "home-assistant/core", esphome: "esphome/esphome", flame: "pawelmalak/flame",
  consul: "hashicorp/consul", etcd: "etcd-io/etcd", whoogle: "benbusby/whoogle-search",
  "nginx-proxy-manager": "NginxProxyManager/nginx-proxy-manager", opengist: "thomiceli/opengist", "lobe-chat": "lobehub/lobe-chat",
  shiori: "go-shiori/shiori", "firefly-iii": "firefly-iii/firefly-iii", litellm: "BerriAI/litellm",
  matomo: "matomo-org/matomo", kimai: "kimai/kimai", wakapi: "muety/wakapi",
  drawio: "jgraph/drawio", "cloudflare-ddns": "favonia/cloudflare-ddns", kroki: "yuzutech/kroki",
  komga: "gotson/komga", pairdrop: "schlagmichdoch/PairDrop", microbin: "szabodanika/microbin",
  hermes: "NousResearch/hermes-agent", opencode: "anomalyco/opencode",
  mysql: "mysql/mysql-server", owncast: "owncast/owncast", mumble: "mumble-voip/mumble",
  jupyter: "jupyter/notebook", rallly: "lukevella/rallly", snappymail: "the-djmaze/snappymail",
  netdata: "netdata/netdata", gotenberg: "gotenberg/gotenberg", openspeedtest: "openspeedtest/Speed-Test", searxng: "searxng/searxng",
  minio: "minio/minio", mealie: "mealie-recipes/mealie", apprise: "caronc/apprise-api",
  cefiro: "pipozzz/cefiro",
  kavita: "Kareadita/Kavita", dbgate: "dbgate/dbgate", linkding: "sissbruecker/linkding", dolt: "dolthub/dolt",
  maloja: "krateng/maloja", "swagger-ui": "swagger-api/swagger-ui", healthchecks: "healthchecks/healthchecks",
  chroma: "chroma-core/chroma", semaphore: "semaphoreui/semaphore", technitium: "TechnitiumSoftware/DnsServer", docuseal: "docusealco/docuseal",
  lldap: "lldap/lldap", postgrest: "PostgREST/postgrest", "joplin-server": "laurent22/joplin", "step-ca": "smallstep/certificates",
  filestash: "mickael-kerjean/filestash", immudb: "codenotary/immudb", dufs: "sigoden/dufs", ghostfolio: "ghostfolio/ghostfolio",
  shlink: "shlinkio/shlink", "pingvin-share": "stonith404/pingvin-share", copyparty: "9001/copyparty", "owntracks-recorder": "owntracks/recorder",
  libsql: "tursodatabase/libsql", libretranslate: "LibreTranslate/LibreTranslate", "whisper-asr": "ahmetoner/whisper-asr-webservice", traefik: "traefik/traefik",
  rqlite: "rqlite/rqlite", siyuan: "siyuan-note/siyuan", teammapper: "b310-digital/teammapper", anythingllm: "Mintplex-Labs/anything-llm",
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
  const dates = gitDates();
  const imgBumped = imageBumpDates();
  const packs = readdirSync(PACKS_DIR)
    .filter((d) => statSync(join(PACKS_DIR, d)).isDirectory())
    .map((d) => {
      const dir = join(PACKS_DIR, d);
      const meta = parseMetadata(readIf(join(dir, "metadata.hcl")));
      const readme = readIf(join(dir, "README.md"));
      const name = meta.name || d;
      const category = CATEGORIES[d] || "Other";
      const icon = resolveIcon(d, name, category);
      const variables = parseVariables(readIf(join(dir, "variables.hcl")));
      const facts = parseFacts(readIf(join(dir, "templates", d + ".nomad.tpl")), variables);
      const img = parseImageRef(facts.image);
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
        variables,
        facts,
        imageTag: img.tag,
        imagePinned: img.pinned,
        imageBumped: imgBumped[d] || null,
        added: dates.added[d] || null,
        updated: dates.updated[d] || null,
        related: [],
        alternatives: [],
        icon: icon.compact,
        iconSvg: icon.svg,
        readme,
        readmeHtml: readme ? marked.parse(readme) : "",
      };
    })
    .sort((a, b) => a.name.localeCompare(b.name));

  // Attach symmetric "pairs with" + "alternatives" relationships now that every id is known.
  const ids = packs.map((p) => p.id);
  const rel = buildRelated(ids);
  const alt = buildAlternatives(ids);
  const nameOf = Object.fromEntries(packs.map((p) => [p.id, p.name]));
  for (const p of packs) {
    p.related = rel[p.id].map((id) => ({ id, name: nameOf[id] }));
    p.alternatives = alt[p.id].map((id) => ({ id, name: nameOf[id] }));
  }

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
