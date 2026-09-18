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
  Other: "#64748B",
};

// Returns { compact, svg } — `compact` is small + JSON-safe for the API,
// `svg` is an inline SVG string used by the site (omitted from the API).
export function resolveIcon(id, name, category) {
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
