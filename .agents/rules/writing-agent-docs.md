# Rule: writing agent docs

Applies to AGENTS.md, MAP, STATE, playbooks, rules.

- English, imperative, bullets. No intros, no motivation paragraphs, no emojis.
- Every line must change agent behaviour. If deleting it changes nothing → delete it.
- Concrete over abstract: exact paths, exact commands, exact names. `Run ./gradlew :app:test`, not "run tests".
- Say what to do, and the one-line why for non-obvious rules (it lets agents judge edge cases).
- Don't document what the code/config already says (versions, dependency lists, file listings).
- One fact, one place. Link with a relative path instead of copying.
- Put knowledge at the deepest scope that covers it (module > rules/ > root).
- Use stable anchors: paths and symbol names, not line numbers.
- Respect budgets in root `AGENTS.md` §6. Over budget → split, don't squeeze.
- New rule file → add one line to `.agents/MAP.md` → "Rules index" with its trigger.
