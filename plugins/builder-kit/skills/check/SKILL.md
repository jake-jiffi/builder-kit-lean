---
name: check
description: >-
  Check a finished build before anyone calls it done: run the tests, prove every acceptance
  criterion, try to break it, look at every screen, and get a second opinion from reviewers who did
  not build it. Use it at the end of /builder-kit:build, and on its own whenever someone asks "is
  this done", "check my build", "is it safe to launch", "review what you built" or "does it meet
  the plan".
---

# Check

One pass over the whole product. Fix what you find, then run it again. Two rounds at most.

## 1. The check command

Run the project's one check command: lint, types, every test. All of it passes, or you fix the code. Never loosen a test to make it pass. If there is no single check command yet, make one.

## 2. The contract

Go down `docs/acceptance.md` line by line. Each line gets evidence: the name of the test that proves it, or what you did and what you saw. "It looks right" is not evidence. A line you can't prove is not met. Say so.

## 3. Break it

Use the product the way it will be misused. At least these:

- **Bad input.** Empty, far too long, the wrong type, impossible dates and times, broken data.
- **Two at once.** The same action from two people at the same moment. Exactly one should win.
- **Someone pretending.** Not signed in. Signed in as the wrong person. Extra fields that claim a role, an owner or a status.
- **Guessing.** Repeated wrong passwords or PINs. Something should slow them down.
- **Restart.** Stop it and start it. Nothing is lost.
- **Whatever this product is most likely to get wrong.** Name it, then try it.

Everything that breaks gets fixed and gets a test. If a fix changes something the plan spelled out (a new reply code, an extra confirm step), keep the fix and list it under "Holes in the plan" in the report, so the person decides.

## 4. Screens

Open every screen in a real browser (the Playwright tools, or headless Chrome), signed out and signed in, as each kind of person.

- Phone width (390) and desktop (1440). Nothing cut off, no sideways scroll.
- Light, and dark if the brand has it.
- Keyboard only: you can reach and use everything, and you can see where you are.
- Contrast and labels: run an accessibility checker (axe) and fix every finding.
- The page doesn't jump while it loads on a slow connection.
- Text someone typed shows as text. It never runs as code.
- The words match the brand's voice and say what to do next.

Looking at a screen is the point. Keeping screenshots is not: take them outside the project and throw them away.

If Impeccable is installed, use it the hands-off way: run its detector on every screen and do one critique and audit pass yourself, then fix what's P0 to P2. Skip its interview, its sub-agents and its saved reports, and don't add anything it tells you to say to your report. If its detector flags something the brand decided, the brand wins. If UI UX Pro Max is installed, look up the rules for these screens (`--domain ux`) and fix what's High or Medium. A rule that doesn't apply to this product is not a finding. Neither chooses colours, fonts or styles when a brand exists.

## 5. Safety

- Search the code and the git history for passwords, keys and tokens. None should be there. `.env` is in `.gitignore` and `.env.example` lists the names.
- Passwords and PINs are stored hashed. Nothing secret comes back in a reply.
- Every action is checked on the server, not just hidden on the screen.
- Run the package manager's audit and fix High and Critical findings.

## 6. The foundation

Go down `skills/build/references/foundation.md` in this plugin and confirm each item is true of this project: README, one run command and one check command, the check wired to run on every push, tests at all three levels and kept in the repo, tokens and shared components with no raw values in screens, one definition of each rule, the record files, the project `CLAUDE.md`, work committed. Anything missing, add it now.

## 7. A second opinion

You built this, so you will read it the way you meant it. If you can start other agents, start both of these at once, once:

- `ac-verifier`: checks the contract against the running product, from scratch.
- `security-auditor`: reviews the whole build for the ways it can be abused.

Fix what they find. If you can't start agents, say in the report that the second opinion didn't happen.

## Then

Tell the build what you found and fixed, and what is still open. Keep no screenshots and write no report file unless the person asks for one.
