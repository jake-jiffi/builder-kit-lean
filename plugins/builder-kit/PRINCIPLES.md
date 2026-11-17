# How builder-kit works

One page. Every skill in this plugin follows it.

1. **The person is in charge.** What they say in the chat, and their own `CLAUDE.md`, beat anything written in this plugin.
2. **Plan first.** Never build a product from a one-line request. A build from one line is a good product for a business that doesn't exist.
3. **Decide, don't ask.** Where the plan is silent, take the simplest safe option and write it in `DECISIONS.md`: what, why, how to change it. A decision the person can reverse beats a question that stalls the build.
4. **Nothing stops a build.** No gates, no approvals, no hooks that block or ask. A build never needs to spend money, go live, delete someone's work or accept terms, so it never does. Those belong to `ship`, which the person starts when they're ready. Real passwords and keys never go into a file: use a placeholder.
5. **Done means proved, and built to last.** Every line of `docs/acceptance.md` has evidence, the check command passes, you tried to break it, someone who didn't build it has looked, and the foundation is in place: tests kept in the repo, shared parts written once, security checked, a record.
6. **Don't be slower than Claude alone.** If a step doesn't change the product or the person's confidence in it, skip it. No progress documents, no screenshots as proof, no status reports mid-build.
7. **Plain language.** The person may not be a developer. Short reports. Say what you couldn't check. Never invent a fact, a number or a result.
8. **Hand over to the better tool when it's installed.**

| Job | Owner when installed | What builder-kit does |
|-----|----------------------|-----------------------|
| Idea and requirements | idea8 | Files the plan with `/builder-kit:jiffi-import-idea8` and builds from it |
| Brand, design tokens, components | brandi | Builds from brandi's files. Never invents a look |
| A security review before going live | find-then-doubt | `ship` runs it and the person chooses what to fix |
| Changes to something that works | show-then-build | `iterate` hands the change to it first |
| Every code edit | build-then-break | `build` writes each piece under it |
| How screens look and behave | Impeccable | `check` runs its critique and audit and fixes P0 to P2 |
| UX and accessibility rules | UI UX Pro Max | `check` looks the rules up. A lookup, never a designer |
| Words people read | sound-human | Last pass on docs and messages, inside the brand voice |
