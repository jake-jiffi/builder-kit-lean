<!-- clarity-build-setup:start v2 -->
# How I build

My standing rules for every project. They say which tool owns which job, so the tools work together and never fight. What I say in the chat always wins over this file.

## The order

1. **Plan first.** If the project has an idea8 plan (`docs/idea/`, `docs/prd/`), read it before anything else. If there is no plan and the job is bigger than a small change, stop and ask me for one, or offer to write a one-page brief. Never start a product from a one-line prompt.
2. **Brand before screens.** If the project has no brand (no `brand/brand.json`, no `docs/brand/`, no design tokens), say so before building any screen and offer `/brandi:brand`. Once a brand exists, it decides colour, type, spacing and voice.
3. **Build in one run.** A new product is built with `/builder-kit:build`, start to finish, with no stops for questions. It decides what the plan left open and writes each decision in `DECISIONS.md`.
4. **Show before you change.** For any feature, change, redesign or fix to something that already works, use show-then-build: show me a preview and wait for my yes before touching the real files. Tiny edits skip the preview.
5. **Break what you build.** Every time you write or change code, in any step above, use build-then-break.
6. **Check every screen** before calling it done (see Design).
7. **Review security before it goes live.** Use find-then-doubt, and whenever I ask whether something is secure.
8. **Write like a person.** Use sound-human on anything a person will read.

## Who owns what

| Job | Owner | Rule for the rest |
|---|---|---|
| Idea, research, requirements | idea8 | Bring it in with `/builder-kit:jiffi-import-idea8`. builder-kit builds from it |
| Brand: logo, colour, type, voice, tokens, components | Brandi | builder-kit builds from Brandi's tokens and components and never invents a look |
| Marketing or content website | Palate | Built from the Brandi brand. Not builder-kit's app stack |
| The app: the build, the tests, the security checks, the shared components, launch | builder-kit | It runs the first build end to end and leaves the project set up to last |
| Changes after the first build | show-then-build | A change that adds a feature to a builder-kit project then goes through `/builder-kit:iterate`, with the approved preview as its brief |
| Every code edit | build-then-break | Applies inside builder-kit's build too |
| Security review | find-then-doubt | builder-kit's build does its own security pass and never waits. find-then-doubt is the full review before going live. Don't fix a finding until I say which |
| How screens look and behave in the code | Impeccable | Works inside the brand. Never proposes its own direction when a brand exists |
| UX rules, accessibility, charts, framework patterns | UI UX Pro Max | A lookup and a checklist, never a designer |
| Wording | sound-human | Works inside the brand voice |
| Images, video, sound | Higgsfield CLI, through Brandi or Palate | Only when installed and signed in, inside a credit cap I agree to |

## Design

**The brand.** The project's brand files are the source of truth, whatever shape they are in: Brandi's `brand/brand.json` and `brand/tokens/`, or just a tokens file and a note on voice. If a screen needs a colour, size or font the brand doesn't define, ask me. If I'm not there, use the plainest value that fits, and list it for me to confirm. When Brandi made the brand, run `/brandi:brand-check` on anything that carries it before it ships.

**Impeccable.** It works inside the brand and never chooses a new look. In a hands-off build, use it the short way: run its checker on every screen you built or changed, in light and dark, do one critique and audit pass, and fix every P0, P1 and P2 finding and every checker warning. Skip its interview and its saved reports. If its checker flags something the brand decided on purpose, the brand wins. When I ask for a full design review, run the whole thing: `critique`, `audit`, `harden`, `adapt`, `polish`, then `document`.

**UI UX Pro Max.** Its search script is `~/.claude/skills/ui-ux-pro-max/scripts/search.py`. Always run it by that full path (`python3`, or `python` on Windows). Search it with `--domain ux` and `--stack <this project's framework>`, and with `--domain chart` when choosing a chart. Its own instructions say to start with `--design-system`. Ignore that: never run `--design-system`. Never take its palettes, fonts or styles, and never let it write tokens, logos or brand files. The one exception: a brand new project with no brand and no code, where it may suggest a starting direction for me to choose from. It returns rules, not a report, so check each screen against the rules it returns. A rule that doesn't apply to this product is not a finding. Leave no Critical, High or Medium finding open. If one of its rules contradicts the brand, builder-kit's rules or sound-human, they win: note it and move on. If it has no entry for this project's framework, use the nearest one.

## Build

- Nothing stops a builder-kit build. It decides what the plan left open and writes it down. Going live is a separate step, `/builder-kit:ship`, that I start myself.
- A build isn't done until builder-kit's `check` has passed.
- Before the first launch, and before any change that touches sign-in, payments, personal data or file uploads, run find-then-doubt at its Deep level. I choose which findings to fix. Contained fixes go through build-then-break, and fixes I would see go through show-then-build. If find-then-doubt isn't installed, run builder-kit's `security-auditor`.
- The first build ends when `check` passes and builder-kit reports. Everything after that is a change, and goes through show-then-build.
- show-then-build picks the size of a change. Small goes straight to build-then-break. Standard and Open get a preview and my yes first.
- Never deploy, spend money, delete data or accept terms without my clear yes.
- Never put passwords, API keys or `.env` files into code, commits or chat.

## Writing

- sound-human is the last pass on emails, documents, posts, page copy and commit messages. Give me the finished text only, not the draft and the audit, unless I ask.
- Never invent facts, numbers, quotes or personal stories to make text sound human. If a detail is missing, ask me or leave it out.
- In product screens, the brand voice and builder-kit's copy rules choose the words. sound-human only removes the AI giveaways.
- Australian English.

## How to work with me

- Tell me when my idea has a hole. Don't just agree with me.
- When the direction is open, give me three options and say which you would pick.
- When something breaks, show me the exact error.
- Use plain language. I may not be a developer.
- If a tool named here isn't installed, say so in one line and carry on with the rest.
<!-- clarity-build-setup:end -->
