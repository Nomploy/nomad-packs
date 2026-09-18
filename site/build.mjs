#!/usr/bin/env node
// Builds a self-contained static browser for the Nomploy Nomad Pack registry.
// Zero dependencies — scans ../packs, parses the HCL/README, emits dist/index.html.
import { readFileSync, readdirSync, existsSync, mkdirSync, writeFileSync, statSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const HERE = dirname(fileURLToPath(import.meta.url));
const ROOT = join(HERE, "..");
const PACKS_DIR = join(ROOT, "packs");
const OUT_DIR = join(HERE, "dist");

const REGISTRY_URL = "github.com/Nomploy/nomad-packs";
const REPO_URL = "https://github.com/Nomploy/nomad-packs";

// Human categories for grouping/filtering (name -> category).
const CATEGORIES = {
  postgres: "Databases", mariadb: "Databases", redis: "Databases", clickhouse: "Databases",
  seaweedfs: "Object storage",
  rabbitmq: "Messaging", nats: "Messaging",
  monitoring: "Observability", loki: "Observability", grafana: "Observability",
  keycloak: "Identity", vaultwarden: "Identity",
  gitea: "Dev tools", zot: "Dev tools", adminer: "Dev tools",
  n8n: "Automation",
  metabase: "Analytics",
  uptime_kuma: "Apps", "uptime-kuma": "Apps", nginx: "Apps",
  fleet: "Device management",
};

function readIf(p) { return existsSync(p) ? readFileSync(p, "utf8") : ""; }

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
  const vars = [];
  const re = /variable\s+"([^"]+)"\s*\{/g;
  let m;
  const starts = [];
  while ((m = re.exec(hcl))) starts.push({ name: m[1], at: m.index, bodyAt: re.lastIndex });
  for (let i = 0; i < starts.length; i++) {
    const s = starts[i];
    const end = i + 1 < starts.length ? starts[i + 1].at : hcl.length;
    const body = hcl.slice(s.bodyAt, end);
    const description = firstString(body, "description");
    const typeM = body.match(/type\s*=\s*(.+)/);
    let type = typeM ? typeM[1].trim() : "";
    if (/^object\(|^list\(|^\{/.test(type)) type = type.replace(/\s+/g, " ").slice(0, 40) + (type.length > 40 ? "…" : "");
    const defM = body.match(/default\s*=\s*(.+)/);
    let def = defM ? defM[1].trim() : "";
    if (/[\{\[]\s*$/.test(def)) def = def + " … }"; // multiline object/list
    vars.push({ name: s.name, description, type, default: def });
  }
  return vars;
}

const packs = readdirSync(PACKS_DIR)
  .filter((d) => statSync(join(PACKS_DIR, d)).isDirectory())
  .map((d) => {
    const dir = join(PACKS_DIR, d);
    const meta = parseMetadata(readIf(join(dir, "metadata.hcl")));
    return {
      id: d,
      name: meta.name || d,
      description: meta.description,
      version: meta.version,
      sourceUrl: meta.sourceUrl || `${REPO_URL}/tree/main/packs/${d}`,
      appUrl: meta.appUrl,
      category: CATEGORIES[d] || "Other",
      variables: parseVariables(readIf(join(dir, "variables.hcl"))),
      readme: readIf(join(dir, "README.md")),
    };
  })
  .sort((a, b) => a.name.localeCompare(b.name));

const data = { registryUrl: REGISTRY_URL, repoUrl: REPO_URL, generated: new Date().toISOString(), packs };

const html = renderHtml(data);
mkdirSync(OUT_DIR, { recursive: true });
writeFileSync(join(OUT_DIR, "index.html"), html);
// .nojekyll so GitHub Pages serves the file as-is.
writeFileSync(join(OUT_DIR, ".nojekyll"), "");
console.log(`Built ${packs.length} packs -> ${join(OUT_DIR, "index.html")}`);

function renderHtml(d) {
  const json = JSON.stringify(d).replace(/</g, "\\u003c");
  return `<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Nomploy Nomad Packs</title>
<meta name="description" content="Browse the Nomploy curated Nomad Pack registry — batteries-included infrastructure packs for Nomad." />
<link rel="icon" href="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'%3E%3Ctext y='.9em' font-size='90'%3E%F0%9F%93%A6%3C/text%3E%3C/svg%3E" />
<style>
:root{
  --bg:#f6f7f9; --card:#fff; --text:#1c2024; --muted:#5b6570; --border:#e2e6ea;
  --accent:#2f6feb; --accent-fg:#fff; --chip:#eef1f4; --code-bg:#f0f2f5;
  --shadow:0 1px 2px rgba(0,0,0,.06),0 4px 12px rgba(0,0,0,.05);
}
@media (prefers-color-scheme:dark){:root:not([data-theme="light"]){
  --bg:#0e1116; --card:#171b21; --text:#e6e9ee; --muted:#9aa4b0; --border:#252b33;
  --accent:#5b8cff; --accent-fg:#0e1116; --chip:#1e242c; --code-bg:#11151a;
  --shadow:0 1px 2px rgba(0,0,0,.4),0 6px 20px rgba(0,0,0,.35);
}}
*{box-sizing:border-box}
body{margin:0;background:var(--bg);color:var(--text);font:15px/1.55 -apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,Helvetica,Arial,sans-serif;-webkit-font-smoothing:antialiased}
a{color:var(--accent);text-decoration:none}
a:hover{text-decoration:underline}
.wrap{max-width:1080px;margin:0 auto;padding:0 16px}
header{padding:40px 0 8px}
h1{font-size:28px;margin:0 0 6px;letter-spacing:-.02em}
.tag{color:var(--muted);margin:0 0 20px;font-size:15px}
.addcmd{display:flex;gap:8px;align-items:stretch;flex-wrap:wrap;margin-bottom:8px}
code,kbd,pre{font-family:ui-monospace,SFMono-Regular,Menlo,Consolas,monospace}
.cmd{background:var(--code-bg);border:1px solid var(--border);border-radius:8px;padding:9px 12px;font-size:13px;overflow:auto;white-space:nowrap;flex:1;min-width:260px}
.copy{background:var(--accent);color:var(--accent-fg);border:0;border-radius:8px;padding:0 14px;font-size:13px;font-weight:600;cursor:pointer}
.copy:active{transform:translateY(1px)}
.controls{position:sticky;top:0;background:var(--bg);padding:14px 0;z-index:5;display:flex;gap:10px;flex-wrap:wrap;align-items:center;border-bottom:1px solid var(--border)}
#q{flex:1;min-width:220px;padding:10px 12px;border:1px solid var(--border);border-radius:8px;background:var(--card);color:var(--text);font-size:15px}
.chips{display:flex;gap:6px;flex-wrap:wrap}
.chip{background:var(--chip);border:1px solid var(--border);color:var(--muted);border-radius:999px;padding:5px 11px;font-size:13px;cursor:pointer;user-select:none}
.chip.on{background:var(--accent);color:var(--accent-fg);border-color:var(--accent)}
.grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(300px,1fr));gap:14px;padding:20px 0 60px}
.pcard{background:var(--card);border:1px solid var(--border);border-radius:12px;padding:16px;cursor:pointer;box-shadow:var(--shadow);transition:transform .08s ease,border-color .12s ease}
.pcard:hover{transform:translateY(-2px);border-color:var(--accent)}
.pcard h3{margin:0 0 4px;font-size:17px;display:flex;align-items:center;gap:8px}
.ver{font-size:11px;font-weight:600;color:var(--muted);background:var(--chip);border-radius:6px;padding:2px 6px}
.cat{font-size:11px;color:var(--muted);text-transform:uppercase;letter-spacing:.05em;margin-bottom:8px}
.pcard p{margin:0;color:var(--muted);font-size:13.5px;display:-webkit-box;-webkit-line-clamp:4;-webkit-box-orient:vertical;overflow:hidden}
.empty{color:var(--muted);padding:40px 0;text-align:center}
footer{color:var(--muted);font-size:12.5px;padding:24px 0 48px;border-top:1px solid var(--border)}
/* detail overlay */
.overlay{position:fixed;inset:0;background:rgba(0,0,0,.45);display:none;z-index:20;padding:20px;overflow:auto}
.overlay.open{display:block}
.panel{max-width:840px;margin:24px auto;background:var(--card);border:1px solid var(--border);border-radius:14px;box-shadow:var(--shadow);overflow:hidden}
.phead{padding:20px 24px;border-bottom:1px solid var(--border);display:flex;align-items:flex-start;gap:12px}
.phead h2{margin:0;font-size:22px}
.phead .sub{color:var(--muted);font-size:13px;margin-top:4px}
.x{margin-left:auto;background:var(--chip);border:1px solid var(--border);color:var(--text);border-radius:8px;width:34px;height:34px;font-size:18px;cursor:pointer;flex:0 0 auto}
.pbody{padding:20px 24px;max-height:calc(100vh - 200px);overflow:auto}
.pbody h1,.pbody h2,.pbody h3{letter-spacing:-.01em}
.pbody h1{font-size:20px;border-bottom:1px solid var(--border);padding-bottom:6px}
.pbody h2{font-size:17px;margin-top:22px}
.pbody pre{background:var(--code-bg);border:1px solid var(--border);border-radius:8px;padding:12px;overflow:auto;font-size:13px}
.pbody code{background:var(--code-bg);border-radius:4px;padding:1px 5px;font-size:.9em}
.pbody pre code{background:none;padding:0}
.pbody table{border-collapse:collapse;width:100%;font-size:13px;margin:12px 0}
.pbody th,.pbody td{border:1px solid var(--border);padding:6px 9px;text-align:left;vertical-align:top}
.pbody img{max-width:100%}
.section-title{font-size:13px;text-transform:uppercase;letter-spacing:.06em;color:var(--muted);margin:26px 0 8px}
.vartable{width:100%;border-collapse:collapse;font-size:13px}
.vartable th,.vartable td{border:1px solid var(--border);padding:7px 9px;text-align:left;vertical-align:top}
.vartable td.mono{font-family:ui-monospace,monospace;white-space:nowrap}
.links{display:flex;gap:14px;flex-wrap:wrap;margin-top:6px;font-size:13px}
</style>
</head>
<body>
<div class="wrap">
  <header>
    <h1>📦 Nomploy Nomad Packs</h1>
    <p class="tag">Batteries-included infrastructure for Nomad — one command to add, one to run.</p>
    <div class="addcmd">
      <div class="cmd" id="addcmd">nomad-pack registry add nomploy ${d.registryUrl}</div>
      <button class="copy" data-copy="#addcmd">Copy</button>
    </div>
  </header>
  <div class="controls">
    <input id="q" type="search" placeholder="Search packs…" autocomplete="off" />
    <div class="chips" id="chips"></div>
  </div>
  <div class="grid" id="grid"></div>
  <footer>
    <span id="count"></span> · Generated from
    <a href="${d.repoUrl}">${d.repoUrl.replace("https://", "")}</a> ·
    <span id="gen"></span>
  </footer>
</div>

<div class="overlay" id="overlay">
  <div class="panel" id="panel"></div>
</div>

<script id="data" type="application/json">${json}</script>
<script src="https://cdn.jsdelivr.net/npm/marked@12/marked.min.js"></script>
<script>
const DATA = JSON.parse(document.getElementById("data").textContent);
const packs = DATA.packs;
const cats = [...new Set(packs.map(p=>p.category))].sort();
let activeCat = null, query = "";

const esc = s => (s||"").replace(/[&<>"]/g, c => ({"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;"}[c]));
const grid = document.getElementById("grid");
const chips = document.getElementById("chips");
document.getElementById("gen").textContent = "updated " + new Date(DATA.generated).toISOString().slice(0,10);

function renderChips(){
  chips.innerHTML = "";
  const all = document.createElement("span");
  all.className = "chip" + (activeCat===null?" on":"");
  all.textContent = "All";
  all.onclick = () => { activeCat=null; render(); };
  chips.appendChild(all);
  for(const c of cats){
    const el = document.createElement("span");
    el.className = "chip" + (activeCat===c?" on":"");
    el.textContent = c;
    el.onclick = () => { activeCat = activeCat===c?null:c; render(); };
    chips.appendChild(el);
  }
}

function render(){
  renderChips();
  const q = query.trim().toLowerCase();
  const list = packs.filter(p =>
    (activeCat===null || p.category===activeCat) &&
    (!q || p.name.toLowerCase().includes(q) || (p.description||"").toLowerCase().includes(q))
  );
  grid.innerHTML = "";
  if(!list.length){ grid.innerHTML = '<div class="empty">No packs match.</div>'; }
  for(const p of list){
    const card = document.createElement("div");
    card.className = "pcard";
    card.innerHTML =
      '<div class="cat">'+esc(p.category)+'</div>'+
      '<h3>'+esc(p.name)+' <span class="ver">v'+esc(p.version||"?")+'</span></h3>'+
      '<p>'+esc(p.description)+'</p>';
    card.onclick = () => openPack(p);
    grid.appendChild(card);
  }
  document.getElementById("count").textContent = packs.length + " packs";
}

function openPack(p){
  const panel = document.getElementById("panel");
  const runCmd = "nomad-pack run "+p.id+" --registry nomploy";
  let vars = "";
  if(p.variables && p.variables.length){
    vars = '<div class="section-title">Variables</div><table class="vartable"><thead><tr><th>Name</th><th>Default</th><th>Description</th></tr></thead><tbody>'+
      p.variables.map(v=>'<tr><td class="mono">'+esc(v.name)+'</td><td class="mono">'+esc(v.default||"—")+'</td><td>'+esc(v.description)+'</td></tr>').join("")+
      '</tbody></table>';
  }
  let readme = "";
  if(p.readme){
    try { readme = window.marked ? marked.parse(p.readme) : '<pre>'+esc(p.readme)+'</pre>'; }
    catch(e){ readme = '<pre>'+esc(p.readme)+'</pre>'; }
  }
  panel.innerHTML =
    '<div class="phead">'+
      '<div><h2>'+esc(p.name)+' <span class="ver">v'+esc(p.version||"?")+'</span></h2>'+
        '<div class="sub">'+esc(p.category)+'</div></div>'+
      '<button class="x" onclick="closePack()" aria-label="Close">×</button>'+
    '</div>'+
    '<div class="pbody">'+
      '<div class="addcmd"><div class="cmd" id="runcmd">'+esc(runCmd)+'</div>'+
        '<button class="copy" data-copy="#runcmd">Copy</button></div>'+
      '<div class="links">'+
        '<a href="'+esc(p.sourceUrl)+'" target="_blank" rel="noopener">Source ↗</a>'+
        (p.appUrl?'<a href="'+esc(p.appUrl)+'" target="_blank" rel="noopener">Project ↗</a>':'')+
      '</div>'+
      vars +
      (readme?'<div class="section-title">Readme</div>'+readme:'')+
    '</div>';
  bindCopy(panel);
  document.getElementById("overlay").classList.add("open");
  location.hash = p.id;
}
function closePack(){ document.getElementById("overlay").classList.remove("open"); if(location.hash) history.replaceState(null,"",location.pathname); }

function bindCopy(scope){
  scope.querySelectorAll(".copy").forEach(btn=>{
    btn.onclick = async () => {
      const t = scope.querySelector(btn.dataset.copy).textContent;
      try{ await navigator.clipboard.writeText(t); const o=btn.textContent; btn.textContent="Copied!"; setTimeout(()=>btn.textContent=o,1200);}catch(e){}
    };
  });
}

document.getElementById("q").addEventListener("input", e => { query = e.target.value; render(); });
document.getElementById("overlay").addEventListener("click", e => { if(e.target.id==="overlay") closePack(); });
document.addEventListener("keydown", e => { if(e.key==="Escape") closePack(); });
bindCopy(document);
render();
// deep-link to a pack via #id
if(location.hash){ const p = packs.find(x=>x.id===location.hash.slice(1)); if(p) openPack(p); }
</script>
</body>
</html>`;
}
