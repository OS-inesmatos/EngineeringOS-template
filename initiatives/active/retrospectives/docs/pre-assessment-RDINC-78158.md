# Retrospective Pre-Assessment — RDINC-78158

**Incident:** [RDINC-78158](https://outsystemsrd.atlassian.net/browse/RDINC-78158) — SEV2 — Few requests failing on Ingestion API with 503 error on datap-ga-us-east-1-01
**Assessment Date:** 2026-04-27
**Assessed By:** Koda Pre-Assessment Skill v2.0
**Document:** [Retrospective — RDINC-78158 (Confluence)](https://outsystemsrd.atlassian.net/wiki/spaces/RKB/pages/6161990125)

---

## Overall Quality Score: **56/100** 🟡

**Status:** Needs improvement — working session required
**Recommendation:** Strong technical content on troubleshooting and learnings, but critical gaps in process analysis (54-min declaration gap unexplored, MTTA missing), an unconfirmed root cause hypothesis, and the single action item (RDGRS-2150) missing all three mandatory Jira fields. Schedule RCA working session before VSL submission.

---

## Score Breakdown by Pillar

| Pillar | Score | Status | Summary |
|--------|-------|--------|---------|
| 🕵️ Detection & Monitoring | 67/100 | 🟡 | Detection well-documented; alerting gap identified; SLO/error budget data absent |
| 📣 Response & Communication | 17/100 | 🔴 | 54-min GRS-to-SRE gap unexplored; MTTA missing; Q3 N/A (telemetry infra) |
| 🔍 Troubleshooting & Root Cause | 67/100 | 🟡 | Detailed troubleshooting; root cause is an unconfirmed hypothesis (evidence lost at restart) |
| 🩹 Recovery & Resolution | 57/100 | 🟡 | Fix and cascading effects well-documented; no rollback analysis, MTTR unlabeled, no runbooks |
| 🧠 Prevention & Learning | 50/100 | 🟡 | Strong concrete learnings; RDGRS-2150 missing all mandatory fields; no recurrence check |
| ✅ Process Compliance | 75/100 | 🟢 | SRE IC correct; RFC compliance not explicitly assessed (2 questions only) |

**Overall Pre-Assessment:** 10/24 questions fully addressed — 13.5 points out of 24 possible (56%)

_Note: 2 questions scored N/A: P2 Q3 (external comms — telemetry infra, no end-user impact) and P5 Q1 (not change-related — infrastructure drift). Denominator reduced from 26 to 24._

---

## External Status Page Verification

Checked https://status.outsystems.com/history for entries matching April 2, 2026.

**Result: No entry found.** April 2026 status page entries are from April 13 and April 21. No entry for this April 2 incident, consistent with the scope: 1% ingestion request failure in telemetry infrastructure with no direct end-user customer impact. No external communication via status page was required or published.

**P2 Q3 Assessment:** 🚫 N/A — No customer-facing external communication applicable. Excluded from denominator.

---

## Detailed Assessment by Pillar

### 🕵️ Pillar 1: Detection & Monitoring (67/100)

**Score:** 4.0 / 6.0 points

#### ✅ Fully Addressed (4 questions)

**Q1: How was the incident initially detected?**
- ✅ **GOOD:** "It was reported in Data Platform public channel on slack, that the requests from CMCP are failing." Timeline documents Rootly alert at 12:15 PM WEST triggered by Vikram Patil (Data Platform), full on-call escalation chain visible.
- **Evidence:** Detection mechanism fully documented — Slack report from downstream consumer, Rootly alert, and escalation chain all captured.

**Q2: Was the incident detected before customer impact?**
- ✅ **GOOD:** Impact was limited to internal telemetry infrastructure consumers (Fluentbit, exporter queues) — no direct end-user customer-facing impact confirmed. Retrospective explicitly acknowledges reactive detection via downstream symptoms.
- **Evidence:** Impact scope clearly distinguished (infrastructure-level). Improvement section acknowledges the detection gap with candour.

**Q3: Were alerts clear and actionable?**
- ✅ **GOOD:** "Improve monitoring and alerting for this failure scenario, specifically around xDS endpoint synchronization health and circuit breaker overflow conditions, since the incident was detected only through downstream symptoms rather than at the source."
- **Evidence:** Question thoroughly answered — existing alerts were insufficient, the detection gap is explained, concrete action item (RDGRS-2150) created.

**Q6: What can be improved in detection?**
- ✅ **GOOD:** "Set up monitoring and alerting for xDS desynchronization scenarios, including checks on `glooe_solo_io_xds_insync` versus `glooe_solo_io_xds_total_entities`, so stale endpoint situations can be detected earlier."
- **Evidence:** Specific metrics named. Concrete diagnostic commands provided. RDGRS-2150 created as the improvement action.

#### ❌ Missing (2 questions)

**Q4: Was the Error Budget of a System-wide SLO affected?**
- ❌ **MISSING:** "System-wide impact: Yes" stated but no SLO or error budget data referenced.
- **Guiding questions for working session:**
  - Does a system-wide SLO cover the Ingestion API or GA ring availability? Was it breached?
  - Did the 1% failure rate register as an SLO event?
  - If no SLO covers this scenario, should one be defined?

**Q5: Was the Error Budget of a Service-specific SLO affected?**
- ❌ **MISSING:** No service-specific SLO data or error budget consumption mentioned.
- **Guiding questions for working session:**
  - Does the Ingestion API have a service-level SLO? What is the current error budget status?
  - Should circuit breaker and xDS sync health be added to SLO coverage?

---

### 📣 Pillar 2: Response & Communication (17/100)

**Score:** 0.5 / 3.0 points (Q3 scored N/A — denominator = 3)

#### ⚠️ Present but Weak (1 question)

**Q2: Was internal communication effective?**
- ⚠️ **WEAK:** Slack channel created automatically at declaration (1:16 PM). Zoom call organized. Status update at 1:33 PM. Teams swarmed (SRE, GRS, Data Platform). Internal Comms Leader assigned (Ambarish Kumar).
- **Issue:** Communication channels are documented but effectiveness is not assessed. The 53-minute window from GRS acknowledgment (12:16 PM) to SRE escalation (1:09 PM) — during which the issue was known to GRS — is not discussed.
- **Needs depth:** Was the GRS-to-SRE handoff timely? What was the communication flow before formal declaration?

#### ❌ Missing (2 questions)

**Q1: Was incident declaration timely?**
- ❌ **MISSING:** GRS alert at 12:15 PM WEST. GRS acknowledged at 12:16 PM. SRE not escalated until 1:09 PM — 53 minutes later. Incident formally declared at 1:16 PM. This 61-minute window from first signal to declaration is not analyzed.
- **Guiding questions for working session:**
  - Why was SRE not engaged for 53 minutes after GRS acknowledged?
  - Was GRS actively assessing system-wide impact during that window?
  - Is a 61-minute window from first signal to formal declaration acceptable for a SEV2 system-wide incident?

**Q4: Was MTTA (Mean Time to Acknowledge) adequate?**
- ❌ **MISSING:** MTTA not calculated or discussed. GRS acknowledged in 1 minute (12:15→12:16 PM); SRE acknowledged at 1:09 PM. Relevant MTTA baseline and acceptability not addressed.
- **Guiding questions for working session:**
  - What is the MTTA for this incident — from first Rootly alert or from system-wide declaration?
  - Was it within SEV2 response expectations?

#### 🚫 Not Applicable (1 question)

**Q3: Was external communication effective?**
- 🚫 **N/A:** Telemetry infrastructure incident with no direct end-user customer-facing impact. No status page entry published (confirmed). External communication not applicable.

---

### 🔍 Pillar 3: Troubleshooting & Root Cause (67/100)

**Score:** 2.0 / 3.0 points

#### ✅ Fully Addressed (1 question)

**Q1: Were troubleshooting steps effective?**
- ✅ **GOOD:** "Investigation shows that 1% of requests are returning HTTP 503 with Flag UO,UF. GRS reached out to Gloo Support, which indicated they suspect a circuit breaker limits issue. Following the investigation, team found one of the gateway-proxy service pods were returning the 503 errors, and decided to restart service pods."
- **Evidence:** Methodical troubleshooting documented: initial hypothesis tested and failed (RFC-4726), flags analyzed (UF/UO), external vendor consulted (Solo/Gloo), problem isolated to specific pod, targeted fix applied (RFC-4728 → resolved).

#### ⚠️ Present but Weak (2 questions)

**Q2: What is the technical root cause?**
- ⚠️ **WEAK:** "The most likely explanation... is that the pod had stale upstream endpoint information... This part is an informed technical hypothesis based on the findings you shared, rather than something conclusively proven during the incident." Retrospective explicitly states: "This hypothesis could not be fully confirmed during the incident because the relevant proxy state and control plane logs were not collected before restart."
- **Issue:** Root cause is explicitly unconfirmed. Prevention actions are built on an unverified hypothesis.
- **Needs depth:** What post-incident analysis is still possible? Can Solo/Gloo confirm retroactively? Is the hypothesis strong enough to drive prevention actions, or is a follow-up investigation needed?

**Q3: Are there architectural issues to address?**
- ⚠️ **WEAK:** "Review whether retry and circuit breaker behavior should be adjusted or better monitored to prevent a stale-routing issue from escalating into sustained request failures."
- **Issue:** Architectural concern identified (stale xDS endpoints, circuit breaker overflow) but not analyzed in depth. Whether this is a systemic risk or an isolated pod state issue is not determined.
- **Needs depth:** Is xDS desynchronization a known architectural risk in the current setup? What structural changes — beyond monitoring — would prevent this failure class?

---

### 🩹 Pillar 4: Recovery & Resolution (57/100)

**Score:** 4.0 / 7.0 points

#### ✅ Fully Addressed (3 questions)

**Q2: What was the primary method of mitigation?**
- ✅ **GOOD:** "The issue was resolved by restarting the affected gateway-proxy service pods through RFC-4728. After the restart, the HTTP 503 errors stopped, dropped records were no longer observed, and consumers confirmed that the issue was no longer happening."
- **Evidence:** RFC-4728 clearly documented. Recovery confirmed by multiple teams (Data Platform, Observability).

**Q6: Did dependencies or cascading failures significantly delay recovery?**
- ✅ **GOOD:** "Fluentbit reported dropped records, and exporter queues increased until the issue was mitigated. Later confirmation from consumers showed that dropped records had stopped and exporter queues had decreased."
- **Evidence:** Cascading effects on downstream consumers explicitly documented and tracked to resolution.

**Q7: Was customer impact quantified?**
- ✅ **GOOD:** "approximately 1% of incoming requests failing with HTTP 503 errors." Fluentbit dropped records and growing consumer queue sizes documented and confirmed resolved.
- **Evidence:** Impact quantified (1% failure rate), affected systems identified, recovery confirmed by multiple impacted consumers.

#### ⚠️ Present but Weak (2 questions)

**Q1: What was the recovery time (MTTR) and was it acceptable?**
- ⚠️ **WEAK:** Started: April 2, 1:17 PM WEST → Resolved: April 2, 3:19 PM WEST = approximately 2 hours 2 minutes. MTTR not explicitly calculated or labeled.
- **Issue:** SEV2 objective is <8h. Actual MTTR (~2h) is well within objective but not acknowledged. The initial failed mitigation (RFC-4726, ~55 min detour) is not assessed for its contribution to recovery time.
- **Needs depth:** State MTTR explicitly. Assess whether the wrong initial hypothesis materially delayed recovery.

**Q4: Are recovery blockers identified?**
- ⚠️ **WEAK:** The initial failed mitigation (RFC-4726) represents a ~55-minute diagnostic detour. Timeline: "Change executed and didn't fix the issue." Not explicitly framed as a blocker or analyzed.
- **Issue:** Why was the pod-scaling hypothesis formed? What led to the wrong initial diagnosis? No confidence or capability gap discussed.
- **Needs depth:** Was the wrong hypothesis a result of missing xDS monitoring, limited expertise, or insufficient diagnostic tooling?

#### ❌ Missing (2 questions)

**Q3: Was rollback considered as a recovery option?**
- ❌ **MISSING:** No explicit rollback evaluation for the gateway-proxy documented. A Slack message mentions a Data Platform application rollback ("we even did a rollback and is still healthy") but this was for the wrong component and not analyzed as a recovery decision.
- **Guiding questions for working session:**
  - Was rollback of the gateway-proxy evaluated before attempting pod scaling (RFC-4726)?
  - The incident response process mandates rollback-first assessment — was this step followed?
  - What would rollback have looked like for the gateway-proxy in this scenario?

**Q5: Were runbooks or documentation used and assessed?**
- ❌ **MISSING:** No mention of runbooks or operational playbooks consulted during the incident.
- **Guiding questions for working session:**
  - Does a runbook exist for gateway-proxy restarts or xDS desynchronization?
  - Would a runbook with the Envoy config dump commands have accelerated diagnosis?
  - Should runbook creation be added as an improvement action (complementing RDGRS-2150)?

---

### 🧠 Pillar 5: Prevention & Learning (50/100)

**Score:** 1.5 / 3.0 points (Q1 scored N/A — denominator = 3)

#### ✅ Fully Addressed (1 question)

**Q4: What learnings did the team gain?**
- ✅ **GOOD:** "If the issue happens again, before restarting the proxy, capture the Envoy config dump and Gloo control plane logs to confirm whether stale endpoints or xDS desynchronization are present." Specific diagnostic commands:
  ```
  # EDS dump to check for stale IPs
  curl -X POST 127.0.0.1:19000/config_dump?include_eds > gateway-config.json

  # Gloo control plane logs for xDS errors
  kubectl logs -n gloo-system deploy/gloo | grep -i "timed out|error|disconnect"
  ```
  Monitoring metrics: `glooe_solo_io_xds_insync` vs `glooe_solo_io_xds_total_entities`. Circuit breaker behavior review recommended.
- **Evidence:** Highly concrete and actionable learnings. Specific commands and metrics documented. Exemplary learnings section.

#### ⚠️ Present but Weak (1 question)

**Q3: Are prevention action items defined with clear ownership and tracking?**

**Jira Validation:**

| Ticket | Summary | Assignee | Due Date | RDINC Link | Status | Score |
|--------|---------|----------|----------|------------|--------|-------|
| RDGRS-2150 | Add xDS sync drift detection and circuit breaker overflow alerting for gateway-proxy | ❌ **Unassigned** | ❌ **null** | ❌ **No issuelinks** | To Do | ⚠️ |

- ⚠️ **WEAK:** RDGRS-2150 is the only improvement action for this incident, and all three mandatory fields are missing: no assignee, no due date, no RDINC link of type "reviews".
- **Issue:** An unowned, undated ticket with no incident traceability has no accountability or execution timeline. The strong Q4 learnings are undermined if the action item cannot be tracked to completion.
- **Needs depth:** Assign RDGRS-2150 to a specific engineer, set a due date, add RDINC-78158 "reviews" link. Consider whether additional actions are needed (runbook creation, root cause confirmation investigation, circuit breaker config review).

#### ❌ Missing (1 question)

**Q2: Was recurrence analysis performed?**
- ❌ **MISSING:** No analysis of similar prior gateway-proxy or xDS desynchronization incidents.
- **Guiding questions for working session:**
  - Has this failure pattern appeared before in GRS infrastructure?
  - If recurrence is identified, are there open action items from prior retrospectives that should have prevented this?

#### 🚫 Not Applicable (1 question)

**Q1: Was the incident caused by a recent change?**
- 🚫 **N/A:** Root cause hypothesis is stale xDS endpoint state — infrastructure drift, not triggered by a code deployment or configuration change. Excluded from denominator.

---

### ✅ Pillar 6: Process Compliance (75/100)

**Score:** 1.5 / 2.0 points (2 questions only — pre-assessment)

#### ✅ Fully Addressed (1 question)

**Q1: Did the incident management process work as expected?**
- ✅ **GOOD:** Luís Rocha (SRE) as Incident Commander — correct for Scenario 2 (system-wide impact). Slack channel created automatically. Jira created (RDINC-78158). Teams swarmed (SRE, GRS, Data Platform). Internal Comms Leader assigned (Ambarish Kumar, Data Platform). System-wide impact formally declared at 1:23 PM.
- **Evidence:** Timeline confirms all key process steps followed and verifiable.
- **Note:** The "Incident Roles" section in the retrospective document is empty — process was followed correctly but not captured in the designated structured field.

#### ⚠️ Present but Weak (1 question)

**Q2: If mitigation required an RFC, did it follow Change Management policy?**
- ⚠️ **WEAK:** Two RFCs used: RFC-4726 (scale ingestion pods 12→20, initial failed mitigation) and RFC-4728 (restart gateway-proxy pods, resolved). Both referenced in timeline and resolution. RFC compliance with Change Management policy is not explicitly assessed.
- **Issue:** RFC-4726 was raised during an active SEV2 (emergency RFC). Whether the emergency RFC process was followed is not confirmed.
- **Needs depth:** Explicitly confirm RFC-4726 and RFC-4728 followed the emergency RFC process.

---

## Prioritized Working Session Agenda

**Recommended focus for RCA working session (60-90 min):**

### 🔴 High Priority (Address First — 30 min)

1. **Root Cause Confirmation Status (Pillar 3 Q2)**
   - Current state: Explicitly unconfirmed hypothesis — "rather than something conclusively proven." Evidence lost at restart.
   - Why critical: Prevention actions built on unverified hypothesis may not prevent recurrence.
   - Guiding questions: What post-incident analysis is still possible? Can Solo/Gloo confirm retroactively? Is a follow-up investigation needed?

2. **Declaration Timing — GRS-to-SRE Gap (Pillar 2 Q1)**
   - Current state: 53-minute gap from GRS acknowledgment (12:16 PM) to SRE escalation (1:09 PM) — not analyzed.
   - Why critical: For a system-wide SEV2, this gap may represent a process or escalation criteria gap.
   - Guiding questions: Why was SRE not engaged for 53 minutes? Was GRS assessing system-wide impact? Should escalation thresholds be reviewed?

3. **RDGRS-2150 Mandatory Fields (Pillar 5 Q3)**
   - Current state: No assignee, no due date, no RDINC link — all three mandatory.
   - Why critical: Only prevention action for this incident is unowned and untracked. Can be fixed now, before working session.
   - **Action required (can do now):** Assign owner, set due date, add "reviews" link to RDINC-78158.

### 🟡 Medium Priority (Address Next — 20 min)

4. **MTTA Calculation (Pillar 2 Q4):** Calculate MTTA from Rootly data. Assess against SEV2 expectations.

5. **Rollback Decision Analysis (Pillar 4 Q3):** Was rollback evaluated for gateway-proxy before RFC-4726 scaling? Process mandates rollback-first assessment.

6. **Recurrence Check (Pillar 5 Q2):** Search for prior GRS incidents with similar gateway-proxy or xDS symptoms.

### 🟢 Lower Priority (If Time Permits — 10 min)

7. **MTTR Explicit Statement (Pillar 4 Q1):** State ~2h 2min MTTR explicitly. Note it is within SEV2 <8h objective.

8. **SLO / Error Budget Data (Pillar 1 Q4-Q5):** Add SLO impact data or note explicitly that no SLO covers this scenario.

9. **Documentation Cleanup:** Fill empty Roles section (Luís Rocha as IC, Ambarish Kumar as Internal Comms Leader). Confirm RFC-4726/4728 emergency change process compliance.

---

## Next Steps

### For the Retrospective Commander (Luís Rocha / SRE Team)

1. **Fix RDGRS-2150 now** — Assign owner, set due date, add RDINC-78158 "reviews" link. No working session needed for this.
2. **Pre-session data gathering:**
   - Check if retroactive xDS state analysis is possible (Gloo Support follow-up, control plane log retention)
   - Pull MTTA data from Rootly
   - Search for prior GRS incidents with gateway-proxy or xDS symptoms
   - Confirm RFC-4726 and RFC-4728 followed emergency Change Management process
3. **Fill Roles section** in the retrospective document.
4. **Schedule working session** — Invite SRE, GRS engineer(s), Data Platform representative, Process Engineering facilitator.

### For Working Session Facilitator (Process Eng)

- **Facilitation focus:** Root cause confirmation status; GRS-to-SRE declaration gap; RDGRS-2150 mandatory fields
- **Watch for:** Over-reliance on the unconfirmed stale xDS hypothesis — prevention actions must be robust even if the hypothesis cannot be confirmed retroactively
- **Success criteria:** Root cause section updated with confirmation status; declaration gap analyzed; RDGRS-2150 fields populated; MTTR explicitly stated

---

## Expected Outcome

**Target post-session:** >70% score (ready for VSL approval)
**Re-assessment:** Run post-assessment after VSL approval to measure final quality

---

**Generated by:** Koda Pre-Assessment Skill v2.0
**Framework Version:** RCA Framework v2.0 (6 pillars, 29 questions | Pre-Assessment: 26 questions)
**For questions:** Contact Process Engineering (Inês Matos, Vera Branco)
