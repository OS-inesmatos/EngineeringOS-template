# Postmortem Creation Skill

Koda skill that generates the initial retrospective draft for system-wide incidents.
Lives in the `ProcessEngineering` GitHub repository: `Skills/postmortem/`.

## What it does

Collects data from all available sources and assembles a complete retrospective draft following the standard template. Runs 7 phases:

| Phase | What |
| --- | --- |
| 1 — Jira | Incident description, linked issues, comments, team and asset fields |
| 2 — GitHub | PRs that triggered the incident — changes, reviewers, revert analysis |
| 3 — Timeline | Incident timeline from Rootly events and Slack messages |
| 4 — Impact | Affected tenants, error rates, customer incidents (Grafana + Zendesk) |
| 5 — Analysis | 5 Whys per finding, contributing factors, action items |
| 6 — Draft | Full document assembled from template, quality checklist run |
| 7 — Publish | Confluence page created, linked to RDINC via *RCA/Post Mortem URL* field |

## Output structure

Every draft has the same sections:

- **Overview** — severity, teams, timestamps, MTTA/MTTM/MTTR, links, incident roles
- **Detection & Trigger** — how detected, what triggered it
- **Executive Summary** — what changed, what broke, deployment timeline, resolution
- **Impact** — tenant count, customer incidents, per-tenant detail table
- **Communication** — external (Status Page) and internal (ICL, Slack, IC handoffs)
- **Findings & Contributing Factors** — technical and process findings, 5 Whys, action items
- **Action Items Summary** — consolidated table with type (Prevent / Detect / Mitigate / Process)
- **Recurrence Analysis** — prior incidents with the same pattern and their action item status
- **Lessons Learned** — what went well, what didn't, where we got lucky
- **Timeline** — chronological arc from first symptom to resolution
- **Data Sources & Completeness** — what was available, what is still missing

## Key behaviours

- **Never speculates** — if a fact can't be confirmed from a source, it's marked `[TODO: validate]` with exactly what's needed and from whom. Teams must resolve all TODOs before approval.
- **Evidence-based 5 Whys** — every step must cite a source (Jira, GitHub, Slack, Grafana). Stops at the last confirmed step.
- **Blameless language** — findings describe system/process failures, never individuals.
- **Skips the Rootly stub** — creates a clean new page instead of editing the auto-generated Rootly stub.

## What teams need to do with the draft

1. Resolve every `[TODO: validate]`
2. Validate the 5 Whys chains — add what the skill missed, remove what's wrong
3. Fill timeline gaps (calls, side conversations not in Slack)
4. Review findings for completeness — the skill may miss cultural/organisational context
5. Create and link action item tickets (Post-Incident Reviews link type in Jira)
6. Run the RCA quality assessment skill before the RCA working session

## Confluence reference

[AI-Assisted Retrospective Drafting — How It Works](https://outsystemsrd.atlassian.net/wiki/spaces/EEO/pages/6288572581)
(child of [WIP Retrospective Transformation Solution Proposed](https://outsystemsrd.atlassian.net/wiki/spaces/EEO/pages/6118113287))

## Status

- Skill built and tested against RDINC-78058 (SEV2, April 2026)
- PR #11 open on ProcessEngineering repo (branch: refactor/postmortem-skill-rootly-stub-bypass) — pending team approval
- Action items in retrospective drafts still require manual ticket creation by teams
