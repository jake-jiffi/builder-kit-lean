# builder-kit

Give Claude a written plan. Get back a working product that is set up to last.

Claude already builds a small product well from a good plan. builder-kit doesn't slow that down or fence it in. It adds the part a plain build skips:

- **Tests that stay in the repo**, at three levels: the rules, the server, a real browser.
- **Shared parts written once**: design tokens, a small set of components, one definition of each rule.
- **Security that is checked**, with the OWASP Top 10 as the yardstick.
- **A record**: every decision made on your behalf, the acceptance contract, a README and a project `CLAUDE.md` so every later session builds the same way.
- **A second look** by reviewers who didn't build it.

## How it runs

```
/builder-kit:build
```

One run, start to finish. No phases, no approvals, no questions along the way. Where the plan is silent it decides, and writes the decision in `DECISIONS.md` for you to change later. The only time it asks anything is when there is no plan at all, because a build from one line is a good product for a business that doesn't exist.

**Nothing in this plugin stops a build.** It has one hook, and that hook only removes permission prompts for a short list of routine commands: saving and inspecting with git, and the project's own tests and build (which run the project's own scripts, so use it on a project you trust). It never blocks and never asks.

## What's in it

| Piece | What it does |
|---|---|
| `/builder-kit:build` | The whole build: find the plan, write the contract, decide, build, check, report |
| `/builder-kit:check` | Proves a build: the check command, every acceptance line, a real attempt to break it, every screen, the foundation, a second opinion |
| `/builder-kit:iterate` | A change to something that works. Hands over to show-then-build first |
| `/builder-kit:ship` | Going live. The one place it waits for your yes |
| `/builder-kit:jiffi-import-idea8` | Files an idea8 plan into the project |
| `ac-verifier`, `security-auditor` | Fresh-eyes reviewers the check starts once, at the end |
| `skills/build/references/foundation.md` | The short list of what must be true of every project when it's done |

## It leans on the skills you already have

builder-kit doesn't repeat what another skill does well. When these are installed it uses them, and carries on without any that aren't: build-then-break for every piece of code, show-then-build for later changes, find-then-doubt for the security review before going live, Impeccable and UI UX Pro Max for checking screens, sound-human for anything a person will read, Brandi for the look.

## What changed from 0.9

0.9 ran a build in phases with gates, a state machine, checkpoints and eleven hooks. In a side-by-side test on a small product it scored the same as plain Claude with the same plan and took about five times as long. 1.0 removes the phases, gates, checkpoints, the state machine and every hook that could block or ask, and keeps what the test showed was worth having.

| | 0.9 | 1.0 |
|---|---|---|
| Skills | 29 | 4 |
| Commands | 8 | 1 |
| Hooks | 11, two could block and one could ask | 1, never blocks or asks |
| Reviewer agents | 8 | 2 |
| Stops during a build | 4 gates, plus checkpoints per phase | None |
