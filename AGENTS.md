# AGENTS.md

Rules for every AI agent in this repo. Deeper `AGENTS.md` files add rules for their area.
Precedence: the user's explicit request > nearest `AGENTS.md` > this file > `.agents/rules/`.

## 1. Orientation (in order; stop as soon as you know enough)

1. Read `.agents/STATE.md` (status, focus, next steps) and `.agents/MAP.md` (areas → their docs).
2. Read the `AGENTS.md` of each area your task touches, unless your tool already loaded it.
   Never read all of them.
3. Before changing architecture, a library, a data format or the layout: grep `.agents/DECISIONS.md`
   for the area or keyword. Don't reverse a recorded decision without telling the user.
4. Search (grep/glob/symbols) for exact names. Read small files (< ~300 lines) whole, large ones by range.
5. Load a playbook (§4) only when the task matches its trigger.

`status: uninitialized` in STATE: if the task is to start or build the project, run
`.agents/playbooks/bootstrap.md` first. Work on the template itself (agent docs, scripts) needs no bootstrap.

## 2. Context hygiene

- Read the minimum. Every tool call re-sends the context: one whole read beats five tiny ones.
- Skip what `.agents/ignore.md` lists (deps, build output, lockfiles, generated code). Open such a file
  only by explicit path when the task is about it. Never read secrets.
- Don't re-read files you just wrote. Pipe noisy output through `tail`/`grep`; run single tests while iterating.
- Broad exploration → a sub-agent or search tool if your harness has one; keep only the conclusions.
- One fact, one place. Link (`see path/file.md`) instead of copying.

## 3. Working rules

- Match surrounding code: style, naming, comment density, idioms. No speculative abstractions.
- Small, verifiable steps. Run the Check command (Project section below) before saying "done".
- Docs disagree with the code → the code wins; fix the doc in the same task.
- Ask the user only for decisions that are theirs; otherwise pick the conventional default and say so.
- Never commit secrets. Destructive commands (force-push, `rm -rf`, DB drops) need explicit approval.
- Commit only when the user asks. Messages: conventional (`feat:`, `fix:`, `docs(agents):`), summary + why.
- Scratch files go to `.agents/tmp/` (gitignored). Don't create report or summary files; report in chat.
- Reply in the user's language. Write agent docs in English.

## 4. Playbooks (load on demand)

| Trigger | File |
|---|---|
| Start/build a project while `status: uninitialized`, or adopt the template in an existing repo | `.agents/playbooks/bootstrap.md` |
| Add a module, package, service, feature area or vault section | `.agents/playbooks/new-module.md` |
| Lint: over a limit (now) or "maintenance due" (offer after the task); docs feel stale | `.agents/playbooks/maintenance.md` |
| Pull agent-infrastructure updates from the upstream template | `.agents/playbooks/upgrade.md` |
| Write or edit any agent doc (AGENTS.md, STATE, MAP, DECISIONS, playbook, rule) | `.agents/rules/writing-agent-docs.md` |

Topic rules live in `.agents/rules/`, indexed in `.agents/MAP.md`. Create new ones there, not here.

## 5. Before saying "done" (every task; most need zero doc edits)

- The Check command passes, or you report the failure.
- Added, moved or removed an area → `.agents/MAP.md` + that area's `AGENTS.md` (new-module playbook).
- Had to explore an undocumented area to understand it → write its `AGENTS.md` (entry points,
  canonical example) so the next agent doesn't pay for it again.
- New or changed command → Project section below.
- Non-obvious decision or rejected alternative → one line in `.agents/DECISIONS.md`.
- Gotcha that cost time and will recur → "Gotchas" in the closest `AGENTS.md`.
- Focus, next steps or blockers changed → rewrite `.agents/STATE.md`.
- Don't write session diaries, changelogs (git has them) or what the code already says.

Put knowledge in the deepest file whose scope covers it. This file holds only repo-wide rules.

<!-- PROJECT-OWNED BELOW: filled by bootstrap; template upgrades never touch it (.agents/playbooks/upgrade.md). -->
## Project

- What: <TBD: one sentence. Until bootstrap, this repo is the agent template itself.>
- Stack and layout: <TBD>

Commands (exact; delete what doesn't apply):
- Check before "done": `sh scripts/agent-lint.sh` + <TBD: build, tests, linters>
  PowerShell without `sh` in PATH: `& "$env:ProgramFiles\Git\bin\sh.exe" scripts/agent-lint.sh`
- Setup: <TBD>
- Run: <TBD>
- Test one: <TBD>

## Project rules
<!-- ≤ 10 lines that apply everywhere; topic rules go to .agents/rules/ -->
- (none yet)
