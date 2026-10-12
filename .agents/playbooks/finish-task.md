# Playbook: finish task

Run at the end of every task. Most tasks need zero doc edits — then just stop. Takes < 1 minute.

Checklist (edit only what actually changed):
- [ ] Project check command from `.agents/STATE.md` passes (or the failure is reported to the user).
- [ ] New/moved/removed area → `.agents/MAP.md` + that area's `AGENTS.md`.
- [ ] New/changed command (build, test, run, deploy) → `.agents/STATE.md` → Commands.
- [ ] Non-obvious decision or rejected alternative → one line in `.agents/DECISIONS.md`.
- [ ] Gotcha that cost time and will recur → closest local `AGENTS.md` ("Gotchas" section).
- [ ] Work left unfinished / next steps changed → rewrite "Current focus" / "Next steps" in STATE.
- [ ] `sh scripts/agent-lint.sh` passes.

Do NOT write: session diaries, change logs (git has them), things obvious from the code,
temporary debugging notes, or anything already documented elsewhere.

Commit message: conventional (`feat:`, `fix:`, `docs(agents):` …), one summary line + why.
