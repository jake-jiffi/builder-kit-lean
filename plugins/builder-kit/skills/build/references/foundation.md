# The foundation

What must be true of the project when the build is done, so that the next change is safe to make. Claude builds a working product without being told. What it skips, unless asked, is the part that makes the product last: tests that stay in the repo, shared parts written once, security that is checked, and a record. That is what this page is for.

Scale each item to the size of the product. A small tool gets a small version. Never skip one.

## One way to run it, one way to check it

- **`README.md`**: what it is, how to run it, how to check it, where things live. Ten lines is enough.
- **One command starts it. One command checks it.** The check command (`npm run check`, or the stack's equivalent) runs the formatter or linter, the type checker if the project is written in a typed language, and every test. Don't add a type system just to have one to check.
- **The check works on a fresh machine.** If the browser tests need a browser, the check finds one that is already installed, or stops with the one line that installs it.
- **The same check runs on every push.** Put a workflow file in the repo (for GitHub, `.github/workflows/check.yml`) that runs the check command. It costs nothing until the project is on GitHub and then it works straight away.

## Tests at three levels, all kept in the repo

- **The rules.** Fast tests of every business rule and limit, with the edges: the boundary value, the wrong person, the second attempt. Most of the tests live here.
- **Through the front door.** Tests that call the running server the way a real client does: sign-in, permissions, bad input, two people at once.
- **In a real browser.** One test for each main journey, and an accessibility scan (axe) of every screen at phone and desktop width. These stay in the repo and run from the check command or a second command beside it. Never write a browser check and then delete it.
- **Every fault you find while breaking it gets a test**, so it can't come back.
- **Tests stand alone.** Each makes its own data. None depends on another, on the order, or on today's date.

## Shared parts, written once

- **Design tokens are the only place a colour, size, space or font is defined.** Screens use the tokens, never a raw value. If the brand ships tokens, use those, and add a token for anything it left out.
- **A small set of shared components** (button, field, message, card, layout and whatever this product repeats) that every screen is built from. If something appears twice, it is a component.
- **One definition of each kind of data and its rules**, used by the server and the screens alike. A rule is never written twice.
- **Shared helpers for what is easy to get subtly wrong:** dates and time zones, money, ids, error messages.
- **Organise by what the code is about**, and keep files small enough to read in one go.

## Security, checked and not assumed

The OWASP Top 10 is the yardstick. At least:

- **Every request is checked on the server:** who is asking, and whether they may. Hiding a button is not a check.
- **All input is validated at the edge** against the shared definition. Everything shown on a screen is escaped.
- **Secrets come from the environment only.** `.env.example` lists the names, `.env` is in `.gitignore`, and nothing secret appears in code, git or logs.
- **Passwords and PINs are stored with a slow hash.** Sessions live in cookies marked HttpOnly and SameSite, and Secure once live.
- **Limits:** slow down repeated sign-in attempts, cap the size of a request, and rate limit anything expensive.
- **Security headers:** a content security policy, no sniffing, no framing by other sites.
- **Dependencies:** as few as the job needs, the lockfile committed, and the audit free of High and Critical findings.
- **Errors** tell the person what to do next and tell an attacker nothing.

## A record

- **`docs/acceptance.md`** and **`DECISIONS.md`**, as the build skill describes.
- **A `CLAUDE.md` in the project** with the run and check commands, where things live, and the rules on this page in five to ten lines. Every later session, by anyone, then builds the same way. If the project already has one, add a section. Never overwrite it.
- **Git history:** a commit each time a piece works.
