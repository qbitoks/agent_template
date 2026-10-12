# Never read (unless the task is explicitly about them)

Canonical list for all agents. Mirrored for tools that support ignore files
(`.cursorignore`, `.aiderignore`, `.geminiignore`, `.codeiumignore`) — keep them in sync via `.agents/playbooks/maintenance.md`.

- VCS & deps: `.git/`, `node_modules/`, `vendor/`, `.venv/`, `venv/`, `Pods/`, `.gradle/`, `.m2/`
- Build output: `build/`, `dist/`, `out/`, `target/`, `.next/`, `bin/`, `obj/`, `DerivedData/`, `coverage/`
- Lockfiles: `package-lock.json`, `yarn.lock`, `pnpm-lock.yaml`, `poetry.lock`, `Cargo.lock`, `Podfile.lock`, `*.lock`
- Generated: `*.min.js`, `*.map`, `*.pb.go`, `*_generated.*`, `R.java`, `*.g.dart`
- Binary/media: images, video, audio, archives, `*.jar`, `*.apk`, `*.aab`, `*.ipa`, `*.so`, `*.dll`, PDFs
- Data/logs: `*.log`, `*.sqlite`, `*.db`, large `*.csv`/`*.json` fixtures
- Secrets: `.env*` (except `.env.example`), `*.pem`, `*.key`, `*.keystore`, `secrets.*`
- Obsidian: `.obsidian/` (config), `.trash/`, attachments folder
- Archives: `.agents/archive/` (history; read only when researching past decisions)

Project-specific additions:
- (none)
