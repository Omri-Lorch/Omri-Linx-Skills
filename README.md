# Omri's Linx Skills

Personal Claude Skills for Omri Lorch's role as PM at Linx Security. Wraps generic PM skills (from [Lorch19/operator-kit](https://github.com/Lorch19/operator-kit)) with durable Linx role context — product profile, stakeholder map, PRD pattern, vocabulary, pushback principles.

**Status**: private during iteration. Will be shared with Linx team once skills prove their value in real PRD / positioning / customer-call work.

## What's here

| Skill | What it does | Trigger phrases |
|---|---|---|
| `prd-partner-linx` | Iterative, adversarial Linx PRD writing — section by section, with stakeholder lenses and Linx pushback patterns | "let's start the PRD," "draft section X," "review this PRD" |
| `positioning-linx` | Linx-as-IGA positioning with Niv-pushback test and "only we" check | "draft positioning for X," "sharpen the position" |
| `discovery-interview-linx` | Customer call prep with IGA-aware listening framework and Linx-specific bias avoidance | "prep for [customer] call," "draft discovery questions" |

## Three-layer architecture

```
┌─────────────────────────────────────────────┐
│  Generic skills (operator-kit)              │  Never modified
│  Foundation patterns: PRD writing,          │
│  positioning, customer interview prep       │
└─────────────────────────────────────────────┘
                    ↑ wraps
┌─────────────────────────────────────────────┐
│  Linx role skills (this repo)               │  Updated when Linx role/co changes
│  Durable context: product, stakeholders,    │
│  PRD pattern, vocabulary, pushback          │
└─────────────────────────────────────────────┘
                    ↑ loaded alongside
┌─────────────────────────────────────────────┐
│  Initiative context files                   │  Updated as initiative evolves
│  Per-initiative: locked decisions, demo,    │
│  competitor frame, customer signal          │
└─────────────────────────────────────────────┘
```

When Omri starts a session, the relevant skill loads its embedded `linx-role-context.md`, then asks if there's an initiative-specific context file to load on top (e.g., for the MCP Gateway PRD, an `initiatives/mcp-gateway/initiative-context.md` would be loaded).

## Repo layout

```
.
├── README.md                          ← you are here
├── WORKFLOW.md                        ← how to use across Claude surfaces
├── shared/
│   └── linx-role-context.md           ← MASTER copy — edit here
├── skills/
│   ├── prd-partner-linx/
│   │   ├── SKILL.md
│   │   └── linx-role-context.md       ← synced from shared/
│   ├── positioning-linx/
│   │   ├── SKILL.md
│   │   └── linx-role-context.md
│   └── discovery-interview-linx/
│       ├── SKILL.md
│       └── linx-role-context.md
├── scripts/
│   ├── sync-context.sh                ← copy master → skill folders
│   └── package-skills.sh              ← zip skills for Claude.ai upload
└── initiatives/
    └── README.md                      ← per-initiative context files live here
```

## Quick start

**Use across Claude surfaces — see `WORKFLOW.md`** for full instructions. TL;DR:

- **Claude Code**: clone or symlink `skills/` to `~/.claude/skills/`
- **Claude.ai**: run `scripts/package-skills.sh`, upload each ZIP via Settings > Customize > Skills
- **Editing**: edit `shared/linx-role-context.md` only, then run `scripts/sync-context.sh`

## Sharing with the team

When skills prove themselves:
- On Team/Enterprise plan: share via Claude.ai Settings > Customize > Skills > Share
- Otherwise: invite teammates to clone the repo and follow `WORKFLOW.md`

## Foundation skills (operator-kit)

These overlays wrap the following generic skills:

- `prd-partner-linx` ← `operator-kit/prd-partner/SKILL.md`
- `positioning-linx` ← `operator-kit/pm-frameworks/positioning-statement/SKILL.md`
- `discovery-interview-linx` ← `operator-kit/pm-frameworks/discovery-interview-prep/SKILL.md`

Foundation skills define the framework patterns; this repo adds the Linx-specific overrides, pushback, and stakeholder lenses.

## License

Private. Will revisit when sharing with team or making public.
