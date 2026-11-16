---
name: ship
description: >-
  Put a checked build live. This is the one place builder-kit waits for the person: it shows what
  will go live, where, and what it costs, and waits for a clear yes. Use it when someone says "ship it", "launch",
  "deploy", "put it live", "publish it" or "go live".
---

# Ship

Going live is the person's decision, every time.

1. **Check first.** If the `check` skill hasn't passed since the last change, run it. Don't ship something with an open finding without saying so.
2. **Review security.** If the find-then-doubt skill is installed and it hasn't reviewed the project since the last change, run it now, at its Deep level when the product has sign-in, payments, personal data or file uploads. Show the person what it confirmed and let them choose what to fix before going live. Fixes go the way that skill says. If it isn't installed, start the `security-auditor` reviewer and say that a fuller review is available.
3. **Show what's about to happen.** In plain words: what goes live, where, who will be able to see it, what it will cost, and how to take it down again. Name every account you'll use.
4. **Wait for a clear yes.** Signing in to a provider, creating a hosted project or database, accepting terms and anything that charges money each need their own yes. Never accept terms for the person.
5. **Secrets go in the host's settings**, never in the code or in git. Tell the person which ones to add and where.
6. **Do it, then prove it.** Open the live address. Run the main journey once as a real user would. Say what you saw.
7. **Leave a way back.** Write down in `DECISIONS.md` where it's hosted, how to redeploy and how to roll back.
