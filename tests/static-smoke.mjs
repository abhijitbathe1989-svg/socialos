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
  const ids = [...html.matchAll(/\bid=["']([^"']+)["']/g)].map(m => m[1]);
  const seen = new Set();
  for (const id of ids) {
    if (seen.has(id)) fail(page, `duplicate id: ${id}`);
    seen.add(id);
  }
  const scripts = [...html.matchAll(/<script\b([^>]*)>([\s\S]*?)<\/script>/gi)];
  let inlineIndex = 0;
  for (const [, attrs, source] of scripts) {
    if (!source.trim()) continue;
    inlineIndex++;
    try { new vm.Script(source, { filename: `${page}#inline-${inlineIndex}` }); }
    catch (error) { fail(page, `inline JavaScript syntax: ${error.message}`); }
  }
  const localTargets = new Set();
  for (const [, raw] of html.matchAll(/\b(?:href|src)=["']([^"']+)["']/gi)) {
    const value = raw.trim();
    if (!value || /^(?:https?:|mailto:|tel:|data:|javascript:|#|\/)/i.test(value) || value.includes("${")) continue;
    const target = value.split(/[?#]/)[0];
    if (target) localTargets.add(path.resolve(root, path.dirname(page), target));
  }
  for (const target of localTargets) {
    if (!fs.existsSync(target)) fail(page, `broken local link or asset: ${path.relative(root, target)}`);
  }

  // Validate same-page and local-page fragment navigation targets.
  const links = [...html.matchAll(/<a\\b([^>]*?)\\bhref=["']([^"']+)["']([^>]*)>/gi)];
  for (const [, before, href, after] of links) {
    const targetBlank = /\\btarget=["']_blank["']/i.test(before + after);
    if (targetBlank && !/\\brel=["'][^"']*noopener/i.test(before + after)) {
      fail(page, `external/new-tab link lacks rel="noopener": ${href}`);
    }
    if (!href.includes("#") || /^(?:https?:|mailto:|tel:|javascript:)/i.test(href)) continue;
    const [rawPath, rawFragment] = href.split("#");
    if (!rawFragment) continue;
    const targetPath = rawPath ? path.resolve(root, path.dirname(page), rawPath.split("?")[0]) : file;
    if (!fs.existsSync(targetPath) || !targetPath.endsWith(".html")) continue;
    const targetHtml = fs.readFileSync(targetPath, "utf8");
    const targetIds = new Set([...targetHtml.matchAll(/\\bid=["']([^"']+)["']/g)].map(m => m[1]));
    let fragment = rawFragment;
    try { fragment = decodeURIComponent(rawFragment); } catch {}
    if (!targetIds.has(fragment)) fail(page, `broken navigation fragment: ${href}`);
  }
  const refs = new Set([
    ...[...html.matchAll(/getElementById\(["']([^"']+)["']\)/g)].map(m => m[1]),
    ...[...html.matchAll(/\$\(["']([^"']+)["']\)/g)].map(m => m[1]),
  ]);
  for (const id of refs) if (!seen.has(id)) fail(page, `script references missing DOM id: ${id}`);
  console.log(`CHECKED ${page}: ${ids.length} ids, ${inlineIndex} inline scripts, ${refs.size} static DOM references`);
}
// Public search surfaces must use the live, server-side search RPCs.
const searchContracts = {
  "marketplace.html": ["search_marketplace_providers", "search_global_services", "search_global_cities"],
  "properties.html": ["search_published_property_listings_v2", "search_published_property_service_providers", "search_global_cities"],
};
for (const [page, requiredFunctions] of Object.entries(searchContracts)) {
  const html = fs.readFileSync(path.join(root, page), "utf8");
  for (const functionName of requiredFunctions) {
    if (!html.includes(`.rpc("${functionName}"`) && !html.includes(`.rpc('${functionName}'`)) {
      fail(page, `live search RPC is not wired: ${functionName}`);
    }
  }
}
const marketplaceHtml = fs.readFileSync(path.join(root, "marketplace.html"), "utf8");
if (marketplaceHtml.includes(".limit(500)")) fail("marketplace.html", "legacy capped client-side provider search remains");
const propertyHtml = fs.readFileSync(path.join(root, "properties.html"), "utf8");
if (propertyHtml.includes('from("published_property_service_providers")')) {
  fail("properties.html", "legacy direct property-provider query remains");
}
if (failures) { console.error(`\n${failures} smoke-check failure(s)`); process.exit(1); }
console.log(`\nSocialOS static smoke checks passed for ${pages.length} pages.`);
