import fs from "node:fs";
import path from "node:path";
import vm from "node:vm";

const root = path.resolve("web");
const pages = [
  "index.html",
  "marketplace.html",
  "provider-dashboard.html",
  "admin.html",
  "command-center.html",
  "properties.html",
  "billing.html",
  "presentation.html",
];
let failures = 0;
const fail = (page, message) => { failures++; console.error("FAIL", page, message); };
for (const page of pages) {
  const file = path.join(root, page);
  if (!fs.existsSync(file)) { fail(page, "page file is missing"); continue; }
  const html = fs.readFileSync(file, "utf8");
  const ids = [...html.matchAll(/\\bid=["']([^"']+)["']/g)].map(m => m[1]);
  const seen = new Set();
  for (const id of ids) {
    if (seen.has(id)) fail(page, `duplicate id: ${id}`);
    seen.add(id);
  }
  const scripts = [...html.matchAll(/<script\\b([^>]*)>([\\s\\S]*?)<\\/script>/gi)];
  let inlineIndex = 0;
  for (const [, attrs, source] of scripts) {
    if (!source.trim()) continue;
    inlineIndex++;
    try { new vm.Script(source, { filename: `${page}#inline-${inlineIndex}` }); }
    catch (error) { fail(page, `inline JavaScript syntax: ${error.message}`); }
  }
  const refs = new Set([
    ...[...html.matchAll(/getElementById\\(["']([^"']+)["']\\)/g)].map(m => m[1]),
    ...[...html.matchAll(/\\$\\(["']([^"']+)["']\\)/g)].map(m => m[1]),
  ]);
  for (const id of refs) if (!seen.has(id)) fail(page, `script references missing DOM id: ${id}`);
  console.log(`CHECKED ${page}: ${ids.length} ids, ${inlineIndex} inline scripts, ${refs.size} static DOM references`);
}
if (failures) { console.error(`\\n${failures} smoke-check failure(s)`); process.exit(1); }
console.log(`\\nSocialOS static smoke checks passed for ${pages.length} pages.`);
