---
name: build
description: >-
  Build a product from a written plan in one hands-off run, start to finish: read the plan, decide
  what it left open, build it, check it, fix what the check finds, and report. No phases, no gates,
  no questions along the way. Use this when someone has a plan (an idea8 plan, a PRD, a brief) and
  says "build it", "build this", "start the build", "take it from here" or runs /builder-kit:build.
  Nothing stops it along the way. Going live is a separate step the person asks for.
---

# Build

One run. Plan in, working product out.

Claude with a good plan already builds a working product. This skill does not slow that down. It adds what a plain build skips, the part that makes a product last: tests that stay in the repo, shared parts written once, security that is checked, a record of the decisions made on the person's behalf, and a second look by someone who did not build it.

Read `PRINCIPLES.md` in this plugin's root once before you start. It is one page.

## 1. Find the plan (under a minute)

Look for it in this order: a file the person pointed at, `docs/prd/`, `docs/idea/`, `docs/`, the project root.

- **There is a plan.** Read all of it. Carry on.
- **There is an idea8 export that hasn't been filed.** Run `/builder-kit:jiffi-import-idea8`, then carry on.
- **There is no plan, only a line or two.** This is the one question this skill asks. Do not build from a one-line request: a build from one line is a good product for a business that doesn't exist. Say so, and offer two ways forward: plan it in idea8, or let you write a one-page brief now (who it's for, what it does, what it doesn't, the rules of their business, how they'll know it works) for them to correct. Build only after they've seen a plan.

Then look for a brand: `brand/`, `docs/brand/`, or any design tokens file. Whatever is there decides colour, type, spacing and voice, even if it is only a tokens file and a note on voice. If the brand doesn't define a value you need (a line height, a focus ring, a tap size), use the plainest one and list them together, once, in `DECISIONS.md`. If there is no brand at all, use plain, accessible defaults and say so in the report.

## 2. Write the contract (a few minutes)

Write `docs/acceptance.md`: every acceptance criterion from the plan as one checkable line, in the plan's own words, with its id if it has one. Add the rules the plan states outside its criteria (limits, formats, who may do what). This file is what "done" is measured against. Do not add requirements of your own to it.

## 3. Decide, don't ask

The plan will leave things open. Decide them yourself and write each one down in `DECISIONS.md`, one line each: what you decided, why, and how to change it later.

- **How it's built.** Use the simplest thing that meets the plan's own limits. If the plan needs accounts, a hosted database or hosting, use what the person already has connected. Do not add a service the plan doesn't need.
- **Things the plan didn't say.** Take the safest, most ordinary option.
- **Holes in the plan.** Where the plan contradicts itself or leaves a rule out, pick the reading that does the least harm, and list it under "Holes in the plan" so the person sees it first.

Never stop to ask about any of these. A written decision the person can reverse is worth more to them than a question that stalls the build.

## 4. Build it

Read `references/foundation.md` first. It is the short list of what must be true of the project when you finish: one command to run and one to check, tests at three levels, shared parts written once, security that is checked, and a record. Set these up as you go. They are not a step at the end.

Then straight through, in this order, because each step is checked by the next:

1. The data and the rules of the business, defined once, with tests for every rule as you write it.
2. Whatever serves them (the API, the server, the jobs), with tests through the front door.
3. The shared components, then the screens built from them and from the brand's tokens.
4. The unglamorous parts: empty states, error messages a person can act on, loading, the phone layout, dark mode if the brand has one.
5. The browser tests for each main journey.

Keep going until it runs. Commit to git whenever a piece works, so there is always a good version to go back to (start a repository if there isn't one, and write `.gitignore` before the first commit). Stage by naming what you touched (`git add src tests README.md`), not `git add .` or `git add -A`: named paths go straight through, and a bulk add can pick up a secret. No branches per step, no progress documents, no status reports along the way.

## 5. Check it

Follow the `check` skill in this plugin. It runs the check command, walks every line of `docs/acceptance.md` with evidence, tries to break the product, looks at every screen, confirms the foundation is in place, and gets a second opinion from two reviewers who did not build it. Fix what it finds and run it again. Two rounds at most, then report anything still open.

## 6. Report

Short, and in plain language:

```
Built: <what it is, in one line>
Run it: <the command>
Acceptance: <n> of <n> met (docs/acceptance.md)
Check it: <the command>, and what it covers (<n> tests: rules, server, browser)
Found and fixed while checking: <the list, or "nothing">
Decisions I made for you: <how many> (DECISIONS.md). The ones to look at first: <up to three>
Holes in the plan: <the list, or "none">
Not checked: <what you could not verify, honestly>
```

Nothing else. The detail is in the files.

## Nothing stops the run

There are no gates, no approvals and no hooks that block. Once there is a plan, the build runs to the report without a question.

Building never needs to spend money, put anything live, delete someone's work or accept terms, so a build never does those things. If the plan seems to call for one (a paid service, a hosted database), build against a local stand-in, note it in `DECISIONS.md`, and leave the real thing to the `ship` step, which the person starts when they're ready. Never write a real password or key into a file: use a placeholder and list the name in `.env.example`.

## The skills this leans on

builder-kit doesn't repeat what another installed skill already does well. Use each one at its step, and carry on without it if it isn't installed.

| When | Skill | What it does here |
|------|-------|-------------------|
| Every piece of code you write | build-then-break | The smallest change that does the job, then a real attempt to break it. Keep the drill, skip its report after each change |
| Checking screens | Impeccable | Critique and audit, P0 to P2 fixed, inside the brand |
| Checking screens | UI UX Pro Max | Looks up the UX and accessibility rules. A lookup, never a designer |
| Anything a person will read | sound-human | Last pass on the README, messages and commit text. Remove the AI giveaways only. Add no opinions or personality to project documents |
| Before it goes live | find-then-doubt | A full security review that tries to knock down each of its own findings. `ship` runs it, and the person chooses what to fix. The build's own security pass in `check` still runs and never waits |
| Later changes | show-then-build | Shows a change before it's made. `iterate` hands over to it |
| The look | Brandi | Its tokens and components are the look. Never invent one |

## Keep it fast

If a step is taking longer than building the thing did, cut it down. Don't write a document nobody asked for. Don't take screenshots as proof. Don't re-check what a test already proves.
