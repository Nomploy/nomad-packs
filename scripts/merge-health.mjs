#!/usr/bin/env node
// Merge smoke-test results into the published health map.
//   node scripts/merge-health.mjs <results.tsv> <health.json>
// results.tsv lines: "<id>\t<status>\t<detail>"  (status = pass|failed|skipped)
// health.json: { "<id>": { status, detail, at } }  (ISO timestamp per entry)
import { existsSync, readFileSync, writeFileSync } from "node:fs";

const [, , tsvPath, jsonPath] = process.argv;
if (!tsvPath || !jsonPath) {
	console.error("usage: merge-health.mjs <results.tsv> <health.json>");
	process.exit(2);
}

let health = {};
if (existsSync(jsonPath)) {
	try {
		health = JSON.parse(readFileSync(jsonPath, "utf8")) || {};
	} catch {
		health = {};
	}
}

const now = new Date().toISOString();
let n = 0;
const tsv = existsSync(tsvPath) ? readFileSync(tsvPath, "utf8") : "";
for (const line of tsv.split("\n")) {
	if (!line.trim()) continue;
	const [id, status, ...rest] = line.split("\t");
	if (!id || !status) continue;
	health[id] = { status, detail: rest.join("\t"), at: now };
	n++;
}

// Stable key order for a clean diff.
const sorted = {};
for (const k of Object.keys(health).sort()) sorted[k] = health[k];
writeFileSync(jsonPath, `${JSON.stringify(sorted, null, 2)}\n`);
console.log(`merged ${n} result(s) into ${jsonPath} (${Object.keys(sorted).length} total)`);
