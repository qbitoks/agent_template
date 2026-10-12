# DECISIONS

Append-only. One line per decision, newest at the bottom:
`YYYY-MM-DD | scope | decision | why (≤1 line) | link to details (optional)`
Long rationale → `.agents/decisions/NNNN-title.md` (template: `.agents/templates/adr.md`).
Over 150 lines → move oldest entries to `.agents/archive/decisions-YYYY.md`.

2026-10-12 | repo | AGENTS.md is the single source of truth; tool-specific files (CLAUDE.md, GEMINI.md, …) only point to it | one set of rules for every agent, no drift
2026-10-12 | docs | Agent docs in English, chat in user's language | Cyrillic costs ~2–3× tokens; English is unambiguous for all models
2026-10-12 | docs | Hierarchical docs: root rules + MAP index + per-module AGENTS.md loaded on demand | context stays constant as the project grows
