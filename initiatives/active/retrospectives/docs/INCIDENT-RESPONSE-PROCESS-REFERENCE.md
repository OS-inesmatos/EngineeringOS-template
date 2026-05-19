# Incident Response Process — Reference for Retrospective Assessment

**Source:** [Incident Response Process](https://outsystemsrd.atlassian.net/wiki/spaces/RKB/pages/4977361294/Incident+Response+Process) (v9.0, 2025-11-26)  
**Purpose:** Calibrate retrospective gap detection against the official OutSystems incident response process.

---

## Incident Scenarios

| Scenario | Definition | Retrospective |
|----------|-----------|---------------|
| **Scenario 1** | Without system-wide impact — issue contained to 1 tenant | Optional |
| **Scenario 2** | With system-wide impact — 1+ region(s) partially (>1 tenant) or fully affected | **Mandatory** |
| **Scenario 3** | Late detection of system-wide impact — started as Scenario 1, escalated | **Mandatory** |

**System-wide impact definition:** 1 or more regions partially (>1 tenant) or fully affected, or with potential to escalate to those proportions.

---

## Roles by Scenario

| Role | Scenario 1 | Scenario 2 & 3 |
|------|-----------|----------------|
| **Incident Commander** | Dev Team / Engineer On Call | SRE Team / SRE On Call |
| **Retrospective Commander** | Dev Team | SRE Team |

---

## Severity Levels & Time-to-Repair Objectives

| Severity | Description | Time to Repair (Objective) |
|----------|-------------|---------------------------|
| **SEV1** — Urgent | Complete loss of service, usually affecting many or all customers. Authentication unavailable, 1CP unavailable in a region. | **≤ 1 hour** |
| **SEV2** — High | Significant problem, no workaround, customer productivity severely impacted. Affects a subset of customers. | **≤ 4 hours** |
| **SEV3** — Normal | Non-critical, may have a workaround. Does not require immediate action. | **< 2 weeks** |
| **SEV4** — Low | Minor issues, workarounds available, no immediate business impact. | **< 4 weeks** |

---

## Incident Declaration (Scenarios 2 & 3 — System-wide)

- SRE Team assesses and **confirms** system-wide impact → triggers formal incident declaration
- A **Slack channel is created automatically** (all communications must happen there)
- SRE takes the **Incident Commander** role and swarms with Development Teams
- Jira incident is the **single source of truth** — all decisions, steps, and people involved must be logged there

---

## Internal Communications (System-wide Incidents — Scenario 2/3)

The SRE Incident Commander is responsible for posting updates in the incident Slack channel whenever there is relevant information to share. The stages below serve as reference points, not strict requirements:

- **Investigating** — scope and nature of impact being assessed
- **Identified** — root cause or contributing factor identified
- **Monitoring** — mitigation applied, monitoring for recovery
- **Resolved** — service fully restored

Global Support is present in the incident channel and has direct access to all communications.

> **Process change (rolling out ~May 2026):** The Internal Communications Leader (ICL) role has been eliminated. The SRE IC now carries full responsibility for incident channel updates.

---

## Recovery Measures — Required Process

**The primary goal is to minimize customer impact as quickly as possible.**

The process mandates this sequence:

1. **Identify the faulty asset(s)** — know the source before acting
2. **Consider rollback first** — always evaluate rollback as the fastest recovery path:
   - Is rollback possible?
   - What is the risk associated with rollback?
   - If feasible and risk is acceptable → rollback immediately
3. **Only if rollback is not feasible or too risky** → explore other mitigation strategies

**Traceability requirement:** Recovery measures must be linked to the RDINC Jira issue using the **"is blocked by"** link type.

---

## Jira Workflow & Statuses

| Status | Meaning |
|--------|---------|
| **Backlog** | New incident, waiting to be assigned |
| **Team Assigned** | Assigned to an R&D team |
| **Troubleshooting in Progress** | Being actively worked on |
| **Waiting for Customer** | Pending customer information |
| **Solved** | Service restored on R&D side |
| **Retrospective In Progress** | Retrospective being worked on |
| **Retrospective Completed** | Root cause identified; all improvement opportunities noted and linked to RDINC. RDINC stays here until all **blocking linked tasks** are completed. |
| **Closed** | All improvement actions identified in retrospective have been **delivered into Production** |

---

## External Communication

Customer-facing status page communication is managed entirely by **Global Support**. GS has full accountability and is directly present in the incident Slack channel, using the IC's updates as the basis for customer-facing communications. There is no formal handoff required from R&D/SRE to GS.

R&D teams do not communicate directly with customers.

---

## Executive Summary (System-wide Incidents — Scenario 2/3)

> **Process change (rolling out ~May 2026):** Completing the Executive Summary in Rootly is mandatory as soon as the incident is marked as Resolved. The SRE Incident Commander is responsible for writing it. Completion triggers a notification in the incident Slack channel.

**Why mandatory:**
- Ensures Global Support has complete, accurate information immediately for external status page post-mortems
- Captures context while fresh — prevents quality loss from delayed work

---

## How This Informs Assessment Gap Detection

### Pillar 2 — Response & Communication

- **Q1 (Declaration timely):** Cross-reference against scenario. SEV1 system-wide → SRE should declare promptly after confirming impact. Delays must be explained.
- **Q2 (Internal communication):** SRE IC is responsible for posting updates in the incident channel whenever relevant. Verify whether the IC posted timely, clear updates throughout the incident. Note: ICL role has been eliminated.
- **Q3 (External communication):** Status page is fully owned by Global Support (full accountability, no R&D handoff). The retrospective should document whether the status page was updated, timing (Public TTA), and whether content was accurate.
- **Q4 (TTA):** SEV1 time-to-repair objective is ≤ 1 hour. TTA significantly above this warrants analysis.

### Pillar 4 — Recovery & Resolution

- **Q3 (Rollback considered):** The process explicitly mandates rollback as the **first option to evaluate**. If not used, the retrospective must document why (risk too high, not feasible). Absence of rollback discussion = process gap.
- **Q4 (Recovery blockers):** Check if Jira traceability was maintained ("is blocked by" links). Missing links = potential process gap.

### Pillar 6 — Process Compliance

- **Q1 (Process followed):** Verify:
  - Correct scenario identified (1, 2, or 3)
  - Correct roles assigned per scenario (Incident Commander: Dev Team for Sc1, SRE for Sc2/3)
  - Slack channel used for all comms (Sc2/3)
  - Jira kept as single source of truth
  - Retrospective triggered (mandatory for Sc2/3, optional for Sc1)
  - Executive Summary completed in Rootly at Resolved stage, written by the SRE IC (Sc2/3) — verifiable via Slack channel notification

---

**Document Owner:** Inês Matos (Process Engineering)  
**Last Updated:** 2026-05-14
