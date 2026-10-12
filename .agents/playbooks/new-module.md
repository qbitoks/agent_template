# Playbook: new module / area

Trigger: adding a module, package, service, feature area, or a new top-level vault section.

1. Check `.agents/MAP.md` — does an existing area already own this? Prefer extending it.
2. Create the area in the stack's conventional place.
3. Create `<area>/AGENTS.md` from `.agents/templates/module-AGENTS.md`. Fill only what is true now;
   delete empty sections. ≤ 60 lines.
   Skip it for trivial areas (< ~5 files, no special rules) — the MAP line is enough.
4. Add one line to `.agents/MAP.md`: `` `path/` — purpose — `path/AGENTS.md` ``.
5. If the area introduces a cross-cutting convention, write `.agents/rules/<topic>.md` instead of
   repeating it in several modules.
6. Non-obvious choice (library, boundary, data format)? Append to `.agents/DECISIONS.md`.

Nested modules: the parent `AGENTS.md` lists its children in one line each; MAP lists only the parent.
This keeps MAP flat and small regardless of project size.
