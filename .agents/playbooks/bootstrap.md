# Playbook: bootstrap

Trigger: `.agents/STATE.md` has `status: uninitialized`, or the user starts a new project from this template.

1. **Understand the project.** If the repo already has code, inspect only manifests and top-level
   layout (`ls`, `package.json`, `build.gradle*`, `pom.xml`, `pyproject.toml`, `Podfile`, `go.mod`,
   `Cargo.toml`, `.obsidian/`…). Otherwise ask the user in ONE message (skip what's already known):
   - what is being built and for whom (one sentence);
   - type/stack (or let the agent propose one);
   - hard constraints (platforms, versions, hosting, language of notes).
2. **Choose the layout** conventional for that stack (don't invent one). Examples:
   - Android/iOS/Spring/Node: standard tool scaffold; one `AGENTS.md` per top-level module/package.
   - Monorepo: `apps/*`, `packages/*`, each with its own `AGENTS.md`.
   - Obsidian/knowledge base: folders by domain (`00-inbox/`, `10-areas/`, `20-projects/`, `90-archive/`),
     `AGENTS.md` per top folder describing note conventions (frontmatter, links, tags, naming).
3. **Scaffold** with the official generator when one exists (e.g. `gradle init`, `npm create`, Spring
   Initializr) instead of hand-writing boilerplate.
4. **Fill agent docs:**
   - `.agents/STATE.md`: Project, exact Commands, Current focus, Next steps; set `status: active`.
   - `.agents/MAP.md`: one line per area → its `AGENTS.md`.
   - Module `AGENTS.md` files from `.agents/templates/module-AGENTS.md` (only for real areas).
   - `.agents/ignore.md`: add stack-specific paths; mirror into tool ignore files.
   - Stack-wide conventions (> 5 lines) → `.agents/rules/<topic>.md`, indexed in MAP.
   - Root `AGENTS.md`: under "PROJECT-SPECIFIC RULES" add ≤ 10 lines that apply everywhere.
5. **Record** the stack/layout choice in `.agents/DECISIONS.md`.
6. **Remove** template leftovers that don't apply (e.g. Obsidian lines in a Spring project).
7. Run `sh scripts/agent-lint.sh`; fix failures. Commit: `chore: bootstrap <project>`.
