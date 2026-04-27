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
| **SEV1** — Urgent | Complete loss of service, usually affecting many or all customers. Authentication unavailable, 1CP unavailable in a region. | **< 30 minutes** |
| **SEV2** — High | Significant problem, no workaround, customer productivity severely impacted. Affects a subset of customers. | **< 8 hours** |
| **SEV3** — Normal | Non-critical, may have a workaround. Does not require immediate action. | **< 2 weeks** |
| **SEV4** — Low | Minor issues, workarounds available, no immediate business impact. | **< 4 weeks** |

---

## Incident Declaration (Scenarios 2 & 3 — System-wide)

- SRE Team assesses and **confirms** system-wide impact → triggers formal incident declaration
- A **Slack channel is created automatically** (all communications must happen there)
- SRE takes the **Incident Commander** role and swarms with Development Teams
- Jira incident is the **single source of truth** — all decisions, steps, and people involved must be logged there

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

- **Customer-facing communication** is always managed through **Global Support** — R&D teams do not communicate directly with customers
- R&D teams communicate with Global Support via the **Jira Zendesk Integration** on the incident ticket

---

## How This Informs Assessment Gap Detection

### Pillar 2 — Response & Communication

- **Q1 (Declaration timely):** Cross-reference against scenario. SEV1 system-wide → SRE should declare promptly after confirming impact. Delays must be explained.
- **Q2 (Internal communication):** For system-wide incidents, all comms must be in the dedicated Slack channel. Verify whether this happened.
- **Q3 (External communication):** Customer-facing comms go through Global Support. Assess whether the retrospective documents how and when Global Support was engaged.
- **Q4 (MTTA):** SEV1 time-to-repair objective is <30 min. MTTA significantly above this warrants analysis.

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

---

**Document Owner:** Inês Matos (Process Engineering)  
**Last Updated:** 2026-04-27
