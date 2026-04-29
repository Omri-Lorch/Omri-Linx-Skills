# MCP Gateway / Agentic AI Identity — Initiative Context

> Owner: Omri Lorch
> Initiative: MCP Gateway / Agentic AI Identity
> Status: Pre-kickoff — scope commit target May 8, 2026
> Created: 2026-04-29
> Last updated: 2026-04-29

## Initiative in one paragraph

Linx is building an MCP Gateway that sits inline between customer AI agents and their target SaaS applications (Slack, Salesforce, Datadog), enforcing identity-aware access policies at the protocol layer. The original approach — governing agents via the same IAM APIs used for humans and NHIs — proved non-viable; agents' ephemeral, intent-driven, multi-hop access flows don't fit that surface. The Gateway replaces that layer. Policy model: `agent_perms = user_perms ∩ admin_ceiling`. Every MCP tool call is proxied, logged, and enforced. Hard deadline: Identiverse demo, June 15, 2026. P0 = Company AI Agents. Employee AI Agents and A2A are scoped for later phases.

## Locked decisions

| # | What | Date | Decider |
|---|---|---|---|
| 1 | Governance layer = MCP Gateway, not IAM APIs. Prior approach non-viable — agent access flows don't fit generic IAM API surface. | 2026-04-23 | Sarit + Amir Ben Ami |
| 2 | Linx is inline-for-everything — proxies every MCP tool call (not sidecar/observer). JIT approval flow is architecturally feasible. | 2026-04-26 | Omri + Mor |
| 3 | P0 connectors = target SaaS (Slack, Salesforce, Datadog). Agent platforms (n8n, Bedrock, Vertex) become identity-ingestion only, not enforcement points. | 2026-04-26 | Mor |
| 4 | Policy model confirmed: `agent_perms = user_perms ∩ admin_ceiling`. Admin sets hard ceiling; user perms are upper bound agent inherits. Both bounds apply. | 2026-04-26 | Mor |
| 5 | Demo format = 3-min booth loop. Cast: Sarah Cohen (PM, read-only agent) + Scott Davis (VP Sales, write agent). Tool: `update_opportunity`. Contrast: same action / different actor / different outcome. Maria = Security Admin. | 2026-04-28 | Dor |

## Pending decisions

| Question | Owner | By | Stakes |
|---|---|---|---|
| Tool-level granularity in P0? MCP spec exposes it but cost/feasibility unknown. Also: single-gateway vs. multi-gateway topology — if customers connect SaaS MCPs in parallel, Linx is blind to non-Linx traffic. | Omri (research) + eng (estimate) | Apr 30 | Shapes entire demo story and P0 surface area |
| Access Profiles: do current profiles support agent-scoped policies, or user-IGA only? Linx Claude flagged user-IGA only — contradicts Mor's M1 scope. | Omri + Mor | ASAP | Determines whether Access Profiles editor is in MVP or net-new build |
| Demo captions: on-screen or operator-only? | Dor | Open | Affects screen design for Live Activity and Audit Event Detail |
| Default permission model: opt-in (agents start at zero) vs. opt-out (agents inherit user perms capped by ceiling)? Mor's Apr 26 example pointed at opt-out but not confirmed. | Mor + Sarit | May 5 | Shapes onboarding UX and risk posture narrative |

## Agent use cases

| Use case | Priority | Notes |
|---|---|---|
| **Company AI Agents** — agents the org deploys (n8n, Bedrock, Vertex, Cursor, ServiceNow AICT) | **P0** | M1 shipped discovery for Gemini, Vertex AI, Bedrock, n8n. Enforcement is the MCP Gateway layer. |
| **Employee AI Agents** — agents individual employees spin up (personal Claude, shadow agents, unapproved tools) | **P1+** | Shadow-AI is explicit non-goal for P0. M4 territory for detection. Discovery coverage gap vs. Clutch. |
| **A2A (Agent-to-Agent)** — multi-agent collaboration across trust boundaries | **Acknowledged / deferred** | Gartner: "too immature for production." Linx roadmap M4. Protocol layer: A2A/ACP/LMOS. |

## Competitor frame

Three buckets for Identiverse positioning — which bucket a vendor is in determines the objection:

**Bucket A — Convergence players** (Saviynt, Ping Identity)
IGA/PAM incumbents expanding their existing identity platform to include agentic governance. Already in the customer's stack; MCP Gateway is an add-on. Objection: "Why not just use Ping/Saviynt?" Counter: Linx is not an IDP. Edge is the identity graph — humans + NHIs + agents in one model, which makes governance decisions sharp in ways an IDP bolt-on can't match.

**Bucket B — Architectural fork** (ConductorOne, Astrix)
NHI/service-identity vendors pivoting toward agent governance. Same problem space, different heritage. Building alongside their existing platform rather than native convergence. Competitive on posture + visibility; weaker on enforcement and IGA integration.

**Bucket C — Pure MCP gateway** (Lunar MCPX, Strata Maverics AI Identity Gateway, Operant)
MCP gateway as the product. No IGA heritage. Closest to Linx's P0 surface area technically. Linx counter: gateway is the delivery mechanism; the identity graph is the value. A pure gateway without IGA context makes decisions without knowing who owns what, who just left, or what the blast radius is.

**Linx position:** Bucket C execution + Bucket A strategic value. Deliver the gateway others are building; win on the IGA graph those vendors don't have.

## Customer signal (latest)

**Primary:** [FILL: Monday Apr 28 call transcript — paste key signal lines here. Source: Grain recording, Apr 28 2026. What did the customer say about agent visibility, policy enforcement, or compliance pressure?]

**Supporting signals (repo-sourced):**
- Monday.com = co-dev partner (40+ committed roadmap items). Named as the only reference customer across 8 months of Slack history. Strongest "we'd adopt this tomorrow" candidate.
- Amir's MCP telemetry bet: Salesforce/ServiceNow/Atlassian don't expose OAuth-app enumeration via their APIs. If MCP gives Linx a discovery channel those SaaS vendors won't, coverage curve is independent of vendor cooperation.
- 144:1 NHI-to-human ratio (SACR analyst benchmark) — manual oversight structurally impossible at scale. Use in CISO conversations to quantify why human-centric governance breaks.
- Gartner G00833725 (Jun 2025): analyst-validated 10-capability framework. "Same framework" = credibility with security-literate buyers.

## Initiative-specific vocabulary

| Term | Definition |
|---|---|
| **MCP** | Model Context Protocol — open protocol (Anthropic, Nov 2024) enabling AI agents to invoke external tools and services through a standardized interface. The protocol layer Linx governs. |
| **MCP server** | A service that exposes tools via MCP. Linx's gateway sits in front of MCP servers. Examples: Salesforce MCP server, Datadog MCP server, Slack MCP server. |
| **Tool** | A callable action exposed by an MCP server. First-class entity in Linx's graph. Properties: name, type (API\|MCP), auth type, permissions, target URL, target app. Example: `update_opportunity`. |
| **Tool policy** | An access rule bound to a specific tool (or tool class) rather than to an app or user. P0 feasibility gated on eng cost (Q1 in discovery-plan.md). |
| **Principal type** | The identity category making a request: human user, Company AI Agent, Employee AI Agent, or A2A (agent-to-agent). Linx must distinguish these at enforcement time — same action has different policy paths depending on principal type. |
| **Inline blocking** | The Linx gateway denying an MCP tool call in real time, before the action executes. Contrast with post-hoc detection. Enabled by the inline-for-everything architectural decision (locked Apr 26). |
| **Dual-header** | [FILL: define in Linx context — likely: the pattern of passing both user identity and agent identity in MCP request headers, enabling the gateway to evaluate both the human-level policy and the agent-level ceiling in one enforcement step. Confirm with Amir/Sarit.] |

## Demo / artifact links

- **Notion canonical (Agentic AI Identities epic):** https://www.notion.so/262259f655598091aaabfc5d58e38e96
- **Demo script v0.6 (Dor format):** `ol-linx-agent/artifacts/mcp-gateway-demo-script-dor-format-2026-04-28.md`
- **Demo script v0.3 (detailed flow):** `ol-linx-agent/artifacts/mcp-gateway-demo-script-2026-04-27.md`
- **Linear epics:** CON-3174 through CON-3189 — [FILL: add individual epic names/links once Linear MCP is connected or paste from Linear]
- **Eng bundle (reference links for Sarit/Amir):** `ol-linx-agent/artifacts/mcp-gateway-eng-bundle-2026-04-26.md`
- **Linx Claude validation prompt (reusable):** `ol-linx-agent/artifacts/linx-claude-validation-prompt-2026-04-28.md`
- **Discovery plan (open questions + decision timeline):** `ol-linx-agent/discovery-plan.md`

## Stress test

- **Weakest piece:** The demo depends on two net-new screens (Live Activity / MCP call stream, Audit Event Chain) that don't exist yet. If eng capacity is tighter than expected post-kickoff, the demo collapses to narration-only — which doesn't land at Identiverse. Need build commitment + fallback plan (recorded loop) before May 8 scope commit.
- **What a smart competitor would say:** "Identity governance gateways are a feature, not a product. Okta, Ping, and Saviynt will add this as a free module inside their existing IDP relationship. Linx's edge has to be the graph context — if you can't articulate that in 10 seconds on stage, you lose."
- **What could change this:** SFDC human-activity ingestion unblocked before June 15 (currently SEC-200, backlogged to Aug 2026) — would restore Stage 3 as a rendered row and make the contrast story live instead of narrated. Low probability; plan around its absence.
