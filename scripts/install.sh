#!/usr/bin/env bash
# install.sh
# One-time setup for Omri-Linx-Skills.
# Run once after cloning the repo. Idempotent — safe to re-run.
#
# What it does:
#   1. Verifies the repo structure
#   2. Syncs role context to all skill folders
#   3. Symlinks skills/ to ~/.claude/skills/ (so Claude Code finds them)
#   4. Packages ZIPs for Claude.ai upload (in dist/)
#   5. Prints next-step instructions
#
# Usage:
#   ./scripts/install.sh
#   OR ask ol-linx-agent: "install my Linx skills"

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CLAUDE_SKILLS_DIR="$HOME/.claude/skills"

echo "================================================================"
echo "  Omri-Linx-Skills — Install"
echo "================================================================"
echo ""

# 1. Verify repo structure
echo "[1/4] Verifying repo structure..."
if [[ ! -d "$REPO_ROOT/skills" ]]; then
  echo "  ✗ ERROR: skills/ directory not found"
  exit 1
fi
if [[ ! -f "$REPO_ROOT/shared/linx-role-context.md" ]]; then
  echo "  ✗ ERROR: shared/linx-role-context.md not found"
  exit 1
fi

skill_count=$(find "$REPO_ROOT/skills" -name "SKILL.md" | wc -l | tr -d ' ')
echo "  ✓ Found $skill_count skills in skills/"

# 2. Sync role context
echo ""
echo "[2/4] Syncing role context to skill folders..."
"$REPO_ROOT/scripts/sync-context.sh" > /dev/null
echo "  ✓ Synced shared/linx-role-context.md → all skill folders"

# 3. Symlink for Claude Code
echo ""
echo "[3/4] Setting up Claude Code access..."
mkdir -p "$HOME/.claude"

if [[ -L "$CLAUDE_SKILLS_DIR" ]]; then
  current_target=$(readlink "$CLAUDE_SKILLS_DIR")
  if [[ "$current_target" == "$REPO_ROOT/skills" ]]; then
    echo "  ✓ Symlink already correct: $CLAUDE_SKILLS_DIR → $REPO_ROOT/skills"
  else
    echo "  ! Existing symlink points elsewhere: $current_target"
    echo "    Removing and replacing..."
    rm "$CLAUDE_SKILLS_DIR"
    ln -s "$REPO_ROOT/skills" "$CLAUDE_SKILLS_DIR"
    echo "  ✓ Symlinked $CLAUDE_SKILLS_DIR → $REPO_ROOT/skills"
  fi
elif [[ -d "$CLAUDE_SKILLS_DIR" ]]; then
  echo "  ! ~/.claude/skills/ exists as a directory (not a symlink)."
  echo "    Move/backup that directory first, then re-run this script."
  echo "    Suggested: mv $CLAUDE_SKILLS_DIR ${CLAUDE_SKILLS_DIR}.backup-$(date +%s)"
  exit 1
else
  ln -s "$REPO_ROOT/skills" "$CLAUDE_SKILLS_DIR"
  echo "  ✓ Symlinked $CLAUDE_SKILLS_DIR → $REPO_ROOT/skills"
fi

# 4. Package ZIPs for Claude.ai
echo ""
echo "[4/4] Packaging ZIPs for Claude.ai upload..."
"$REPO_ROOT/scripts/package-skills.sh" > /dev/null
zip_count=$(find "$REPO_ROOT/dist" -name "*.zip" | wc -l | tr -d ' ')
echo "  ✓ Created $zip_count ZIPs in dist/"

# Done — next steps
echo ""
echo "================================================================"
echo "  Install complete."
echo "================================================================"
echo ""
echo "Claude Code: skills are live now. Test with any new session."
echo ""
echo "Claude.ai (manual one-time step — Anthropic has no upload API yet):"
echo "  1. Open https://claude.ai/settings/skills"
echo "  2. Click '+' > '+ Create skill' for each ZIP in dist/:"
for zip in "$REPO_ROOT/dist"/*.zip; do
  echo "       $zip"
done
echo "  3. Toggle each on after upload."
echo ""
echo "Claude Desktop: inherits from Claude.ai upload — no extra step."
echo ""
echo "Future updates: edit shared/linx-role-context.md or any SKILL.md,"
echo "then run scripts/update.sh (or ask ol-linx-agent: 'update my skills')."
echo ""
