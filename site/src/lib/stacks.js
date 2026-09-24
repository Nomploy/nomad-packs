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
  {
    id: "home-automation",
    name: "Home automation stack",
    tagline: "Smart home, local and private",
    description:
      "Run your smart home locally: Home Assistant as the hub, Mosquitto as the MQTT broker, Zigbee2MQTT to bring Zigbee devices in off their vendor hubs, ESPHome to build firmware for ESP32/ESP8266 devices, and Node-RED for flows and automations.",
    packs: ["home-assistant", "mosquitto", "zigbee2mqtt", "esphome", "node-red"],
  },
  {
    id: "media-automation",
    name: "Media automation stack",
    tagline: "The *arr stack: find, grab, organize, stream",
    description:
      "A hands-off media pipeline: Prowlarr manages indexers, Sonarr and Radarr grab TV and movies, Bazarr fetches subtitles, qBittorrent downloads them, Jellyfin streams the library, and Jellyseerr takes requests. Share one media volume across them for instant hardlink imports.",
    packs: ["prowlarr", "sonarr", "radarr", "bazarr", "qbittorrent", "jellyfin", "jellyseerr"],
  },
  {
    id: "rag-ai",
    name: "Local RAG stack",
    tagline: "Chat with your documents, fully local",
    description:
      "A private retrieval-augmented-generation setup: Ollama runs the LLM, pgvector stores embeddings in PostgreSQL, AnythingLLM ties documents and chat together, and Open WebUI gives you a polished chat front-end — no data leaves your hardware.",
    packs: ["ollama", "pgvector", "anythingllm", "open-webui"],
  },
  {
    id: "git-forge",
    name: "Git forge stack",
    tagline: "Self-hosted code hosting & registries",
    description:
      "Own your source and artifacts: Forgejo for Git hosting with issues and CI, zot as an OCI container registry, and Verdaccio as a private npm registry — a lightweight, community-governed dev backbone.",
    packs: ["forgejo", "zot", "verdaccio"],
  },
];

export function getStacks() {
  return STACKS;
}
