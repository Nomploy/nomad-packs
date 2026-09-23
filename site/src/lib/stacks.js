// Curated "common stacks" — batteries-included bundles of packs that work well
// together on one node. Each is verified conflict-free (no overlapping host ports)
// by the same facts.ports data the Stack Builder uses.
export const STACKS = [
  {
    id: "observability",
    name: "Observability stack",
    tagline: "Metrics, logs, and alerts",
    description:
      "A full monitoring setup: Prometheus + node-exporter + cAdvisor + Grafana (the monitoring pack), Loki for logs, Alertmanager for routing, and a Blackbox exporter for endpoint probing.",
    packs: ["monitoring", "loki", "alertmanager", "blackbox-exporter"],
  },
  {
    id: "ai-llm",
    name: "Local AI stack",
    tagline: "Run LLMs and RAG on your own hardware",
    description:
      "A self-hosted AI toolkit: Ollama to run models, Open WebUI as the chat front-end, Qdrant as the vector store for RAG, and Flowise to build LLM apps and agents low-code.",
    packs: ["ollama", "open-webui", "qdrant", "flowise"],
  },
  {
    id: "media",
    name: "Media server stack",
    tagline: "Movies, music, audiobooks, requests",
    description:
      "Stream your own library: Jellyfin for video, Navidrome for music, Audiobookshelf for audiobooks and podcasts, and Jellyseerr so users can request new titles.",
    packs: ["jellyfin", "navidrome", "audiobookshelf", "jellyseerr"],
  },
  {
    id: "databases",
    name: "Database toolkit",
    tagline: "A database and the tools to drive it",
    description:
      "PostgreSQL and Redis with browser-based admin: Adminer for quick SQL across engines and pgweb for a focused Postgres client. Point apps at these on 127.0.0.1.",
    packs: ["postgres", "redis", "adminer", "pgweb"],
  },
  {
    id: "productivity",
    name: "Productivity stack",
    tagline: "Tasks, notes, documents, inventory",
    description:
      "Organize your life: Vikunja for tasks and projects, Memos for quick notes, Paperless-ngx to scan and archive documents, and HomeBox to track your belongings.",
    packs: ["vikunja", "memos", "paperless-ngx", "homebox"],
  },
  {
    id: "dev-platform",
    name: "Developer platform",
    tagline: "Git, registries, and an IDE",
    description:
      "A self-hosted dev backbone: Gitea for Git hosting, zot as an OCI container registry, Verdaccio as a private npm registry, and code-server for VS Code in the browser.",
    packs: ["gitea", "zot", "verdaccio", "code-server"],
  },
];

export function getStacks() {
  return STACKS;
}
