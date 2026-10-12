#!/usr/bin/env sh
# Checks agent-doc budgets and that paths referenced in .agents/MAP.md exist.
# Usage: sh scripts/agent-lint.sh   (exit 1 on any failure)
cd "$(dirname "$0")/.." || exit 1
fail=0

check() { # file max
  [ -f "$1" ] || return 0
  n=$(wc -l < "$1" | tr -d ' ')
  if [ "$n" -gt "$2" ]; then echo "OVER BUDGET: $1 ($n > $2 lines)"; fail=1; fi
}

check AGENTS.md 120
check .agents/STATE.md 40
check .agents/MAP.md 100
check .agents/DECISIONS.md 150
for f in .agents/playbooks/*.md .agents/rules/*.md; do check "$f" 80; done
find . -name AGENTS.md -not -path ./AGENTS.md -not -path './.git/*' \
  -not -path '*/node_modules/*' -not -path './.agents/*' | while read -r f; do
  n=$(wc -l < "$f" | tr -d ' ')
  [ "$n" -gt 60 ] && echo "OVER BUDGET: $f ($n > 60 lines)" && echo x >> .agent-lint.tmp
done
[ -f .agent-lint.tmp ] && fail=1 && rm -f .agent-lint.tmp

# Every `path` in MAP.md that looks like a repo path must exist.
for p in $(sed '/<!--/,/-->/d' .agents/MAP.md | grep -o '`[^` ]*`' | tr -d '`' | grep -E '^[A-Za-z0-9._-]+(/[A-Za-z0-9._-]*)*$' | grep -E '/|\.md$|\.sh$'); do
  [ -e "$p" ] || { echo "MAP: missing path $p"; fail=1; }
done

# Every module AGENTS.md should be indexed (directly or via a parent) in MAP.
find . -name AGENTS.md -not -path ./AGENTS.md -not -path './.git/*' \
  -not -path '*/node_modules/*' -not -path './.agents/*' | sed 's|^\./||' | while read -r f; do
  d=$(dirname "$f")
  grep -q "$d" .agents/MAP.md || grep -rqs "$d" --include=AGENTS.md . || echo "WARN: $f not referenced in MAP"
done

[ "$fail" -eq 0 ] && echo "agent-lint: OK"
exit "$fail"
