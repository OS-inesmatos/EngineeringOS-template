# Method 3 KPIs — Incident Management

*Success metrics for each sub-method of the Incident Management framework*

---

## Purpose

This document defines the KPIs that measure whether each sub-method implementation is delivering the intended outcomes. These are **not** project completion metrics — they measure adoption, effectiveness, and impact.

---

## M3.1 — Failure Management Governance

**Objective:** Deploy controlling framework for failure lifecycle and Action Item Plan traceability

**Context:** Process Engineering created the Failure Management process and Power BI dashboard. Release Engineering (João Brandão) currently reviews dashboard bi-weekly and reports in Operations Review. **Governance gap:** ownership, KPI definition, review mechanism, and action plan not clearly established.

### Success KPIs

#### Governance Structure Established

| KPI | Target | How to Measure | Frequency |
|-----|--------|----------------|-----------|
| **Process ownership documented** | 100% clarity on who owns process vs who reports data | RACI matrix published, stakeholders aligned | One-time (Q1 2026) |
| **KPI review mechanism defined** | Defined cadence, attendees, decision-making authority documented | Governance document published to Confluence | One-time (Q1 2026) |
| **Action plan monitoring process** | Clear escalation path and accountability for blocked Action Items | Process documentation with SLA/OLA for escalation | One-time (Q1 2026) |

#### Process Effectiveness

| KPI | Target | How to Measure | Frequency |
|-----|--------|----------------|-----------|
| **Failure resolution time** | Average time from "Backlog" to "Solved" reduces by 20% YoY | Power BI dashboard (Jira RDODCF data) | Monthly |
| **Action Item completion rate** | 90% of Action Items (linked as "is blocked by") completed within SLA | Jira link tracking, Action Item age analysis | Monthly |
| **Root Cause categorization accuracy (Infrastructure)** | 90% of failures categorized as "Infrastructure Bug" or "Infrastructure Timeout" have "Is Root Cause Correct?" = Yes | Jira field validation for Infrastructure-related Root Causes only | Monthly |
| **Cross-team escalation rate** | % of failures requiring team reassignment decreases by 30% YoY | Jira "Teams" field change tracking | Quarterly |
| **Recurrence rate** | % of failures with same Root Cause as previous failures decreases by 25% YoY | Pattern analysis (Root Cause + Impacted Asset matching) | Quarterly |

#### Dashboard & Reporting

| KPI | Target | How to Measure | Frequency |
|-----|--------|----------------|-----------|
| **Dashboard KPIs aligned** | 100% of governance KPIs tracked in Power BI dashboard | Dashboard audit vs KPI list | One-time (Q1 2026), then on KPI changes |
| **Operations Review reporting consistency** | 100% of Ops Review sessions include defined KPIs | Ops Review meeting notes audit | Monthly |
| **Dashboard usage** | At least 10 unique users (team leads, engineering managers) access dashboard monthly | Power BI usage logs | Monthly |

### Leading Indicators (Early Warning)

- **Failures stuck in "Troubleshooting in Progress"** for >7 days (should decrease)
- **Action Items with no progress update** for >14 days (should trigger escalation)
- **Teams requesting ownership reassignment** (high rate = poor initial automation logic)
- **Failures with no Assignee assigned** within 24h of creation (should be near zero)
- **Infrastructure Root Cause rejections** (high % of "Is Root Cause Correct?" = No indicates need for training or clarification of categorization definitions)

### Governance Clarification Needed (Q1 2026)

**Questions to answer:**

1. **Who owns the Failure Management process?**
   - Process Engineering (design, maintain, improve) vs Release Engineering (execute, report)
   - Decision-making authority for process changes

2. **What KPIs matter most?**
   - Which metrics drive action vs which are informational?
   - What thresholds trigger escalation or intervention?

3. **Action plan:**
   - When KPIs are red, who is accountable for taking action?
   - What is the escalation path if Action Items are blocked?
   - How do we close the loop from KPI observation → action → improvement?

**Review cadence:** Monthly for first 6 months post-governance deployment, then quarterly

---

## M3.2 — Status Page Governance

**Objective:** Establish clear ownership and process for Status Page updates during incidents

**Status:** Q2 2026 focus (KPIs to be defined)

### Placeholder KPIs

- Time to first Status Page update after incident declaration
- Accuracy of Status Page updates (measured via retrospective feedback)
- Customer satisfaction with incident communication

*To be refined in Q2 2026*

---

## M3.3 — Triage Models & OLAs (Service Incident Lifecycle)

**Objective:** Clarify operational accountability across the full Service Incident lifecycle — from initial triage (Support Case vs Service Incident) through OLAs to retrospective closure

**Scope:** This sub-method covers:
1. **Triage** — Support Case vs Service Incident classification
2. **OLAs** — Handoff agreements between Support and Engineering
3. **Retrospectives** — New team-led model (April 2026 rollout)

**Context:** New retrospective ownership model shifts accountability from SRE-led to team-led, with Engineering Managers as reviewers. This addresses critical delays (72-day average lead time in 2025) and SRE capacity bottleneck.

---

### Success KPIs

#### Triage & Handoff

| KPI | Target | How to Measure | Frequency |
|-----|--------|----------------|-----------|
| **Triage accuracy** | 90% of cases correctly classified as Support Case vs Service Incident | Post-triage audit, retrospective analysis | Monthly |
| **Handoff clarity** | Reduction of 50% in escalation disputes between Support and Engineering | Dispute log, escalation metrics | Quarterly |
| **Time to correct team** | Average time to route incident to correct team reduces by 30% | Incident routing metrics, timestamp analysis | Monthly |
| **OLA adherence** | 95% of Support-to-Engineering handoffs meet defined OLA criteria | OLA compliance tracking | Monthly |
| **Stakeholder confidence** | 80% of Support and Engineering leads agree model clarifies accountability | Post-implementation survey | Quarterly |
| **Heuristic usability** | 85% of triage decisions can be made using documented heuristic without escalation | Triage decision tracking | Monthly |

#### Retrospectives (New Model — Rollout July 2026)

| KPI                             | Target                                                                                      | How to Measure                                                    | Frequency |
| ------------------------------- | ------------------------------------------------------------------------------------------- | ----------------------------------------------------------------- | --------- |
| **Retrospective lead time**     | < 45 days (from 72 days baseline)                                                           | Time from incident resolution ("Solved") to retrospective closure | Monthly   |
| **Assignment latency**          | < 3 days (from 11 days baseline)                                                            | Time to assign Retrospective Commander to incident-causing team   | Weekly    |
| **Retrospective quality score** | > 70% average quality score based on framework pillars (reliability, process, code quality) | AI/Koda-assisted auditing + sampling-based review                 | Monthly   |

---

## M3.4 — Problem Management

**Objective:** Establish systematic approach to identify and address recurrent failures

**Status:** Q3-Q4 2026 focus (KPIs to be defined)

### Placeholder KPIs

- Recurrence rate of incidents with identified root causes
- Problem ticket resolution time
- Percentage of retrospectives that identify systemic patterns

*To be refined in Q2-Q3 2026*

---

## M3.5 — Incident Training

**Objective:** Build incident response capability across engineering teams

**Status:** Q4 2026 focus (KPIs to be defined)

### Placeholder KPIs

- Percentage of engineers trained in incident response
- Incident Commander certification rate
- Triage accuracy improvement post-training
- Time to effective incident response (trained vs untrained teams)

*To be refined in Q3-Q4 2026*

---

## M3.6 — Audit Readiness

**Objective:** Guarantee Incident Audit Readiness by orchestrating evidence collection

**Status:** Q1 2027 (BAU activity — cross-cutting concern)

**Context:** Maintain a "Ready-Vault" of Incident and Problem evidence. This is considered in the implementation of all other sub-methods (M3.1-M3.5).

### Placeholder KPIs

- Evidence vault completeness (% of incidents with complete evidence trail)
- Audit response time (time to produce evidence when requested)
- Evidence quality score (completeness, accuracy, accessibility)
- Process audit compliance rate

*To be refined in Q4 2026*

---

## M3.7 — Event Management (Alert Validation)

**Objective:** Protect Engineering capacity by defining alert validation and intake for Incident response practice

**Status:** Q1 2027 focus (RSA-738)

**Context:** Similar to Failure Management, extract Alerts and have teams validate if they are false positives. If real issue, convert to Incident. Goal: reduce noise from false positive alerts.

### Placeholder KPIs

- False positive rate (% of alerts validated as false positives)
- Alert-to-Incident conversion rate
- Engineering time saved (hours not spent on false positive investigation)
- Alert validation time (time from alert trigger to validation)
- Alert quality by source (which monitoring systems generate most false positives)

*To be refined in Q4 2026 - Q1 2027*

---

## Cross-Method KPIs

These KPIs measure the overall health of the Incident Management framework across all sub-methods:

| KPI | Target | How to Measure | Frequency |
|-----|--------|----------------|-----------|
| **Mean Time to Resolution (MTTR)** | Reduce by 20% year-over-year | Incident metrics | Quarterly |
| **Incident recurrence rate** | Reduce by 30% year-over-year | Incident tracking, pattern analysis | Quarterly |
| **Customer impact severity** | Reduce P1/P2 incidents by 25% year-over-year | Incident classification data | Quarterly |
| **Team confidence in process** | 80% of teams rate incident processes as "clear and effective" | Quarterly survey | Quarterly |
| **Documentation completeness** | 100% of system-wide incidents have completed retrospectives | Retrospective tracking | Monthly |

---

## KPI Review Process

**Who:** Process Engineering team + relevant stakeholders (Support, Engineering leads)

**When:**
- Monthly reviews for active sub-methods in first 3 months post-implementation
- Quarterly reviews for mature sub-methods
- Annual review of cross-method KPIs

**What:**
- Review current KPI performance vs targets
- Identify trends (improving, declining, stable)
- Flag blockers or process gaps
- Adjust targets if needed (document reasons)

**Output:** KPI review summary published to Confluence, action items tracked in Jira

---

## Notes on Measurement

### Data Sources

- **Jira:** Failure lifecycle, Action Plans, retrospective completion
- **Dashboards:** Real-time metrics, team adoption, process adherence
- **Incident tracking system:** MTTR, recurrence, severity classification
- **Surveys:** Stakeholder confidence, team satisfaction
- **Retrospectives:** Qualitative feedback, process gaps

### Baseline Establishment

Before implementing each sub-method, establish baseline metrics for at least 3 months. This allows meaningful comparison and validates that improvements are real, not seasonal variation.

### Target Adjustment

Targets should be reviewed quarterly. If consistently exceeding targets, increase them. If consistently missing, investigate root cause before adjusting down.

---

*Created: 2026-03-17*
*Last updated: 2026-03-17*
