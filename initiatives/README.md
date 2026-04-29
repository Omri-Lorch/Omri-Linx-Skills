# Initiatives

Per-initiative context files live here. These are loaded *alongside* the role skills when working on a specific Linx initiative.

## When to add an initiative context file

- The initiative has locked decisions worth tracking explicitly
- The initiative has its own competitor frame (different or sharper than role-level)
- The initiative has primary customer signal (transcripts, design partner notes)
- The initiative has a specific demo / artifact / deliverable

## Structure

Each initiative gets a folder:

```
initiatives/<initiative-name>/
├── initiative-context.md    ← required
├── customer-signal/         ← optional: transcripts, notes
├── competitor-research/     ← optional: per-vendor teardowns
└── artifacts/               ← optional: demo scripts, PRDs, decks
```

## Format for `initiative-context.md`

```markdown
# [Initiative] Context

> Owner: Omri Lorch
> Initiative: [name]
> Status: [phase]
> Created: [date]
> Last updated: [date]

## Initiative in one paragraph

[What's being built, who it's for, why it matters now]

## Locked decisions

| # | What | Date | Decider |

## Pending decisions

| Question | Owner | By | Stakes |

## Competitor frame (if different from role-level)

[Three-bucket framing or whatever the initiative-specific competitor model is]

## Customer signal (latest)

[Primary signal source — design partner transcript, prospect calls, etc.]

## Initiative-specific vocabulary

[Terms specific to this initiative — MCP, tool policy, etc.]

## Demo / artifact links

- [Demo script]
- [PRD]
- [Linear epic]
- [Notion canonical page]

## Stress Test

- Weakest piece: [...]
- What a smart competitor would say: [...]
- What could change this: [...]
```

## How skills use these files

When Omri invokes a Linx skill (e.g., `prd-partner-linx`), the skill asks: "Which initiative is this for? Is there an initiative context file to load?"

If yes, the skill loads:
1. The skill's embedded `linx-role-context.md` (durable Linx role context)
2. The relevant `initiatives/<initiative>/initiative-context.md` (volatile per-initiative context)

The skill then operates with both contexts in mind — durable principles enforced consistently, initiative-specifics treated as the live ground truth for that work.

## Examples (currently empty — to be populated)

- `mcp-gateway/` — MCP Gateway / Agentic AI Identity initiative (Identiverse June 15)
- *future initiatives go here*
