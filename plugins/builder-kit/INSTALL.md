# Installing builder-kit

You need git, Node 22 or later, and Claude Code. Clarity Desktop installs all three.

```bash
claude plugin marketplace add jake-jiffi/builder-kit-lean
claude plugin install builder-kit@builder-kit-lean
```

If the earlier builder-kit is installed (`claude plugin list` shows `builder-kit@jiffi-claude-plugins`), remove it first with `claude plugin uninstall builder-kit@jiffi-claude-plugins`. The two share a name and can't run side by side.

Quit Claude Code and open it again. Then, in a project that has a plan:

```
/builder-kit:build
```

## For a build that never stops

builder-kit itself never stops a build. Claude Code has its own permission modes, and they decide whether it asks before it runs a command. Recent versions (2.1.283 and later) start in the automatic mode, which makes those calls for you. If yours asks before every command, Shift+Tab switches modes, and the current mode shows under the prompt. The mode applies to everything Claude Code does, so use the automatic one in a project folder you're happy for it to work in freely.

## Working on the kit itself

Add the marketplace by local path so your working copy is the source:

```bash
claude plugin marketplace add /path/to/builder-kit
claude plugin install builder-kit@builder-kit-lean
```

Run the kit's own checks with `bash plugins/builder-kit/scripts/test/run.sh`.
