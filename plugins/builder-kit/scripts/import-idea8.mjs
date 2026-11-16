#!/usr/bin/env node
/**
 * /builder-kit:jiffi-import-idea8: file an idea8 plan where the build skill looks
 * for it, so the build can start.
 *
 * idea8 (clarityclub.jiffi.co) does the interview and research and produces the plan.
 * This puts each document from its export under docs/idea/ and docs/prd/, which is
 * where /builder-kit:build reads from. It files documents. It decides nothing.
 *
 * Input: the idea8 MARKDOWN export, either the combined file (Export -> Markdown) or
 * the bundle.md from the zip. Both carry per-artifact `<!-- type: X -->` markers, which
 * is what we key off (the per-file zip names are title-slugs, not types).
 *
 *   node import-idea8.mjs <path-to-idea8-export.md | folder-with-bundle.md>
 */
import { readFileSync, writeFileSync, mkdirSync, existsSync, statSync } from 'node:fs'
import { join, dirname, resolve } from 'node:path'

// idea8 document type -> where it is filed.
const TYPE_TO_PATH = {
  idea_pack: 'docs/idea/idea-pack.md',
  prd: 'docs/prd/prd.md',
  competitive_landscape: 'docs/idea/competitive-landscape.md',
  assumption_register: 'docs/idea/assumptions.md',
  dependency_register: 'docs/idea/dependencies.md',
  feature_brief: 'docs/idea/feature-brief.md',
  commercialisation_blueprint: 'docs/idea/commercialisation.md',
}

const fail = (m) => { console.error(m); process.exit(1) }

let input = process.argv[2]
if (!input) fail('Usage: /jiffi-import-idea8 <path to the idea8 markdown export (the combined .md, or the bundle.md from the zip)>')
input = resolve(input)
if (!existsSync(input)) fail(`Not found: ${input}`)

// A folder (the unzipped export) -> use its bundle.md.
let file = input
if (statSync(input).isDirectory()) {
  const cand = join(input, 'bundle.md')
  if (!existsSync(cand)) fail(`No bundle.md in ${input}. In idea8, Export -> Markdown, or point me at the combined .md file.`)
  file = cand
}

const text = readFileSync(file, 'utf8')
const markerRe = /<!--\s*type:\s*([a-z_]+)\s*(?:\|[^>]*)?-->/g
const markers = [...text.matchAll(markerRe)]
if (markers.length === 0) fail('No idea8 artifacts found (expected `<!-- type: ... -->` markers). Use idea8\'s markdown export.')

const written = []
const skipped = []
for (let i = 0; i < markers.length; i++) {
  const type = markers[i][1]
  const path = TYPE_TO_PATH[type]
  const contentStart = markers[i].index + markers[i][0].length
  // This artifact's title is the last "# heading" before its marker.
  const before = text.slice(0, markers[i].index)
  const tm = before.match(/(?:^|\n)(#\s+.+?)\s*$/)
  const title = tm ? tm[1] : `# ${type}`
  // Content runs to the next artifact's heading (before the next marker), or EOF.
  let end = text.length
  if (i + 1 < markers.length) {
    const nextHeading = text.lastIndexOf('\n#', markers[i + 1].index)
    end = nextHeading > contentStart ? nextHeading : markers[i + 1].index
  }
  const body = text.slice(contentStart, end).trim()
  if (!path) { skipped.push(`${type} (no builder-kit mapping)`); continue }
  const dest = join(process.cwd(), path)
  mkdirSync(dirname(dest), { recursive: true })
  writeFileSync(dest, `${title}\n\n${body}\n`)
  written.push(`${type.padEnd(26)} -> ${path}`)
}

console.log(`Imported ${written.length} idea8 artifact(s) into this project:`)
for (const w of written) console.log(`  ✓ ${w}`)
if (skipped.length) { console.log('Skipped (no mapping):'); for (const s of skipped) console.log(`  - ${s}`) }
console.log('\nNext: run /builder-kit:build. It reads the plan from docs/ and builds the product in one run.')
