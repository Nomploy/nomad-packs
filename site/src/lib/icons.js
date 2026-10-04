// Build-time icon resolver: brand glyphs from simple-icons where one exists,
// otherwise a monogram tile tinted by the pack's category.
import * as simpleIcons from "simple-icons";

const BY_SLUG = {};
for (const k in simpleIcons) {
  const i = simpleIcons[k];
  if (i && i.slug) BY_SLUG[i.slug] = i;
}

// pack id -> simple-icons slug (omit = monogram fallback).
const BRAND = {
  postgres: "postgresql",
  mariadb: "mariadb",
  redis: "redis",
  clickhouse: "clickhouse",
  grafana: "grafana",
  monitoring: "prometheus",
  "blackbox-exporter": "prometheus",
  "postgres-exporter": "prometheus",
  "redis-exporter": "prometheus",
  "mysqld-exporter": "prometheus",
  syncthing: "syncthing",
  jellyfin: "jellyfin",
  "paperless-ngx": "paperlessngx",
  trilium: "trilium",
  wikijs: "wikidotjs",
  adguardhome: "adguard",
  verdaccio: "verdaccio",
  cockroachdb: "cockroachlabs",
  caddy: "caddy",
  audiobookshelf: "audiobookshelf",
  rustdesk: "rustdesk",
  mattermost: "mattermost",
  "home-assistant": "homeassistant",
  esphome: "esphome",
  consul: "consul",
  etcd: "etcd",
  "nginx-proxy-manager": "nginxproxymanager",
  "firefly-iii": "fireflyiii",
  matomo: "matomo",
  mysql: "mysql",
  mumble: "mumble",
  jupyter: "jupyter",
  netdata: "netdata",
  searxng: "searxng",
  minio: "minio",
  conduit: "matrix",
  synapse: "matrix",
  "swagger-ui": "swagger",
  "joplin-server": "joplin",
  postgrest: "postgrest",
  ghostfolio: "ghostfolio",
  traefik: "traefikproxy",
  libsql: "turso",
  siyuan: "siyuan",
  forgejo: "forgejo",
  openfga: "openfga",
  pgvector: "postgresql",
  homarr: "homarr",
  teamspeak: "teamspeak",
  prowlarr: "prowlarr",
  sonarr: "sonarr",
  radarr: "radarr",
  qbittorrent: "qbittorrent",
  bazarr: "bazarr",
  lidarr: "lidarr",
  sabnzbd: "sabnzbd",
  "wg-easy": "wireguard",
  tautulli: "tautulli",
  zigbee2mqtt: "zigbee2mqtt",
  "node-exporter": "prometheus",
  "speedtest-exporter": "prometheus",
  "calibre-web-automated": "calibreweb",
  duplicati: "duplicati",
  "calibre-web": "calibreweb",
  languagetool: "languagetool",
  baserow: "baserow",
  immich: "immich",
  transmission: "transmission",
  pyroscope: "grafana",
  deluge: "deluge",
  flood: "flood",
  guacamole: "apacheguacamole",
  tempo: "grafana",
  jenkins: "jenkins",
  emby: "emby",
  plex: "plex",
  drawio: "diagramsdotnet",
  "cloudflare-ddns": "cloudflare",
  cloudbeaver: "dbeaver",
  nginx: "nginx",
  gitea: "gitea",
  keycloak: "keycloak",
  rabbitmq: "rabbitmq",
  nats: "natsdotio",
  n8n: "n8n",
  metabase: "metabase",
  vaultwarden: "vaultwarden",
  "uptime-kuma": "uptimekuma",
  meilisearch: "meilisearch",
  umami: "umami",
  ntfy: "ntfy",
  excalidraw: "excalidraw",
  "code-server": "coder",
  plausible: "plausibleanalytics",
  cloudflared: "cloudflare",
  whoami: "traefikproxy",
  ghost: "ghost",
  homepage: "homepage",
  ollama: "ollama",
  ferretdb: "ferretdb",
  victoriametrics: "victoriametrics",
  jaeger: "jaeger",
  "victoria-logs": "victoriametrics",
  directus: "directus",
  pocketbase: "pocketbase",
  timescaledb: "timescale",
  surrealdb: "surrealdb",
  mosquitto: "eclipsemosquitto",
  "node-red": "nodered",
  influxdb: "influxdb",
  neo4j: "neo4j",
  couchdb: "apachecouchdb",
  authentik: "authentik",
  actual: "actualbudget",
  homebridge: "homebridge",
  listmonk: "listmonk",
  traccar: "traccar",
  openhab: "openhab",
  mongodb: "mongodb",
  arangodb: "arangodb",
  portainer: "portainer",
  kafka: "apachekafka",
  checkmk: "checkmk",
  solr: "apachesolr",
  coder: "coder",
  cryptpad: "cryptpad",
  dgraph: "dgraph",
  pulsar: "apachepulsar",
  cassandra: "apachecassandra",
};

export const CATEGORY_COLORS = {
  Databases: "#4169E1",
  "Object storage": "#16A34A",
  Messaging: "#FF6600",
  Observability: "#E6522C",
  Identity: "#7C3AED",
  "Dev tools": "#609926",
  Automation: "#EA4B71",
  Analytics: "#509EE3",
  Apps: "#0EA5E9",
  "Device management": "#0891B2",
  Search: "#14B8A6",
  Notifications: "#EAB308",
  Backup: "#D97706",
  Networking: "#06B6D4",
  AI: "#6366F1",
  Secrets: "#9333EA",
  Other: "#64748B",
};

// pack id -> a self-contained, multi-color inline SVG logo (its own colors and
// background), for projects that have a real logo but no simple-icons glyph.
const CUSTOM = {
  goliash:
    '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 96 96" role="img" aria-label="Goliash"><rect width="96" height="96" rx="22" fill="#1b2a6b"/><g transform="translate(17 17)"><rect x="0" y="0" width="18" height="18" rx="4.5" fill="#8aa4ff"/><rect x="22" y="0" width="18" height="18" rx="4.5" fill="#8aa4ff" opacity=".55"/><rect x="44" y="0" width="18" height="18" rx="4.5" fill="#8aa4ff" opacity=".3"/><rect x="0" y="22" width="18" height="18" rx="4.5" fill="#8aa4ff" opacity=".55"/><rect x="22" y="22" width="18" height="18" rx="4.5" fill="#8aa4ff"/><rect x="44" y="22" width="18" height="18" rx="4.5" fill="#ffb347"/><rect x="0" y="44" width="18" height="18" rx="4.5" fill="#8aa4ff" opacity=".3"/><rect x="22" y="44" width="18" height="18" rx="4.5" fill="#8aa4ff" opacity=".55"/><rect x="44" y="44" width="18" height="18" rx="4.5" fill="#8aa4ff"/></g></svg>',
};

// Returns { compact, svg } — `compact` is small + JSON-safe for the API,
// `svg` is an inline SVG string used by the site (omitted from the API).
export function resolveIcon(id, name, category) {
  const custom = CUSTOM[id];
  if (custom) {
    // A data-URI src travels in the (JSON) compact icon so API/panel consumers
    // can render it as an <img>; the site inlines `svg` directly for crispness.
    const src = "data:image/svg+xml," + encodeURIComponent(custom);
    return { compact: { kind: "custom", src }, svg: custom };
  }
  const slug = BRAND[id];
  const brand = slug ? BY_SLUG[slug] : null;
  if (brand) {
    const hex = "#" + brand.hex;
    return {
      compact: { kind: "brand", slug, hex, title: brand.title },
      svg: `<svg viewBox="0 0 24 24" width="22" height="22" role="img" aria-hidden="true"><path fill="currentColor" d="${brand.path}"/></svg>`,
      hex,
    };
  }
  const color = CATEGORY_COLORS[category] || CATEGORY_COLORS.Other;
  const text = (name || id).trim().charAt(0).toUpperCase();
  return { compact: { kind: "monogram", text, color }, svg: "", color, text };
}
