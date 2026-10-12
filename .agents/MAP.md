# MAP

Index of the project. One line per entry: `path` — purpose — local docs.
Read this, then open only what your task needs. Limit: 100 lines; if bigger, split into
`<area>/MAP.md` sub-maps and link them here.

## Agent infrastructure
- `AGENTS.md` — universal entry point, rules for all agents
- `.agents/STATE.md` — current status, commands, next steps
- `.agents/DECISIONS.md` — append-only log of decisions (why things are the way they are)
- `.agents/ignore.md` — what agents must never read
- `.agents/playbooks/` — step-by-step procedures (bootstrap, new-module, finish-task, maintenance)
- `.agents/rules/` — topic rules loaded on demand
- `.agents/templates/` — templates for module docs, rules, ADRs
- `scripts/agent-lint.sh` — checks doc budgets and broken MAP links
- Tool adapters (pointers only, never add rules there): `CLAUDE.md`, `GEMINI.md`,
  `.github/copilot-instructions.md`, `.cursor/rules/agents.mdc`; ignore mirrors: `.cursorignore`, `.aiderignore`, `.geminiignore`
- `README.md` — human-facing description of the template

## Project areas
<!-- Filled by bootstrap/new-module playbooks. Format:
- `src/billing/` — payments & invoices — `src/billing/AGENTS.md`
-->
- (none yet)

## Rules index
- `.agents/rules/writing-agent-docs.md` — how to write any agent-facing doc
