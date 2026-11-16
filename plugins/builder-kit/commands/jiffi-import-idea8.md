---
description: File an idea8 plan (clarityclub.jiffi.co) into this project, so /builder-kit:build can start from it. Puts the idea pack, the requirements and the supporting documents under docs/.
argument-hint: "[path to the idea8 markdown export]"
allowed-tools: Bash(node:*)
---

Bring an idea8 plan into this project. idea8 does the interview and the research. This files what it produced where the build skill looks for it. It runs no model and decides nothing.

Run the importer on the idea8 markdown export the person downloaded (the combined `Export -> Markdown` file, or the `bundle.md` from the zip):

```
node "${CLAUDE_PLUGIN_ROOT}/scripts/import-idea8.mjs" $1
```

It reads each document's `<!-- type: ... -->` marker, not the file name. The idea pack goes to `docs/idea/idea-pack.md`, the requirements to `docs/prd/prd.md`, and the rest (competitors, assumptions, dependencies, feature brief, commercial plan) into `docs/idea/`.

When it finishes, say which documents were filed and where, then carry on with `/builder-kit:build` if a build was asked for. If it found no markers, the export is probably not Markdown: ask the person to export from idea8 as Markdown, or to unzip the export and point at `bundle.md`.
