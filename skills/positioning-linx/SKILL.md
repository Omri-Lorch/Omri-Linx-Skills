---
name: positioning-linx
description: Use when Omri needs a positioning statement for Linx products — drafting, refining, or stress-testing positioning for any Linx initiative or surface. Applies Linx-as-IGA framing and Niv-pushback test.
---

# Positioning Statement — Linx Role Skill

## When to use this skill

Use when Omri is working on positioning for a Linx product, surface, or initiative. Common triggers:

- "Draft a positioning statement for [X]"
- "Sharpen our positioning against [competitor]"
- "Help me write the position for the Identiverse demo"
- "Stress-test this positioning"
- "Niv wants positioning by [date]"

Don't use for full marketing copy, taglines, or messaging frameworks — this is the strategic clarity tool, not creative writing.

## How this skill works

Wraps the Geoffrey Moore positioning framework with Linx role context. When invoked:

1. **Always read `linx-role-context.md` first** — buyer profile, competitive landscape, stakeholder pushback patterns, category positioning. Pre-loaded.
2. **Ask Omri which surface this is for** — Linx core IGA, the agentic AI surface, a specific feature/initiative. If initiative-specific, ask if there's an initiative context file with the competitor frame.
3. **Skip pre-loaded context elicitation.** Don't ask the user to define their buyer or category — those are in role context. Confirm overrides only.

## What's pre-loaded from role context

- **Buyer**: CISO / Head of IAM / Director of Identity at mid-market to enterprise. Champion: security admin / IAM owner.
- **Org profile**: SaaS-heavy, enterprise IDP in place, fragmented NHI tooling.
- **Default category**: IGA (or specific IGA extension for the initiative).
- **General competitive landscape**: SailPoint, Saviynt (legacy IGA); ConductorOne, Veza (modern IGA); Astrix, Oasis (NHI pure-plays); Okta, Ping (IDP extending toward agents).

What's NOT pre-loaded and needs initiative context: the specific surface being positioned, the specific competitor frame for that surface, the specific differentiation claim.

Open with: "Pre-loaded from role context: buyer = CISO/IAM owner, org = SaaS-heavy enterprise, category default = IGA. Which surface are we positioning? Is there an initiative context file with the competitor frame?"

## The Geoffrey Moore framework (foundation)

**Value Proposition:**
- **For** [target customer]
- **that need** [underserved need]
- [product name]
- **is a** [product category]
- **that** [benefit statement]

**Differentiation Statement:**
- **Unlike** [primary competitor or competitive alternative]
- [product name]
- **provides** [unique differentiation]

## Linx-specific quality checks

After drafting, run all five:

### 1. Does this position Linx as IGA (or named IGA extension), not as a feature?

Drift to watch for: positioning Linx as a gateway, a security tool, an audit tool, an NHI tool. Linx is IGA. Specific surfaces extend IGA. Restate if drift.

### 2. Does the differentiation hold against the *real* competitor — not the convenient strawman?

Don't say "unlike legacy IGA" — say "unlike SailPoint" or "unlike Saviynt." Don't say "unlike NHI tools" — say "unlike Astrix" or "unlike Oasis." Force the named competitor.

### 3. Niv-pushback test

Niv (per role context) challenges generic framings, weak "only we" claims, category drift. Run the draft through Niv lens: would he push back? On what? Does the position survive?

### 4. Falsifiability test

Per Linx role pushback principle #2: the claim must be testable. "Unified identity model" is not testable. "Single graph spanning humans, NHIs, and agents — queryable in one schema, policy-enforceable in one rule engine" is testable.

### 5. "Only we" test

Per Linx role pushback principle #3: if any competitor could plausibly say the same thing, the claim isn't differentiated. Run the position against each named competitor in the initiative context: would they say the same? If so, sharper.

## When to escalate to a positioning workshop

If the session opens with fundamental questions (e.g., "should we even position as IGA or as a new category?"), escalate. This skill assumes category, buyer, and competitor frame are settled enough to write against. If they aren't, that's a strategy decision needing workshop format and Niv/Israel input.

## Output and next steps

Once locked:

1. Run all 5 Linx quality checks
2. Apply Linx Stress Test convention
3. Identify which stakeholder needs to validate (typically Niv for product positioning, sometimes Israel for company-level)
4. Output to relevant location — Notion positioning page, repo file, deck slide. Ask which.

## Iteration commands

Standard:
- "Sharpen [section]" — tighten language
- "Add alternatives" — try different category framings or differentiator angles
- "Test against [competitor]" — run the "only we" test against a specific competitor

Linx additions:
- **"Niv lens"** / **"Israel lens"** — re-read through stakeholder
- **"Falsifiability check"** — force testable form
- **"Only we test"** — run against each named competitor
- **"Category check"** — flag any drift from IGA / IGA-extension framing

## Stress Test (this skill)

- **Weakest piece**: assumes "Linx is IGA" is settled. If Linx pivots to category creation or to a different category framing, the role context updates first and this skill's #1 quality check changes.
- **What a smart competitor would say**: "A skill that defaults the category to IGA produces only IGA-shaped positioning — exactly the convergence trap." Counter: the skill supports category-creation pivots via the escalate path. Default isn't a trap when the escape hatch is documented.
- **What could change this**: Linx category pivot, change in named competitor set (e.g., Saviynt acquired, ConductorOne pivots), change in buyer profile. Update role context first.
