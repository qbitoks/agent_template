# Agent Template

Шаблон для старта любого проекта (Android/iOS/Spring/Node/Python, монорепо, база знаний Obsidian…),
в котором работают AI-агенты: Claude Code, Codex, Cursor, Copilot, Gemini CLI, Windsurf, Aider.

Цель: агент в новом чате **без контекста** быстро ориентируется, читает только нужное
и сам поддерживает документацию проекта в актуальном и компактном виде.

## Как начать новый проект

1. **Use this template** на GitHub (или `git clone` → удалить `.git` → `git init`).
2. Включить проверку перед коммитом: `git config core.hooksPath .githooks`.
3. Открыть проект в любом агенте и написать: «Инициализируй проект: <что строим>».
   Агент увидит `status: uninitialized` в `.agents/STATE.md` и выполнит `.agents/playbooks/bootstrap.md`.

**Существующий репозиторий:** скопируйте файлы шаблона и попросите «Внедри agent template».
Bootstrap перенесёт правила из старых `.cursorrules`, `CLAUDE.md`, `copilot-instructions.md` в `AGENTS.md`.

**Обновить шаблон в проекте:** «Обнови agent template из upstream» → `.agents/playbooks/upgrade.md`.
Файлы шаблона (плейбуки, скрипты, адаптеры, верх `AGENTS.md`) обновляются, файлы проекта не трогаются.

## Как это устроено

```
AGENTS.md                 ← единая точка входа (стандарт agents.md): правила + раздел Project с командами
CLAUDE.md, GEMINI.md      ← адаптеры: импорт @AGENTS.md (≤ 5 строк, проверяется линтером)
.github/copilot-instructions.md, .aider.conf.yml   ← адаптеры Copilot и Aider
.agents/
  STATE.md                ← только изменчивое: фокус, следующие шаги, блокеры (перезаписывается)
  MAP.md                  ← карта: одна строка на область → её AGENTS.md
  DECISIONS.md            ← журнал решений (одна строка; merge=union — без конфликтов в параллельных ветках)
  ignore.md               ← единый список «не читать»; из него генерируются ignore-файлы инструментов
  playbooks/              ← bootstrap, new-module, maintenance, upgrade
  rules/                  ← тематические правила, грузятся по триггеру (индекс в MAP)
  templates/              ← шаблоны модульного AGENTS.md, правила, ADR
<module>/AGENTS.md        ← правила области; читаются только при работе в ней
<module>/CLAUDE.md        ← заглушка @AGENTS.md для Claude Code (создаёт `agent-lint --fix`)
scripts/agent-lint.sh     ← проверки + генерация (--fix)
.githooks/pre-commit, .github/workflows/agent-lint.yml   ← линтер перед коммитом и в CI
```

## Кто что читает

| Инструмент | Правила | AGENTS.md модулей | «Не читать» |
|---|---|---|---|
| Codex | `AGENTS.md` нативно | от корня до рабочей папки, остальное через MAP | `.ignore` (ripgrep) |
| Claude Code | `CLAUDE.md` → `@AGENTS.md` | заглушка `CLAUDE.md` рядом, грузится при работе в папке | `.ignore` |
| Cursor | `AGENTS.md` нативно | нативно | `.cursorignore` (секреты), `.cursorindexingignore` |
| Copilot | `AGENTS.md` + `copilot-instructions.md` | зависит от версии/настройки VS Code | `.ignore` (поиск VS Code) |
| Gemini CLI | `GEMINI.md` → `@./AGENTS.md` | через MAP | `.geminiignore` |
| Windsurf | `AGENTS.md` нативно | нативно | `.codeiumignore` |
| Aider | `.aider.conf.yml` → `read:` (+ STATE, MAP) | — | `.aiderignore` |

`.ignore` понимают ripgrep и поиск VS Code: lock-файлы и сгенерированное пропускаются при поиске,
но по явному пути файл открывается. Это касается и вашего поиска в VS Code.

## Принципы

| Принцип | Зачем |
|---|---|
| **Progressive disclosure**: корень → MAP → модуль → код | Постоянный контекст не растёт с проектом |
| **Одна точка правды** (AGENTS.md); адаптеры импортируют, а не просят «прочитать» | Нет рассинхрона, нет лишнего чтения |
| **Иерархия = локальность**: знание в самом глубоком подходящем файле | Агент не читает чужие правила |
| **Стабильное в AGENTS.md, изменчивое в STATE** | Команды не теряются при перезаписи; кэш промпта не сбивается |
| **Разобрался — записал**: неизученная область получает AGENTS.md после первого исследования | Следующий агент не платит повторно |
| **Генерация вместо ручной синхронизации** (ignore-файлы, заглушки) | Зеркала не расходятся |
| **Линтер с памятью git**: лимиты, битые пути, индекс MAP, «maintenance due» | Самообслуживание без памяти между чатами |
| **Агентские документы на английском** | Кириллица в 1,5–3 раза дороже в токенах (зависит от токенизатора) |

## Проверка

```bash
sh scripts/agent-lint.sh          # проверить
sh scripts/agent-lint.sh --fix    # перегенерировать ignore-файлы и заглушки CLAUDE.md, затем проверить
```

- **Windows / PowerShell:** `sh` обычно нет в PATH → `& "$env:ProgramFiles\Git\bin\sh.exe" scripts/agent-lint.sh`
  или Git Bash. Хук pre-commit работает и так: git запускает хуки своим `sh`.
- **GitLab:** добавьте в `.gitlab-ci.yml` job с `sh scripts/agent-lint.sh`, а `.github/` удалите.
