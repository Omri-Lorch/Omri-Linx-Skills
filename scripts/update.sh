#!/usr/bin/env bash
# update.sh
# Run after editing shared/linx-role-context.md or any SKILL.md.
# Syncs context, commits if there are git changes, repackages ZIPs, and
# tells you whether Claude.ai re-upload is needed.
#
# Usage:
#   ./scripts/update.sh ["commit message"]
#   OR ask ol-linx-agent: "update my skills [with this message]"

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
COMMIT_MSG="${1:-Update Linx skills}"

cd "$REPO_ROOT"

echo "================================================================"
echo "  Omri-Linx-Skills — Update"
echo "================================================================"
echo ""

# Detect what changed BEFORE syncing (so we know whether re-upload is needed)
echo "[1/5] Detecting changes..."
master_changed=false
skill_md_changed=false

if git status --porcelain shared/linx-role-context.md 2>/dev/null | grep -q .; then
  master_changed=true
  echo "  ! shared/linx-role-context.md changed"
fi

if git status --porcelain skills/ 2>/dev/null | grep -E "SKILL\.md" >/dev/null 2>&1; then
  skill_md_changed=true
  echo "  ! one or more SKILL.md files changed"
fi

if [[ "$master_changed" == false && "$skill_md_changed" == false ]]; then
  echo "  ✓ No skill content changes detected. Nothing to update."
  exit 0
fi

# Sync context
echo ""
echo "[2/5] Syncing role context..."
"$REPO_ROOT/scripts/sync-context.sh" > /dev/null
echo "  ✓ Synced"

# Commit
echo ""
echo "[3/5] Committing changes..."
if git diff --quiet && git diff --cached --quiet; then
  echo "  ✓ Nothing to commit (already clean)"
else
  git add shared/ skills/
  git commit -m "$COMMIT_MSG" --quiet
  echo "  ✓ Committed: \"$COMMIT_MSG\""
fi

# Push
echo ""
echo "[4/5] Pushing to origin..."
if git remote get-url origin >/dev/null 2>&1; then
  git push origin --quiet 2>&1 | head -20 || echo "  ! Push failed — you may need to push manually"
  echo "  ✓ Pushed"
else
  echo "  ! No 'origin' remote configured. Skipping push."
fi

# Repackage ZIPs
echo ""
echo "[5/5] Repackaging ZIPs..."
"$REPO_ROOT/scripts/package-skills.sh" > /dev/null
echo "  ✓ Repackaged"

# Final report
echo ""
echo "================================================================"
echo "  Update complete."
echo "================================================================"
echo ""
echo "Claude Code: changes are live now (filesystem auto-picks up)."
echo ""

if [[ "$master_changed" == true || "$skill_md_changed" == true ]]; then
  echo "Claude.ai: re-upload is needed because:"
  if [[ "$master_changed" == true ]]; then
    echo "  - role context changed (affects all skills)"
  fi
  if [[ "$skill_md_changed" == true ]]; then
    echo "  - one or more SKILL.md changed"
  fi
  echo ""
  echo "  Re-upload steps:"
  echo "  1. Open https://claude.ai/settings/skills"
  echo "  2. Delete the existing version of each affected skill"
  echo "  3. Upload from dist/:"
  for zip in "$REPO_ROOT/dist"/*.zip; do
    echo "       $zip"
  done
  echo ""
  echo "  (Skills don't auto-overwrite on re-upload, so delete-then-upload.)"
fi

echo ""
