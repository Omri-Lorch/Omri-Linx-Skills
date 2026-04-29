#!/usr/bin/env bash
# package-skills.sh
# Creates ZIP files for each skill, ready to upload to Claude.ai via Settings > Customize > Skills.
# Critical: each ZIP contains the skill folder at root, NOT just the contents (Claude.ai requires folder-at-root).

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_DIR="$REPO_ROOT/skills"
OUT_DIR="$REPO_ROOT/dist"

mkdir -p "$OUT_DIR"
rm -f "$OUT_DIR"/*.zip

echo "Packaging skills for Claude.ai upload..."
echo ""

cd "$SKILLS_DIR"
for skill_dir in */; do
  skill_name="${skill_dir%/}"
  zip_path="$OUT_DIR/${skill_name}.zip"
  
  # Folder must be at root of ZIP (Claude.ai requirement)
  zip -r -q "$zip_path" "$skill_name"
  echo "  ✓ dist/${skill_name}.zip"
done

echo ""
echo "Done. ZIPs are in: $OUT_DIR"
echo ""
echo "To upload to Claude.ai:"
echo "  1. Open Claude.ai (Pro/Max/Team/Enterprise plan)"
echo "  2. Settings > Customize > Skills"
echo "  3. Click '+' > '+ Create skill' > Upload ZIP"
echo "  4. Repeat for each ZIP"
echo ""
echo "Note: If a skill already exists, delete it first or upload as new (Claude.ai doesn't overwrite)."
