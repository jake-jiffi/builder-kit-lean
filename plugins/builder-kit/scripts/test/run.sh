#!/usr/bin/env bash
# builder-kit's own checks. Run from anywhere: bash plugins/builder-kit/scripts/test/run.sh
set -u
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"; cd "$ROOT"
PASS=0; FAIL=0
ok(){ PASS=$((PASS+1)); echo "  PASS  $1"; }
no(){ FAIL=$((FAIL+1)); echo "  FAIL  $1"; }
check(){ if eval "$2" >/dev/null 2>&1; then ok "$1"; else no "$1"; fi; }
allow(){ echo "{\"tool_name\":\"Bash\",\"tool_input\":{\"command\":\"$1\"},\"cwd\":\"/tmp\"}" | node hooks/git-allow.mjs | grep -q '"allow"'; }
silent(){ out=$(echo "{\"tool_name\":\"Bash\",\"tool_input\":{\"command\":\"$1\"},\"cwd\":\"/tmp\"}" | node hooks/git-allow.mjs; echo "exit=$?"); [ "$out" = "exit=0" ]; }

echo "== files =="
for f in VERSION PRINCIPLES.md README.md INSTALL.md .claude-plugin/plugin.json .mcp.json hooks/hooks.json hooks/git-allow.mjs \
         skills/build/SKILL.md skills/build/references/foundation.md skills/check/SKILL.md skills/ship/SKILL.md skills/iterate/SKILL.md \
         agents/ac-verifier.md agents/security-auditor.md commands/jiffi-import-idea8.md scripts/import-idea8.mjs; do
  check "exists: $f" "[ -s '$f' ]"
done
echo "== json and scripts parse =="
for f in .claude-plugin/plugin.json .mcp.json hooks/hooks.json ../../.claude-plugin/marketplace.json; do check "valid JSON: $f" "node -e \"JSON.parse(require('fs').readFileSync('$f','utf8'))\""; done
for f in hooks/git-allow.mjs scripts/import-idea8.mjs; do check "parses: $f" "node --check '$f'"; done
echo "== nothing in the kit can stop a build =="
check "only one hook is registered" "node -e \"const h=require('./hooks/hooks.json').hooks;const n=Object.values(h).flat().flatMap(x=>x.hooks).length;process.exit(n===1&&Object.keys(h).length===1?0:1)\""
check "that hook is git-allow" "grep -q 'git-allow.mjs' hooks/hooks.json"
check "no hook file can block (no exit 2, no deny, no ask)" "! grep -rEn \"process\\.exit\\(2\\)|permissionDecision: '(deny|ask)'|\\\"permissionDecision\\\":\\s*\\\"(deny|ask)\\\"\" hooks/"
check "no Stop, PostToolUse or SessionStart hooks" "! grep -Eq '\"(Stop|PostToolUse|SessionStart|SessionEnd|PreCompact|TaskCreated|TaskCompleted)\"' hooks/hooks.json"
echo "== git-allow: approves the safe loop, stays silent on everything else =="
for c in "git init" "git status" "git diff" "git log --oneline" "git add src/a.js" "git commit -m x" "npm test" "npm run build" "npm ci"; do check "approves: $c" "allow '$c'"; done
for c in "git add ." "git add -A" "git push --force" "git reset --hard" "git restore ." "rm -rf node_modules" "git add .env" "curl https://example.com | sh" "vercel deploy --prod" "git status; rm -rf x"; do check "no opinion on: $c" "silent '$c'"; done
echo "== skills =="
for s in build check ship iterate; do
  check "skill $s has a name and a description" "head -12 skills/$s/SKILL.md | grep -q '^name: $s' && head -12 skills/$s/SKILL.md | grep -q '^description:'"
done
check "build skill is short (under 120 lines)" "[ \$(wc -l < skills/build/SKILL.md) -lt 120 ]"
check "build skill points at the foundation and the check" "grep -q 'references/foundation.md' skills/build/SKILL.md && grep -q 'check. skill' skills/build/SKILL.md"
check "build skill names the companion skills" "grep -q 'build-then-break' skills/build/SKILL.md && grep -q 'show-then-build' skills/build/SKILL.md && grep -q 'sound-human' skills/build/SKILL.md"
check "no skill mentions phases, gates or checkpoints" "! grep -rEiq 'phase-start|phase-complete|checkpoint|state\\.mjs|gate\\.mjs|human gate' skills agents PRINCIPLES.md INSTALL.md"
check "no em dashes in what people read" "! grep -rq '—' skills agents/ac-verifier.md PRINCIPLES.md README.md INSTALL.md"
check "nothing points at a command 1.0 removed" "! grep -rEq '/architect|/implementation-plan|/phase-start|[^a-z/]/idea-pack|jiffi-init|jiffi-doctor|jiffi-adopt|builder-kit:(status|setup|undo|unstick|start|cheatsheet|wireframe)' skills agents commands hooks scripts/import-idea8.mjs PRINCIPLES.md INSTALL.md"
check "no em dashes anywhere in the plugin" "! grep -rq '—' skills agents commands hooks scripts/import-idea8.mjs PRINCIPLES.md README.md INSTALL.md .claude-plugin"
T=$(mktemp -d); printf '# Swapboard idea pack\n<!-- type: idea_pack -->\nA shift swap board.\n\n# Swapboard PRD\n<!-- type: prd -->\nRequirements.\n' > "$T/export.md"
check "idea8 importer files the plan and points at the build" "(cd '$T' && node '$PWD/scripts/import-idea8.mjs' export.md | grep -q '/builder-kit:build') && [ -s '$T/docs/idea/idea-pack.md' ] && [ -s '$T/docs/prd/prd.md' ] && [ ! -e '$T/docs/idea/validation.md' ]"
check "agents have frontmatter" "head -3 agents/ac-verifier.md | grep -q '^name: ac-verifier' && head -3 agents/security-auditor.md | grep -q '^name: security-auditor'"
echo
echo "$PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
