import { getPacks } from "../lib/packs.js";
import { getStacks } from "../lib/stacks.js";

// /llms.txt — a concise, machine-readable index for LLMs / agents (and the nomploy
// panel) to discover packs and how to run them. See https://llmstxt.org/.
export async function GET({ site }) {
  const base = site ?? new URL("https://packs.nomploy.com");
  const packs = await getPacks();
  const stacks = getStacks();

  const lines = [
    "# Nomploy Nomad Packs",
    "",
    "> A curated registry of batteries-included, one-click HashiCorp Nomad Packs: databases, observability, dev tools, AI, and self-hosted apps. Every pack is host-networked with sensible defaults.",
    "",
    "Add the registry once, then run any pack:",
    "",
    "```sh",
    "nomad-pack registry add nomploy github.com/Nomploy/nomad-packs",
    "nomad-pack run <pack> --registry nomploy",
    "```",
    "",
    "- Catalog: " + new URL("/", base).href,
    "- JSON API (all packs): " + new URL("/api/packs.json", base).href,
    "- JSON API (one pack): " + new URL("/api/packs/<id>.json", base).href,
    "- Stack builder (port-conflict check): " + new URL("/stack/", base).href,
    "",
    "## Packs",
    "",
    ...packs.map((p) => {
      const ports = p.facts.ports.map((x) => x.port).join("/") || "none";
      return `- [${p.id}](${new URL(`/packs/${p.id}/`, base).href}) — ${p.category}. ${p.description} (ports: ${ports}; run: \`nomad-pack run ${p.id} --registry nomploy\`)`;
    }),
    "",
    "## Common stacks",
    "",
    ...stacks.map((s) => `- [${s.name}](${new URL(`/stacks/${s.id}/`, base).href}) — ${s.description} Packs: ${s.packs.join(", ")}.`),
    "",
  ];

  return new Response(lines.join("\n"), {
    headers: { "Content-Type": "text/plain; charset=utf-8", "Access-Control-Allow-Origin": "*" },
  });
}
