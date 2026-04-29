---
name: discovery-interview-linx
description: Use when Omri is preparing for a customer discovery interview about Linx — drafting questions, planning methodology, or pre-call briefing. Applies Linx buyer profile and IGA-aware listening framework.
---

# Discovery Interview Prep — Linx Role Skill

## When to use this skill

Use when Omri is preparing for a customer call or discovery interview about Linx. Common triggers:

- "I have a call with [customer] tomorrow — help me prep"
- "Draft discovery questions for [account]"
- "Pre-call brief for the Monday follow-up"
- "What should I ask in this interview?"
- "Help me plan a customer development sprint"

Don't use for prepared sales demos, product walkthroughs, or post-call synthesis — this is for the prep stage of customer discovery.

## How this skill works

Wraps the discovery interview prep pattern with Linx role context. When invoked:

1. **Always read `linx-role-context.md` first** — buyer profile, stakeholder map, vocabulary, pushback principles. Pre-loaded.
2. **Ask Omri what specific call this is for** — which customer/prospect, what initiative, what outcome they want from the call. If account-specific or initiative-specific context exists (prior call notes, transcripts), ask Omri to share or load.
3. **Skip pre-loaded segment elicitation.** Don't ask "who is your target customer?" — Linx's buyer profile is in role context. Confirm overrides only.

## What's pre-loaded from role context

- **Target segment**: security admin / IAM owner / CISO at mid-market to enterprise SaaS-heavy company with enterprise IDP in place.
- **Default constraints**: existing relationships through Linx customer base + design partner intros.
- **Buyer concerns** (general): IGA stack, SaaS onboarding, identity discovery, incident speed, who-owns-what across security/AppSec/data governance.

What's NOT pre-loaded:
- The specific call's research goal (depends on what's being learned)
- The methodology choice (depends on goal)
- Account-specific context (what we already know about this customer)

Open with: "Pre-loaded from role context: target = security admin / CISO at SaaS-heavy enterprise, constraints = existing relationships. Confirm or override. Which call is this for? What's the goal? Is there account or initiative context to load?"

## Choosing methodology

Once research goal is clear, recommend a methodology. Common patterns:

| Goal | Methodology | When |
|---|---|---|
| Validate that a problem is real and painful | Mom Test problem-validation | Pre-product, validating a wedge |
| Understand customer's actual jobs | JTBD interviews | Repositioning or strategic clarity |
| Understand why they switched away | Switch interviews | Competitive intel, churn analysis |
| Map full customer journey | Timeline interviews | Buying-center mapping, complex sales |
| Validate which problems matter most | Opportunity solution tree | Roadmap prioritization |

Combine if goal calls for it (e.g., Mom Test + Switch for a competitive call).

## Linx-general listening framework

Across any Linx customer call, listen for:

| Customer says... | Probe |
|---|---|
| Mentions a specific competitor (Astrix, C1, Saviynt, SailPoint, Okta, Ping, etc.) | Did they evaluate? Buy? What stopped them? See vendor-validation bias below. |
| Names an internal tool / homegrown system | What does it do well? What does it not do? Replacement candidate? |
| Describes an audit / compliance trigger | What was the gap? Who asked? What's the deadline? |
| Mentions NHI sprawl / orphaned accounts / API key issue | Volume? Discovery method today? Owner? |
| Mentions agents / Copilot / AI tools they're rolling out | Initiative-specific listening framework should take over here |
| Says "shadow IT" / "shadow AI" / unmanaged X | Detection method? Tolerance? Has security caught one in the act? |

When the call shifts toward an initiative-specific topic, switch to that initiative's listening framework if loaded.

## Linx-specific buyer concerns to probe (general)

Default probes useful across most Linx customer calls:

1. **What's your current IGA stack?** — surfaces where Linx fits / displaces / coexists. Tools named matter.
2. **How do you onboard a new SaaS app today, end to end?** — surfaces operational pain.
3. **When was the last time you discovered an identity you didn't know existed?** — surfaces NHI / shadow / discovery gaps. Mom Test framing.
4. **What does your IDP / IGA tool currently say when you ask about [emerging topic]?** — surfaces incumbent positioning.
5. **If you discovered a rogue identity right now, what's the fastest you could revoke its access?** — surfaces enforcement gap.
6. **Who owns identity risk vs. application security risk vs. data governance risk in your org?** — surfaces buying-center mapping.

For specific initiatives, layer initiative-specific probes on top of these (in initiative context file).

## Linx-specific biases to avoid (additions to standard interview biases)

Standard biases (confirmation, leading, hypothetical, pitching, yes/no) still apply. Add:

### Vendor-validation bias

Customer praising Astrix / C1 / Ping / Saviynt doesn't mean they're sold — they're often just polite about meetings they took. Probe: "Did you actually buy or just evaluate?" / "What stopped you from signing?"

### Incumbent-tolerance bias

Customers often live with their current IGA's gaps because switching is painful. Don't take "we're fine with $TOOL" at face value. Probe: "When was the last time $TOOL frustrated you?" / "What workarounds have you built?"

### Compliance-checkbox bias

Customers may describe their need in compliance-speak ("we need SOX coverage for agents") because that's what gets budget approved. Probe to find the underlying operational pain.

### Framework-imposition bias

Don't ask the customer to validate Linx's frameworks (graph model, NHI vs. agent distinction, three-bucket competitive frames). They don't think in those terms. Listen for what they say in their own language; map to Linx framings during synthesis.

### Demo-anchor bias

Don't lead with how Linx narrates the product. Customer describes their scenario first; you map it to Linx's framing afterward.

## Output: pre-call brief

Per standard interview prep, output a structured plan. Linx additions:

- **Pre-call brief section**: who the customer is, what we already know (from prior calls, account context, public signals), three things we want to learn that we don't already know.
- **Question set**: 6-10 questions in the chosen methodology, each with rationale and follow-up probes.
- **Synthesis-ready note structure**: every interview note should classify quotes by (a) which Linx product capability the customer is implicitly asking for, (b) which competitor framing (if any) they're echoing, (c) which Linx open question they have a view on.
- **Save destination suggestion**: customer-intel file under that customer's section, with date.

## When to escalate to a full discovery process

If the call is part of a longer sequence (multiple interviews, formal customer development sprint), escalate to a full discovery process — multi-call planning, synthesis cadence, hypothesis tracking. This skill is for prepping individual calls.

## Iteration commands

Standard:
- "Refine question [N]" — sharpen wording or follow-ups
- "Adjust methodology" — shift from one approach to another
- "Add stakeholder questions" — if multiple roles will be in the room

Linx additions:
- **"Vendor-bias check"** — re-read questions for vendor-validation traps
- **"Compliance-bias check"** — re-read for compliance-checkbox traps
- **"[Stakeholder] lens"** — if the call output will go to Niv, Israel, etc., re-read through that pushback pattern

## Stress Test (this skill)

- **Weakest piece**: the buyer-concern probes assume the Linx buyer is security admin / IAM owner / CISO. If on a specific call the actual room contains a platform engineer or a data governance owner, the probes need re-shaping. Mitigation: pre-call brief always confirms attendees before locking question set.
- **What a smart competitor would say**: "Pre-loading buyer probes leads to interviews that confirm what Linx already knows about its buyer. Real discovery surfaces buyers Linx hasn't met." Counter: probes are starting points; the listening framework explicitly listens for unexpected signals.
- **What could change this**: shift in Linx's buyer profile, shift in IGA market structure, shift in Linx's product such that the category itself changes. Update role context first.
