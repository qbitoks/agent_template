# AGENTS.md

Universal entry point for any AI coding agent (Claude, Codex, Cursor, Copilot, Gemini, Aider, Windsurf…).
Keep this file under ~120 lines. It is loaded on every task — every line costs tokens forever.

## 1. Orientation protocol (do this, in order, and stop as soon as you know enough)

1. Read `.agents/STATE.md` — what the project is, current focus, next steps (≤40 lines).
2. Read `.agents/MAP.md` — one line per area/module, with the path of its local `AGENTS.md`.
3. Open ONLY the local `AGENTS.md` of the module(s) your task touches. Never read all of them.
4. Search (grep/glob) for the exact symbols you need; read files in ranges, not whole.
5. Load a playbook from `.agents/playbooks/` only when the task matches its trigger (see §4).

If `.agents/STATE.md` still says `status: uninitialized` → run `.agents/playbooks/bootstrap.md` first.

## 2. Context hygiene (token budget rules)

- Read the minimum. Prefer `grep -n`, symbol search, `head`, line ranges over full-file reads.
- Never read: lockfiles, build output, `node_modules/`, `vendor/`, generated code, binaries,
  large data/media, `.git/`. The canonical list is in `.agents/ignore.md`.
- Don't re-read files you just wrote/edited; don't paste large outputs back to the user.
- Pipe noisy commands through `tail`/`head`/`grep`; run single tests, not the whole suite, while iterating.
- For broad exploration, use a sub-agent/search tool if your harness has one and keep only conclusions.
- Facts live in exactly one place. Link (`see path/file.md`) instead of copying.

## 3. Working rules

- Match surrounding code: style, naming, comment density, idioms. No speculative abstractions.
- Small, verifiable steps. Run the project's check command (see `.agents/STATE.md` → Commands) before saying "done".
- Ask the user only for decisions that are genuinely theirs; otherwise pick the conventional default and state it.
- Never commit secrets. Never run destructive commands (force-push, `rm -rf`, DB drops) without explicit approval.
- Reply to the user in the user's language. Write agent-facing docs in English (cheaper in tokens, unambiguous).

## 4. Playbooks (load on demand)

| Trigger | File |
|---|---|
| New/empty project, `status: uninitialized` | `.agents/playbooks/bootstrap.md` |
| Adding a module, package, feature area, or vault section | `.agents/playbooks/new-module.md` |
| End of any task that changed structure, commands, or decisions | `.agents/playbooks/finish-task.md` |
| Docs feel stale/bloated, a file exceeds its budget, or every ~20 tasks | `.agents/playbooks/maintenance.md` |
| Writing/editing any agent doc (AGENTS.md, playbook, rule) | `.agents/rules/writing-agent-docs.md` |

Project-specific rules live in `.agents/rules/` and are listed in `.agents/MAP.md`. Create new ones there, not here.

## 5. Self-evolution contract (so the next chat with zero context can continue)

After finishing a task, run `.agents/playbooks/finish-task.md`. In short:
- Changed structure → update `.agents/MAP.md` and the module's `AGENTS.md`.
- Made a non-obvious decision → append one line to `.agents/DECISIONS.md`.
- Progress / next steps changed → rewrite `.agents/STATE.md` (replace, don't append).
- Learned a recurring gotcha → add it to the closest local `AGENTS.md` (not to this root file).

Hierarchy = locality: put knowledge in the deepest file whose scope covers it.
Root `AGENTS.md` holds only rules valid for the entire project.

## 6. Budgets (enforced by `scripts/agent-lint.sh`)

| File | Max lines |
|---|---|
| `AGENTS.md` (root) | 120 |
| `.agents/STATE.md` | 40 |
| `.agents/MAP.md` | 100 (split into sub-maps if larger) |
| module `AGENTS.md` | 60 |
| playbook / rule | 80 |
| `.agents/DECISIONS.md` | 150 (archive older entries to `.agents/archive/`) |

<!-- PROJECT-SPECIFIC RULES BELOW (keep short; move details into .agents/rules/) -->
