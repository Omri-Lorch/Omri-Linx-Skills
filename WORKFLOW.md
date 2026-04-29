# Workflow — Using Linx Skills Across Claude Surfaces

Custom Claude Skills do **not** sync across surfaces. This file documents how to use these skills in Claude Code, Claude.ai, the API, and other interfaces — and how to keep them in sync.

## TL;DR

| Surface | Setup | Auto-trigger? | Sync method |
|---|---|---|---|
| **Claude Code** | Symlink `skills/` to `~/.claude/skills/` | Yes | Filesystem auto |
| **Claude.ai** (Pro/Max/Team/Enterprise) | Upload each skill ZIP via Settings > Customize > Skills | Yes | Manual re-upload |
| **Claude API** | Upload via API | Yes | Programmatic |
| **Cursor / other Claude Code-based tools** | Inherits Claude Code setup | Yes | Filesystem auto |
| **Cowork** | Inherits Claude.ai uploaded skills | Yes | Manual re-upload |

## Setup — first time

### 1. Clone the repo

```bash
git clone git@github.com:Omri-Lorch/Omri-Linx-Skills.git
cd Omri-Linx-Skills
chmod +x scripts/*.sh
```

### 2. Sync the role context to skill folders

The master `shared/linx-role-context.md` is the source of truth. Each skill folder contains a synced copy (because Claude.ai upload requires each skill to be self-contained).

```bash
./scripts/sync-context.sh
```

This copies `shared/linx-role-context.md` into each `skills/*/linx-role-context.md`. Run this **every time** you edit the master.

### 3a. Setup for Claude Code

Claude Code reads skills from `~/.claude/skills/` (user-level) or `.claude/skills/` (project-level).

**Recommended**: symlink so updates flow automatically.

```bash
# User-level (available in every Claude Code session)
mkdir -p ~/.claude
ln -sf "$(pwd)/skills" ~/.claude/skills
```

Verify:

```bash
ls -la ~/.claude/skills/
# Should show: prd-partner-linx, positioning-linx, discovery-interview-linx
```

In any Claude Code session, the skills auto-trigger when their description matches what you're asking. You can also explicitly invoke: `use prd-partner-linx`.

### 3b. Setup for Claude.ai (Pro/Max/Team/Enterprise plans)

Claude.ai needs a ZIP per skill, uploaded via UI. ZIPs must contain the **folder at root**, not just contents (common upload failure if you zip the contents directly).

```bash
./scripts/package-skills.sh
```

This creates `dist/prd-partner-linx.zip`, `dist/positioning-linx.zip`, `dist/discovery-interview-linx.zip`.

Then in Claude.ai:

1. Settings > Customize > Skills
2. Click `+` > `+ Create skill`
3. Upload `dist/prd-partner-linx.zip`
4. Repeat for the other two

Skills auto-trigger when description matches. Toggle off any you don't want active.

### 3c. Setup for Claude API

Skills can be uploaded via API (`POST /v1/skills`). Beyond scope of this README — see [Anthropic docs](https://docs.claude.com/en/api/agent-skills).

## Daily use

In any Claude surface where the skills are loaded:

- They auto-trigger when you ask something matching the description
- You can explicitly invoke: "use `prd-partner-linx`"
- The skill loads its embedded `linx-role-context.md` first, then applies its instructions
- For initiative-specific work (e.g., MCP Gateway PRD), tell the skill which initiative — it'll ask if there's a context file to load

## Updating skills

### When you edit `shared/linx-role-context.md`

1. Edit `shared/linx-role-context.md`
2. Run `./scripts/sync-context.sh`
3. Commit (master + synced copies)
4. **Claude Code**: nothing else needed (filesystem picks up the change next session)
5. **Claude.ai**: run `./scripts/package-skills.sh`, then re-upload the ZIPs (delete old versions or re-upload as new — Claude.ai doesn't overwrite)

### When you edit a SKILL.md

Same as above but skip step 2 (sync). Just commit and (for Claude.ai) re-package and re-upload.

### When Linx role context changes meaningfully

Examples: new locked decision pattern, stakeholder change, category pivot, new vocabulary term.

1. Decide if it's truly *durable* (belongs in `shared/linx-role-context.md`) or *initiative-specific* (belongs in `initiatives/<initiative>/initiative-context.md`)
2. Edit the right file
3. For role context: sync, commit, re-package, re-upload (Claude.ai)
4. For initiative context: just edit and commit; skills load it on demand

## Per-initiative context files

For specific initiatives (MCP Gateway, future projects), create:

```
initiatives/<initiative-name>/
└── initiative-context.md
```

Format (suggested):

```markdown
# [Initiative] Context

## Locked decisions
| # | What | Date | Decider |

## Pending decisions
| Question | Owner | By |

## Competitor frame (if different from role-level)

## Customer signal (latest)

## Initiative-specific vocabulary

## Demo / artifact links
```

When working on that initiative, tell the skill: "this is for [initiative], load `initiatives/<initiative>/initiative-context.md`."

These files don't need to be packaged into skill ZIPs — they live in the repo and are loaded on demand by the skill (which can read repo files via filesystem in Claude Code, or via GitHub MCP in Claude.ai).

## Sharing with the Linx team

When skills prove their value:

### Option 1: Team/Enterprise plan sharing

If on a Team or Enterprise plan, share uploaded skills via Claude.ai Settings > Customize > Skills > Share. Each colleague gets the skill in their own list.

### Option 2: Repo-based sharing

Make the repo accessible to the team (private with team access, or public). Each person:

1. Clones the repo
2. Symlinks for Claude Code (step 3a above)
3. Packages and uploads for Claude.ai (step 3b above)

This avoids per-skill admin overhead but each person manages their own copy.

### Option 3: Org-wide provisioning (Enterprise plan)

Owners can provision skills org-wide. Useful when role context stabilizes.

## Common gotchas

- **ZIP structure**: must contain the folder at root, not just contents. The `package-skills.sh` script handles this correctly. If you zip manually, use `zip -r foo.zip foo-folder/` not `cd foo-folder && zip -r ../foo.zip *`.
- **Description triggering**: Claude triggers skills based on the `description` field in SKILL.md frontmatter. Max 200 chars. If a skill isn't triggering, the description is probably the issue.
- **Updates don't propagate**: Claude.ai uploaded skills don't update when you edit the source. Re-upload required.
- **Skills don't reference each other formally**: Anthropic's skills system doesn't support cross-skill imports. That's why we duplicate `linx-role-context.md` into each skill folder.

## Useful links

- [Anthropic Skills overview](https://docs.claude.com/en/agents-and-tools/agent-skills/overview)
- [Use Skills in Claude](https://support.claude.com/en/articles/12512180-use-skills-in-claude)
- [How to create custom Skills](https://support.claude.com/en/articles/12512198-how-to-create-custom-skills)
- [Claude Code skills](https://code.claude.com/docs/en/skills)
- [Anthropic public skills repo](https://github.com/anthropics/skills) — reference patterns
