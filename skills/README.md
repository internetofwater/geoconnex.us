# Agent skills

[Agent skills](https://agentskills.io/home) are folders containing a
`SKILL.md` file that teach an AI coding agent how to work with Geoconnex. They
are plain markdown, so they work with any agent that supports the `SKILL.md`
convention.

The following skills are available:
- [`geoconnex-submission`](geoconnex-submission/SKILL.md) 
- [`geoconnex-querying`](geoconnex-querying/SKILL.md)

## Installing

### With `npx skills` (recommended)

The [`skills`](https://github.com/vercel-labs/skills) CLI works with Claude Code,
Cursor, Codex, and other agents, and downloads only the skill folders:

```sh
# both skills, into the current project
npx skills install internetofwater/geoconnex.us

# one skill, for all your projects
npx skills install internetofwater/geoconnex.us/geoconnex-querying -g
```

### Manually

Since the SKILL.md files are plain markdown, you can copy them into your agent's working directory and they should be discovered.

### Within Claude Code Directly

This repository contains `.claude-plugin` metadata to allow for installing the skills directly into Claude Code. You can do so via:

```
/plugin marketplace add internetofwater/geoconnex.us
/plugin install geoconnex@geoconnex
```

However, since Claude shallow clones the entire repository and the fact that the entire Geoconnex registry is very large, this will be inefficient and you should prefer usage of `npx skills` when possible.

## Testing locally

```sh
claude plugin validate .            # checks both manifests and every SKILL.md

claude plugin marketplace add ./    # the trailing slash matters; "." is rejected
claude plugin install geoconnex@geoconnex
claude plugin details geoconnex     # confirms which skills were discovered
```
