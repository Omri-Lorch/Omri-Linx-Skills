#!/usr/bin/env bash
# sync-context.sh
# Copies the master shared/linx-role-context.md into each skill folder.
# Run this whenever shared/linx-role-context.md changes, before committing.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MASTER="$REPO_ROOT/shared/linx-role-context.md"

if [[ ! -f "$MASTER" ]]; then
  echo "ERROR: Master role context not found at $MASTER"
  exit 1
fi

echo "Syncing $MASTER → all skill folders"

for skill_dir in "$REPO_ROOT/skills"/*/; do
  if [[ -d "$skill_dir" ]]; then
    cp "$MASTER" "$skill_dir/linx-role-context.md"
    echo "  ✓ $(basename "$skill_dir")"
  fi
done

echo ""
echo "Done. Don't forget to:"
echo "  1. git add skills/*/linx-role-context.md"
echo "  2. git commit -m 'Sync role context'"
echo "  3. If using Claude.ai uploads, re-package skills via scripts/package-skills.sh"
