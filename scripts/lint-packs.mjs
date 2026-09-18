#!/usr/bin/env node
// Static format check for every pack in packs/. Zero dependencies.
// Fails (exit 1) on any error; warnings don't fail the build.
// Run: node scripts/lint-packs.mjs
import { readFileSync, readdirSync, existsSync, statSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const ROOT = join(dirname(fileURLToPath(import.meta.url)), "..");
const PACKS_DIR = join(ROOT, "packs");
const EXPECTED_URL = (id) => `https://github.com/Nomploy/nomad-packs/tree/main/packs/${id}`;
const REQUIRED_VARS = ["job_name", "namespace", "datacenters"];
const REQUIRED_FILES = ["metadata.hcl", "variables.hcl", "outputs.tpl", "README.md", "CHANGELOG.md"];

const read = (p) => (existsSync(p) ? readFileSync(p, "utf8") : null);
const strField = (block, key) => {
  const m = block && block.match(new RegExp(key + '\\s*=\\s*"((?:[^"\\\\]|\\\\.)*)"'));
  return m ? m[1] : null;
};

let errors = 0;
let warnings = 0;
const report = [];

const dirs = readdirSync(PACKS_DIR)
  .filter((d) => !d.startsWith("_") && statSync(join(PACKS_DIR, d)).isDirectory())
  .sort();

for (const id of dirs) {
  const dir = join(PACKS_DIR, id);
  const errs = [];
  const warns = [];
  const err = (m) => errs.push(m);
  const warn = (m) => warns.push(m);

  for (const f of REQUIRED_FILES) {
    if (!existsSync(join(dir, f))) err(`missing ${f}`);
  }

  // metadata.hcl
  const meta = read(join(dir, "metadata.hcl"));
  if (meta) {
    const packBlock = (meta.match(/pack\s*\{([\s\S]*?)\n\}/) || [, ""])[1];
    const appBlock = (meta.match(/app\s*\{([\s\S]*?)\n\}/) || [, ""])[1];
    if (!packBlock) err("metadata.hcl: no pack { } block");
    const name = strField(packBlock, "name");
    const version = strField(packBlock, "version");
    const desc = strField(packBlock, "description");
    const url = strField(packBlock, "url");
    const appUrl = strField(appBlock, "url");
    if (!name) err("metadata.hcl: pack.name missing");
    else if (name !== id) err(`metadata.hcl: pack.name "${name}" != directory "${id}"`);
    if (!desc) err("metadata.hcl: pack.description missing");
    else if (desc.length < 30) warn("metadata.hcl: pack.description is very short");
    if (!version) err("metadata.hcl: pack.version missing");
    else if (!/^\d+\.\d+\.\d+$/.test(version)) err(`metadata.hcl: pack.version "${version}" is not semver`);
    if (!url) warn("metadata.hcl: pack.url missing");
    else if (url !== EXPECTED_URL(id)) warn(`metadata.hcl: pack.url should be ${EXPECTED_URL(id)}`);
    if (!appUrl) warn("metadata.hcl: app.url missing");
  }

  // variables.hcl
  const vars = read(join(dir, "variables.hcl"));
  if (vars) {
    const names = [...vars.matchAll(/variable\s+"([^"]+)"/g)].map((m) => m[1]);
    for (const rv of REQUIRED_VARS) if (!names.includes(rv)) err(`variables.hcl: missing standard variable "${rv}"`);
    // every variable should have a description
    const re = /variable\s+"([^"]+)"\s*\{([\s\S]*?)\n\}/g;
    let m;
    while ((m = re.exec(vars))) {
      if (!/description\s*=/.test(m[2])) warn(`variables.hcl: variable "${m[1]}" has no description`);
    }
  }

  // template
  const tplDir = join(dir, "templates");
  if (!existsSync(tplDir)) {
    err("missing templates/ directory");
  } else {
    const tpls = readdirSync(tplDir).filter((f) => f.endsWith(".nomad.tpl"));
    if (!tpls.length) err("templates/: no *.nomad.tpl file");
    if (tpls.length && !tpls.includes(`${id}.nomad.tpl`)) warn(`templates/: expected ${id}.nomad.tpl (found ${tpls.join(", ")})`);
    for (const t of tpls) {
      const body = read(join(tplDir, t)) || "";
      // v2 parser: reject legacy dotted pack access like [[ .name ]] or [[ .pack.x ]]
      if (/\[\[-?\s*\.[A-Za-z_]/.test(body)) err(`templates/${t}: legacy v1 syntax "[[ .x ]]" — use [[ var "x" . ]]`);
      if (!/\bvar\s+"/.test(body)) warn(`templates/${t}: no 'var "…"' references found`);
      if (!/job\s+"/.test(body)) err(`templates/${t}: no job block found`);
    }
  }

  if (errs.length || warns.length) {
    report.push({ id, errs, warns });
  } else {
    report.push({ id, errs: [], warns: [] });
  }
  errors += errs.length;
  warnings += warns.length;
}

for (const r of report) {
  const status = r.errs.length ? "✗" : r.warns.length ? "!" : "✓";
  console.log(`${status} ${r.id}`);
  for (const e of r.errs) console.log(`    ERROR   ${e}`);
  for (const w of r.warns) console.log(`    warn    ${w}`);
}

console.log(`\n${dirs.length} packs · ${errors} error(s) · ${warnings} warning(s)`);
if (errors) {
  console.error("\nLint failed.");
  process.exit(1);
}
