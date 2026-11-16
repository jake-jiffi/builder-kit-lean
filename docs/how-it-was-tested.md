# How builder-kit 1.0 was tested (17 November 2026)

The same small product (a shift swap board for a cafe, from an idea8-style plan and a brand) was built five ways by the same top model, then graded two ways.

**The product checks** were written before any build was seen: 27 on what the plan asked for, 16 on things a careful build handles without being told, plus accessibility scans at phone and desktop width in light and dark.

**The foundation scorecard** is 13 yes or no items taken from what the kit is meant to guarantee: a README; work committed; one check command; a linter or formatter; the check wired to run on every push; browser tests kept in the repo; an accessibility scan in the tests; no raw colours outside the tokens; a shared components layer; data and secrets ignored by git; a decisions file; an acceptance contract; a project CLAUDE.md. It was written after the plain builds were seen, so treat it as "does the build do what was asked", not as a blind test.

| How it was built | Runs | Product checks | Foundation | Time | Tokens |
|---|---|---|---|---|---|
| Plan, then "build this" | 2 | 43 of 43, twice | 1 and 2 of 13 | 16 and 22 min | 237k and 266k |
| The same, plus one sentence asking for tests, security, shared components and a README | 1 | 43 of 43 | 7 of 13 | 34 min | 289k |
| builder-kit 0.9, full setup | 2 | 43 of 43, twice | 8 of 13, twice | 70 and 115 min | 655k and 719k |
| builder-kit 1.0 lean, full setup | 2 | 43 of 43, twice | 13 of 13, twice | 42 and 45 min | 371k and 376k |

What the plain builds left out: no README, nothing committed to git, no decisions file, no acceptance contract, no project CLAUDE.md, no lint, no check on push, no shared components layer. One of the two wrote browser tests and then deleted them.

What one sentence bought: most of the engineering (170 tests kept, a check command, a workflow file, components, shared rules, a README). It still committed nothing and left no decisions file, contract or project CLAUDE.md.

What 0.9 left out despite five times the effort: no single check command, no lint, no check on push, no components layer.

Limits:
- One small product, one or two runs each.
- The test agents read the skills. They could not start the two reviewer agents, so the "second opinion" step did not run in any lean build. Both said so in their reports, as the skill tells them to.
- Hooks do not fire for the test agents. The one remaining hook has its own tests.
- The kit validates and installs in real Claude Code (2.1.325, a clean home folder, from this repository). A build has not been run in real Claude Code, on a Mac or on Windows.
- After these runs the kit changed in response to what the two lean builds reported: a reviewer rewritten to fit the lean build, a short way to use Impeccable hands-off (the design steps were the slowest part of both lean builds), and clearer rules on brand files and project documents. Those changes have not been through a build. The same goes for the commit rule (stage by naming paths) and the idea8 importer's new next step, though both have tests in the kit's own suite.
