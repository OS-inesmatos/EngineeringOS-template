# Retrospectives Transformation - Initiative Tracker

**Status:** Solution Proposed, preparing Rollout 1
**Owner:** Inês Matos (Process Engineering)
**Co-authors of proposal:** Vera Branco, Pedro Charola Alves, João Brandão, João Rodrigues
**Proposal date:** 2026-03-13
**Last updated:** 2026-05-19

---

## Context for next sessions

If you're a future Claude picking this up: read this first, then `docs/PROPOSAL-NEW-MODEL.md` for the full proposal narrative.

### What this initiative is

We are replacing the SRE-led retrospective process. 2025 data: 72-day average lead time, 11 days just to assign a Commander, 63% of reviews concentrated in 2 people. The new model shifts ownership to the team that caused the incident and removes the Reviewer role entirely.

### The new model in one paragraph

When a Service Incident closes with `RCA = Yes` and a faulty asset identified, the Engineering Manager / Team Leader of the team owning that asset is assigned as **Retrospective Commander** (accountable, can delegate execution - Jira Assignee must reflect who actually leads it). The Value Stream Leader of the same area becomes the **Approver**. Process Engineering triggers two Koda skills: one to draft the retrospective from available context (Rootly, Slack, etc.), one to run a pre-assessment against the quality framework (✅/⚠️/❌ per question, 0-100% score). The Commander iterates on the draft, optionally with a working session (PE / Quality / SRE), and sets `Ready for Approval = Yes` in Jira. The VSL gets a Slack notification, reviews, and sets `Approved = Yes/No`. On approval, RDINC transitions to Retrospective Completed, PE runs the post-assessment, action items track via Problem Management, and when all are closed the incident Slack channel is deactivated and the incident is closed.

### Rollout strategy

Two phases. The process described above is the same in both - only the operator changes.

- **Rollout 1 (current):** Process Engineering manually triggers the Koda skills on their own machines. Validates the skills with real incidents, calibrates the quality framework, teams ramp up with a working baseline.
- **Rollout 2 (later):** Skills auto-triggered via Jira automation on incident closure. Commander/Approver assignment automated based on faulty asset → team mapping and Value Stream. PE shifts to advisory / sampling / skill maintenance.

### Roles

| Role | Responsibility |
|------|----------------|
| **Process Engineering** | Assigns Commander + Approver; runs draft / pre-assessment / post-assessment skills; facilitates working sessions when needed |
| **Retrospective Commander** (EM/TL) | Accountable for completion. Reviews + iterates on draft and pre-assessment. Sets `Ready for Approval = Yes`. Can delegate execution - Jira Assignee updated to whoever leads |
| **Approver** (VSL) | Approves (`Approved = Yes`) or requests changes (`Approved = No` + comment in RDINC) |
| **SRE** | Advisory / consultancy |
| **Reviewer** | ABOLISHED - replaced by AI-assisted quality framework |

### Jira fields in play

- **Impacted Asset(s)** - identifies the faulty asset (drives Commander assignment)
- **Assignee** - person actually leading execution (Commander or delegate)
- **Ready for Approval** (Yes/No) - Commander sets to Yes when ready
- **Approved** (Yes/No) - VSL sets after review

### Notifications

- Slack notification in incident channel when Commander + Approver assigned (Step 1)
- Slack notification with link to retrospective document (Step 2)
- Slack notification to Approver when `Ready for Approval = Yes` (Step 4)
- Slack notification to Commander on Changes Requested with feedback

### Quality framework

3 levels per question: ✅ Fully addressed / ⚠️ Present but weak / ❌ Missing. Score 0-100%. Pillars: Detection & Monitoring, Response & Communication, Troubleshooting & Root Cause, Recovery & Resolution, Prevention & Learning, Process Compliance. Source of truth for the framework lives in **ProcessEngineering repo** (`Skills/assess-postmortem/references/`) - synced into this repo at `docs/RCA-FRAMEWORK-*.md` and `docs/INCIDENT-RESPONSE-PROCESS-REFERENCE.md`.

The `assess-retrospective-pre` skill also lives in the ProcessEngineering repo (was removed from this repo in commit `80ee92f`).

### Progressive Autonomy Model

Teams start at Tier 1 (Learning, 0-40%) with PE fully facilitating, graduate to Tier 2 (Developing, 40-70%) with co-facilitation, then Tier 3 (Autonomous, 70-100%) self-facilitated. 3 consecutive retrospectives above threshold to graduate.

---

## Key artefacts

### Confluence

- **Parent proposal:** [WIP] Retrospective Transformation [Solution Proposed] - `6118113287`
  https://outsystemsrd.atlassian.net/wiki/spaces/EEO/pages/6118113287
- **Process documentation (child):** Retrospective Process - `6375669827`
  https://outsystemsrd.atlassian.net/wiki/spaces/EEO/pages/6375669827
  This is what teams should follow today. Describes the process as it works in Rollout 1.

### Local files

- `docs/PROPOSAL-NEW-MODEL.md` - full proposal narrative (the "why" + data)
- `docs/RCA-FRAMEWORK-PILLARS.md` + `RCA-FRAMEWORK-SCORING-GUIDE.md` - framework source (synced from ProcessEngineering)
- `docs/INCIDENT-RESPONSE-PROCESS-REFERENCE.md` - incident response process reference (synced)
- `docs/ROLLOUT-PLAN-TEMPORAL.md` - rollout plan with timeline
- `docs/CHANGE-MANAGEMENT-PATTERNS.md` + cheat-sheet - change management
- `dashboard/` - HTML dashboards (assessments, metrics, ops review table)
- `data/` - 2025 metrics CSVs that defended the proposal

### Diagrams

The current Rollout 1 diagram lives at `c:\Users\ios\Downloads\[ODC] M3.5 Retrospective Transformation - Rollout 1.jpg` (Inês's machine). The Confluence parent page embeds an older "New Process" version - swap it when the cleaned-up Rollout 1 image is uploaded.

---

## Open items

- [ ] Upload latest Rollout 1 diagram to Confluence (replace embedded "New Process" image on parent page)
- [ ] Confirm Rollout 1 start date
- [ ] Define Rollout 2 go/no-go criteria with quantitative thresholds (skill stability, score correlation)
- [ ] Document operational playbook for Process Engineering during Rollout 1
- [ ] Identify Jira automation hooks needed for Rollout 2 (assignment, triggers, notifications, field automation)
- [ ] Prepare presentation to teams (was targeted for April 13th)
- [ ] Prepare training for teams (Brown Bag sessions on RCA best practices)
- [ ] Integrate retrospective quality score with Problem Management action item tracking

---

## Session log

### 2026-05-19

- Synced `RCA-FRAMEWORK-PILLARS.md`, `RCA-FRAMEWORK-SCORING-GUIDE.md`, `INCIDENT-RESPONSE-PROCESS-REFERENCE.md` from ProcessEngineering repo (single source of truth)
- Created new Confluence child page **Retrospective Process** (`6375669827`) under the WIP proposal
- Wrote it as team-facing documentation for Rollout 1: brief rollout note at top + the process flow itself
- Updated the process to match the cleaned-up Rollout 1 diagram (Slack notifications at each handoff, explicit `Ready for Approval` and `Approved` Jira fields, Post-Assessment in Step 5)
