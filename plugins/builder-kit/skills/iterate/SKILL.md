---
name: iterate
description: >-
  Change or add to a product that already works. Use it when someone asks to add a feature, change
  how something works or fix something in a product builder-kit built, or runs /builder-kit:iterate.
---

# Iterate

A change to something that works starts with the person seeing it first.

1. **If the show-then-build skill is installed, use it.** It decides whether the change needs a preview, shows it, and waits for a yes. Small fixes skip the preview.
2. **If it isn't installed:** for anything bigger than a small fix, describe the change in a few lines (what will be different, what won't), and wait for a yes. That is the only stop.
3. **Update the contract.** Add or change the lines in `docs/acceptance.md` that the change touches. Note the decision in `DECISIONS.md`.
4. **Build it**, the same way as `build`: smallest change that does the job, tests for every new rule.
5. **Check it** with the `check` skill, including everything the change could have broken.
6. **Report** in the same short shape as `build`.
