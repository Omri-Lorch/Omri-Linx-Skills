# ol-linx-agent integration: Omri-Linx-Skills control

> Add this section to `ol-linx-agent`'s `CLAUDE.md` so the agent knows how to
> manage the Linx Skills repo on Omri's behalf. Update the path below after
> cloning the repo locally.

## Context

The repo `Omri-Linx-Skills` (cloned at `<PATH>`, typically `~/code/Omri-Linx-Skills`)
contains Omri's role-level Claude Skills. When Omri asks ol-linx-agent to manage
his skills, route through this section.

## Triggers and behavior

### "Install my skills" / "set up my skills"

Run `scripts/install.sh` from the repo. Report:
- Where the symlink was created (`~/.claude/skills`)
- Number of ZIPs in `dist/` ready for Claude.ai upload
- Direct link to https://claude.ai/settings/skills with instructions to drag each ZIP in

Don't try to upload to Claude.ai automatically — there is no public API for it.

### "Update my skills" / "I edited [file], sync everything"

Run `scripts/update.sh "<commit message>"`. The script:
- Detects what changed (master role context vs. specific SKILL.md)
- Syncs role context to all skill folders
- Commits and pushes to origin
- Repackages ZIPs in `dist/`
- Reports whether Claude.ai re-upload is needed and which ZIPs

If re-upload is needed, surface the dist/ paths and the claude.ai/settings/skills link.

### "Add a new initiative context for [name]"

Create `initiatives/<name>/initiative-context.md` using the template at
`initiatives/README.md`. Don't sync into skill folders — initiative context is
loaded on demand by skills, not embedded.

### "Edit role context: [change]"

Edit `shared/linx-role-context.md` directly with the change. Then run `update.sh`
automatically (don't wait for separate sync command).

### "Why isn't [skill] triggering?"

Most likely: the description in SKILL.md frontmatter doesn't match the phrasing
Omri used. Open `skills/<skill-name>/SKILL.md`, look at the description (200-char
limit), suggest a sharpened version that better front-loads the trigger keywords.

## What ol-linx-agent should NOT do

- Do not modify `linx-role-context.md` copies inside skill folders directly.
  Always edit `shared/linx-role-context.md` and let `sync-context.sh` propagate.
- Do not attempt to upload to Claude.ai (no API path).
- Do not commit the `dist/` folder (should be in .gitignore).
- Do not change the symlink at `~/.claude/skills` without warning Omri first.

## Useful commands cheatsheet

```bash
cd <PATH>/Omri-Linx-Skills

# One-time setup
./scripts/install.sh

# After editing role context or a SKILL.md
./scripts/update.sh "Describe the change"

# Just resync without committing (for testing)
./scripts/sync-context.sh

# Just repackage ZIPs (for testing)
./scripts/package-skills.sh

# List current skills
ls skills/
```
