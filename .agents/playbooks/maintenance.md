# Playbook: maintenance (doc garbage collection)

Trigger: `agent-lint` reports over-budget files, docs contradict the code, or every ~20 tasks.

1. Run `sh scripts/agent-lint.sh`; start with its failures.
2. **Verify against reality.** For every path/command in MAP, STATE, module AGENTS.md: does it still
   exist and work? Delete or fix stale lines. Code is the truth, docs follow it.
3. **Deduplicate.** Same fact in two places → keep it in the deepest relevant file, link from others.
4. **Compress.** Rewrite prose into bullets; drop what a competent engineer infers from the code.
5. **Split, don't grow.**
   - MAP > 100 lines → per-area `MAP.md` sub-maps linked from the root MAP.
   - Module AGENTS.md > 60 lines → move details to `<area>/docs/agents/*.md`, link from it.
   - DECISIONS > 150 lines → move oldest to `.agents/archive/decisions-YYYY.md`.
6. **Promote / demote.** A rule repeated in 3+ modules → `.agents/rules/`. A root rule relevant to
   one area only → move it into that area.
7. Sync ignore files with `.agents/ignore.md` (`.cursorignore`, `.aiderignore`, `.geminiignore`).
8. Commit: `docs(agents): maintenance`.
