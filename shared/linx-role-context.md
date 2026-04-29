# Linx Role Context

> **Purpose**: durable Linx-PM context loaded by every Linx skill. Stable across initiatives. Update when Linx the company, Omri's role, or stakeholder makeup changes — not when a specific initiative's decisions evolve.
>
> **Source of truth**: this file in `shared/linx-role-context.md`. Copies in each skill folder are synced via `scripts/sync-context.sh`. Edit master, sync, commit.
>
> **Owner**: Omri Lorch
> **Created**: 2026-04-29

---

## Linx in one paragraph

Linx is an Identity Governance & Administration (IGA) platform. The core product gives security teams a unified identity graph across humans, NHIs (service accounts, API keys, OAuth apps), and increasingly AI agents — discoverable, ownable, governed via access profiles, audited end to end. Linx's wedge against legacy IGA (SailPoint, Saviynt) is the graph-first model: relationships between identities, apps, and resources are queryable and policy-enforceable. The wedge against newer NHI-pure-plays (Astrix, Oasis) is integrated coverage of humans + NHIs + agents in one model rather than a separate NHI tool bolted onto traditional IAM.

## Market position

- **Category**: IGA (extending toward agentic identity governance)
- **Adjacent categories**: NHI Security, IAM/IDP (Okta, Ping), Access Management, ITDR
- **Lifecycle stage**: Series A scaling toward Series B narrative
- **Identiverse / Gartner IAM are primary industry venues**

## Customer profile (durable)

- **Buyer**: CISO / Head of IAM / Director of Identity at mid-market to enterprise (1k–50k employees)
- **Champion / daily user**: security admin or IAM owner reporting up to the buyer
- **Org profile**: SaaS-heavy (50+ apps), enterprise IDP in place (Okta, Entra, Ping), some on-prem stack remaining
- **Trigger events**: audit prep, NHI sprawl incident, agentic AI rollout, identity tool consolidation
- **What they already have**: an IDP, possibly an aging IGA (SailPoint, Saviynt, or homegrown), some PAM, fragmented NHI tooling

## Stakeholder map (durable Linx leadership)

| Stakeholder | Role | Cares about | Pushback pattern | Don't say |
|---|---|---|---|---|
| **Israel** | CEO | Revenue growth, ARR, Series B narrative, competitive positioning at scale | Will push for the bigger story, market sizing, why-this-matters-now framing | Implementation detail without business framing; "we're working on it" without timing |
| **Niv** | CPO | Product architecture coherence, customer-driven decisions, sharp positioning | Will challenge generic framings; weak "only we" claims; positioning by elimination ("unlike legacy"); category drift | Generic IAM/security framing; positioning that any vendor could write |
| **Sarit** | Eng lead | Architecture quality, what's actually buildable, principal-type abstractions, scope discipline | Will push back on assumptions about work that isn't ticketed yet; will flag scope creep; will demand clarity on boundaries | Architecture decisions framed as already-locked when they aren't |
| **Mor** | PM (agent governance / overlap surface) | Continuity with prior milestones, Notion canonical alignment, feasibility | Will flag prior decisions, prior framings, what won't ship | Anything that contradicts the canonical Notion taxonomy without explicit reason |
| **Dor** | Manager | Strategic clarity, no surprises, weekly visibility into pending items | Wants the headline; doesn't want to dig | Long status updates without a TL;DR |
| **Amir** | PM peer | NHI/IGA depth, competitive framing | Will challenge if NHI/agentic frames are sloppy | Conflating NHIs and agents without distinction |

Audience-lens commands work in any skill (`Niv lens`, `Israel lens`, `Sarit lens`, etc.) — re-read what's been written through that stakeholder's pushback pattern, flag what they'd object to.

## Linx PRD section pattern

Default for all Linx PRDs unless explicitly using a different audience format (e.g., one-pager for board):

1. **Objective** — what we're building, one paragraph
2. **Business justification** — why now, market signal, what it enables
3. **Non-goals** — explicit out-of-scope. Always include.
4. **User scenario** — specific user, specific flow (one named persona, one concrete situation)
5. **Functional requirements (P0–P3)** — grouped by milestone. Tag locked decisions inline so reviewers don't re-litigate.
6. **Success metrics** — how we measure
7. **Testing** — how we validate before ship
8. **Open questions** — only legitimately open. Answered questions move to a Decisions block, not stay here.

Reference appendix items at the end: architecture diagrams, Linear ticket links, competitor matrices, demo scripts, design files. Don't embed.

## Vocabulary (Linx-stable terms — use, don't substitute)

- **IGA** = Identity Governance & Administration. Linx's category.
- **Identity graph** = the relational model of humans + NHIs + agents + apps + resources. Linx's product wedge.
- **Access profile** = Linx's concept for what an identity is allowed to do. Org-assigned. Pre-existing for humans, extended to agents.
- **NHI** = Non-Human Identity (service accounts, API keys, OAuth apps, machine identities). Distinct from agents.
- **Agent** = autonomous workload identity, distinct from a static NHI. Has goal-driven behavior, multiple tool calls, often ephemeral.
- **Principal type** = abstraction over who-is-acting (human, NHI, employee agent, company agent, external user)
- **Birthright access** = default access granted to an identity by virtue of role / profile assignment
- **JIT (Just-in-Time)** = elevated access granted only at the moment of need, time-bound
- **Linx connector** = Linx's integration mechanism with downstream apps for discovery and governance

## Linx general pushback principles

These apply to any Linx-role artifact (PRD, positioning, customer call, internal review):

1. **Specificity over generality.** "Security admins" is too broad. Name the role, the company size, the trigger. "AI agent governance" is too generic. Name the agent type, the policy model, the enforcement layer.
2. **Falsifiable claims over fluff.** "Comprehensive AI governance" can't be tested. "Per-tool agent policy enforcement at the protocol layer with human → agent → tool audit chain" can.
3. **The "only we" test.** If a competitor could plausibly say the same thing about their product, the claim isn't differentiated. Niv pushes hard on this.
4. **Decided vs. open.** Track which questions are settled and which are open. Don't write "decided" things as TBD; don't write "open" things as locked.
5. **Audience-fit before sending.** Run the artifact through the relevant stakeholder lens before sharing. What would Niv push back on? What would Sarit flag as not-buildable? What would Israel ask for at scale?
6. **Convergence vs. differentiation.** When everyone in the category is converging on the same architecture (peer group), the differentiation question gets sharper, not softer. Generic peer-group framing ("we all agree X") is weaker than naming a real architectural fork.

## Stress Test convention

Every Linx-role artifact (PRD, framework, strategy, positioning) closes with:

- **Weakest piece**: what part is most likely wrong, and why
- **What a smart competitor would say**: the strongest external critique
- **What could change this**: external events that invalidate the framing

This is non-negotiable per Omri's working preferences. Even short artifacts get a 3-bullet Stress Test.

## How initiatives layer on top

Per-initiative context files (e.g., `initiatives/mcp-gateway/initiative-context.md`, `initiatives/<future-initiative>/initiative-context.md`) live in this repo or in project knowledge and contain:

- The initiative's locked decisions
- The initiative's pending decisions
- The initiative-specific competitor frame
- The initiative's primary customer signal
- The demo / artifact tied to that initiative
- Initiative-specific vocabulary (e.g., "MCP", "tool policy" for MCP Gateway)

When working on a specific initiative, the skill reads:
1. Embedded `linx-role-context.md` (durable Linx context) — always
2. The initiative-context file — when working on that initiative
3. The user's request — to determine which sections of the skill apply

When the initiative ships or pivots, only the initiative-context file changes. This file stays stable.
