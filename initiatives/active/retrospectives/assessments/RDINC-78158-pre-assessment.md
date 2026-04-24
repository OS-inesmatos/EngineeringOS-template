# Retrospective Pre-Assessment — RDINC-78158

**Incident:** SEV2 - Few requests failing on ingestion API with 503 errors on datap-ga-us-east-1-01
**Assessment Date:** 2026-04-24
**Assessed By:** Koda Pre-Assessment Skill v2.0
**Document:** https://outsystemsrd.atlassian.net/wiki/spaces/RKB/pages/6161990125/

---

## Overall Quality Score: **48/100** 🟡

**Status:** Needs significant work before working session
**Recommendation:** Root cause analysis incomplete (hypothesis not confirmed), missing critical process assessments (MTTA, external comms, RFC compliance), weak action items. Requires substantial strengthening across multiple pillars before VSL approval.

---

## Score Breakdown by Pillar

| Pillar | Score | Status | Summary |
|--------|-------|--------|---------|
| 🕵️ Detection & Monitoring | 50/100 | 🟡 | Detection method partially identified but customer-detected; no alert analysis |
| 📣 Response & Communication | 13/100 | 🔴 | Incident declaration timing unclear; MTTA, external comms, internal comms all missing |
| 🔍 Troubleshooting & Root Cause | 50/100 | 🟡 | Root cause is hypothesis, not confirmed with evidence; troubleshooting documented |
| 🩹 Recovery & Resolution | 50/100 | 🟡 | MTTR documented but no acceptability analysis; rollback not considered; blockers weak |
| 🧠 Prevention & Learning | 50/100 | 🟡 | Change correlation absent; action item present but vague; recurrence analysis missing |
| ✅ Process Compliance | 50/100 | 🟡 | RFC usage documented but compliance not evaluated (2 questions only) |

**Overall Pre-Assessment:** 10.0/26 questions fully addressed

---

### 🕵️ Pillar 1: Detection & Monitoring (50/100)

**Score:** 3.0 / 6.0 points

#### ✅ Fully Addressed (2 questions)

**Q1: How was the incident initially detected?**
- ✅ **GOOD:** "It was reported in Data Platform public channel on slack, that the requests from CMCP are failing"
- **Evidence:** Detection method clearly documented (Slack report from Data Platform team)

**Q6: What can be improved in detection?**
- ✅ **GOOD:** "Improve monitoring and alerting for this failure scenario, specifically around xDS endpoint synchronization health and circuit breaker overflow conditions, since the incident was detected only through downstream symptoms rather than at the source."
- **Evidence:** Specific detection improvement identified with technical details (xDS monitoring, circuit breaker alerting)

#### ⚠️ Present but Weak (1 question)

**Q2: Was the incident detected before customer impact?**
- ⚠️ **WEAK:** Mentions "Data Platform reported" and "1% of requests failing" but no explicit statement about whether this was proactive or reactive
- **Issue:** Unclear whether Data Platform detected the issue via monitoring or customer reports
- **Needs depth:** Was this detected by internal monitoring before customers reported issues, or did customers experience failures before internal detection?

#### ❌ Missing (3 questions)

**Q3: Were alerts clear and actionable?**
- ❌ **MISSING:** No assessment of whether alerts (if any) provided clear guidance for troubleshooting
- **Guiding questions for working session:**
  - Were there any automated alerts for the 503 errors?
  - Did alerts guide responders to the right component (gateway-proxy)?
  - What alert improvements would have accelerated root cause identification?

**Q4: Was the Error Budget of a System-wide SLO affected?**
- ❌ **MISSING:** No mention of system-wide SLO impact or error budget consumption
- **Guiding questions for working session:**
  - Were system-wide SLOs affected by the 503 errors?
  - How much error budget was consumed?
  - Did SLO alerts fire?

**Q5: Was the Error Budget of a Service-specific SLO affected?**
- ❌ **MISSING:** No mention of Ingestion API service-specific SLO impact
- **Guiding questions for working session:**
  - Were Ingestion API service SLOs affected?
  - Were gateway-proxy service SLOs affected?
  - How does the 1% failure rate compare to SLO targets?

---

### 📣 Pillar 2: Response & Communication (13/100)

**Score:** 0.5 / 4.0 points

#### ⚠️ Present but Weak (1 question)

**Q1: Was incident declaration timely?**
- ⚠️ **WEAK:** "Started At: April 2 1:17 PM WEST" mentioned but no analysis of when the issue was first detected vs when incident was declared
- **Issue:** No assessment of declaration timing or delays
- **Needs depth:** When was the Data Platform Slack report posted? How long between detection and formal incident declaration? Was escalation appropriate?

#### ❌ Missing (3 questions)

**Q2: Was internal communication effective?**
- ❌ **MISSING:** No assessment of internal communication quality during incident response
- **Guiding questions for working session:**
  - Was the incident channel active and focused?
  - Were updates to leadership timely?
  - Did cross-team coordination work effectively (Data Platform, GRS, SRE)?

**Q3: Was external communication effective?**
- ❌ **MISSING:** No mention of customer-facing communication or status page updates
- **Guiding questions for working session:**
  - Was the public status page updated?
  - Were affected customers notified?
  - What was the Public MTTA?
  - Were customer-facing updates clear about impact scope (1% of requests)?

**Q4: Was MTTA (Mean Time to Acknowledge) adequate?**
- ❌ **MISSING:** No MTTA calculation or analysis
- **Guiding questions for working session:**
  - What was the MTTA (time from Slack report to acknowledgment)?
  - Was it within acceptable range for SEV2?
  - How does it compare to historical MTTA?

---

### 🔍 Pillar 3: Troubleshooting & Root Cause (50/100)

**Score:** 1.5 / 3.0 points

#### ✅ Fully Addressed (1 question)

**Q1: Were troubleshooting steps effective?**
- ✅ **GOOD:** "An initial mitigation was attempted by scaling the ingestion API pods from 12 to 20... This did not fix the issue... Subsequent investigation showed 1% of requests failing with UF and UO flags... the team identified that one gateway-proxy service pod was returning the HTTP 503 errors"
- **Evidence:** Troubleshooting progression documented from symptom analysis to isolation of affected component

#### ⚠️ Present but Weak (2 questions)

**Q2: What is the technical root cause?**
- ⚠️ **WEAK:** "The most likely explanation, based on the investigation and feedback from Solo, is that the pod had stale upstream endpoint information... This part is an informed technical hypothesis based on the findings you shared, rather than something conclusively proven during the incident."
- **Issue:** Root cause is explicitly stated as unconfirmed hypothesis, not evidence-based fact
- **Needs depth:** The retrospective acknowledges this gap: "The proxy state and Gloo control plane logs needed to validate stale endpoints / xDS desynchronization were not collected before the proxy restart." Without evidence (Envoy config dump, control plane logs), root cause analysis is incomplete. This is a critical gap for a retrospective—root cause should be confirmed with evidence, not speculation.

**Q3: Are there architectural issues to address?**
- ⚠️ **WEAK:** Implicit architectural issue (xDS endpoint synchronization vulnerability) but not explicitly called out as an architectural concern
- **Issue:** No explicit analysis of whether this is a systemic architectural issue vs one-off failure
- **Needs depth:** Is xDS desynchronization a known issue in the Gloo/Envoy architecture? Are there design patterns that would make this failure mode impossible or easier to detect? Should gateway-proxy endpoint refresh logic be reviewed?

---

### 🩹 Pillar 4: Recovery & Resolution (50/100)

**Score:** 3.5 / 7.0 points

#### ✅ Fully Addressed (2 questions)

**Q2: What was the primary method of mitigation?**
- ✅ **GOOD:** "The issue was resolved by restarting the affected gateway-proxy service pods through RFC-4728"
- **Evidence:** Mitigation method clearly documented (service restart via RFC)

**Q7: Was customer impact quantified?**
- ✅ **GOOD:** "approximately 1% of incoming requests failing with HTTP 503 errors" and "system-wide within the affected environment, but limited to the GA ring in us-east-1"
- **Evidence:** Impact quantified with percentage and scope (ring/region)

#### ⚠️ Present but Weak (4 questions)

**Q1: What was the recovery time (MTTR) and was it acceptable?**
- ⚠️ **WEAK:** "Started At: April 2 1:17 PM WEST, Mitigated At: April 2 3:19 PM WEST" = 2h 2min MTTR
- **Issue:** MTTR documented but no analysis of acceptability given severity, complexity, or blockers
- **Needs depth:** Was 2 hours acceptable for a partial degradation (1% failure rate) in SEV2? How does this compare to historical MTTR for similar incidents?

**Q4: Are recovery blockers identified? Did the team lack confidence or capability?**
- ⚠️ **WEAK:** Initial mitigation (scaling pods) failed, suggesting troubleshooting delay, but not explicitly analyzed as a blocker
- **Issue:** No explicit analysis of what slowed recovery
- **Needs depth:** Why did the team first try scaling pods instead of investigating gateway-proxy? Was there missing visibility into gateway-proxy health? Did the team lack tools or runbooks for diagnosing Envoy circuit breaker issues?

**Q5: Were runbooks or documentation used and assessed?**
- ⚠️ **WEAK:** Retrospective includes runbook-style commands for future incidents but no mention of whether existing runbooks were used
- **Issue:** No evidence that runbooks were consulted during recovery
- **Needs depth:** Did runbooks exist for gateway-proxy troubleshooting? Were they used? If not, should they be created or updated?

**Q6: Did dependencies or cascading failures significantly delay recovery?**
- ⚠️ **WEAK:** Mentions "Gloo Support" consultation and "feedback from Solo" but impact on recovery timeline not analyzed
- **Issue:** Dependency on vendor (Solo/Gloo) documented but delay not assessed
- **Needs depth:** How much time was spent waiting for Gloo Support input? Did this delay recovery?

#### ❌ Missing (1 question)

**Q3: Was rollback considered as a recovery option?**
- ❌ **MISSING:** No mention of whether rollback was evaluated as a recovery path
- **Guiding questions for working session:**
  - Was rollback of any recent gateway-proxy or Gloo control plane change considered?
  - Were there recent changes to gateway-proxy configuration that could have been reverted?
  - Why was service restart chosen over rollback?

---

### 🧠 Pillar 5: Prevention & Learning (50/100)

**Score:** 2.0 / 4.0 points

#### ✅ Fully Addressed (1 question)

**Q4: What learnings did the team gain?**
- ✅ **GOOD:** "If the issue happens again, before restarting the proxy, capture the Envoy config dump and Gloo control plane logs to confirm whether stale endpoints or xDS desynchronization are present" (includes specific commands)
- **Evidence:** Clear learning about preserving diagnostic evidence before mitigation

#### ⚠️ Present but Weak (1 question)

**Q3: Are prevention action items defined with clear ownership and tracking?**
- ⚠️ **WEAK:** "Improve monitoring and alerting for this failure scenario, specifically around xDS endpoint synchronization health and circuit breaker overflow conditions" — RDGRS-2150
- **Issue:** Action item is vague and lacks measurable acceptance criteria
- **Needs depth:** 
  - What specific metrics will be monitored (glooe_solo_io_xds_insync, glooe_solo_io_xds_total_entities)?
  - What alert thresholds will be configured?
  - What runbook will the alert link to?
  - What is the completion timeline?
  - Who is the owner beyond "GRS"?

#### ❌ Missing (2 questions)

**Q1: Was the incident caused by a recent change?**
- ❌ **MISSING:** No analysis of whether a recent deployment or configuration change triggered the stale endpoint condition
- **Guiding questions for working session:**
  - Were there recent changes to gateway-proxy, Gloo control plane, or Ingestion API pods?
  - Was there a recent Kubernetes node or network event that could have caused endpoint staleness?
  - What is the Change Failure Rate correlation?

**Q2: Was recurrence analysis performed?**
- ❌ **MISSING:** No check for whether similar gateway-proxy or xDS synchronization issues occurred in the past
- **Guiding questions for working session:**
  - Have there been previous incidents with gateway-proxy 503 errors?
  - Have there been previous incidents with xDS endpoint staleness?
  - Were action items from those incidents completed?

---

### ✅ Pillar 6: Process Compliance (50/100)

**Score:** 1.0 / 2.0 points (pre-assessment evaluates Q1-Q2 only)

#### ✅ Fully Addressed (1 question)

**Q2: If the mitigation required a change (RFC), did it follow Change Management policy?**
- ✅ **GOOD:** "Executed RFC-4726 to scale the Ingestion API pods" and "Executed RFC-4728 to restart the affected gateway-proxy service pods"
- **Evidence:** Emergency RFCs documented for both mitigation attempts

#### ⚠️ Present but Weak (1 question)

**Q1: Was incident management process followed?**
- ⚠️ **WEAK:** Incident roles documented (Engineer: Shivam Kumar, Internal Comms Leader: Ambarish Kumar) but no assessment of process effectiveness
- **Issue:** No analysis of whether roles were assigned effectively, whether IC was effective, or whether escalation was appropriate
- **Needs depth:** Were roles assigned promptly? Was the Incident Commander effective in coordinating cross-team efforts (Data Platform, GRS, SRE)? Was escalation to GRS leadership appropriate given the 1% failure rate?

---

## Prioritized Working Session Agenda

**Recommended focus for RCA working session (60-90 min):**

### 🔴 High Priority (Address First — 40 min)

1. **Root Cause Hypothesis Not Confirmed (Pillar 3, Q2)**
   - Current state: Root cause explicitly stated as unconfirmed hypothesis ("informed technical hypothesis... rather than something conclusively proven")
   - Why critical: A retrospective cannot be approved with an unconfirmed root cause. This is the most critical gap.
   - Guiding questions:
     - Can Envoy config dumps or Gloo control plane logs be retrieved from the incident timeframe?
     - Can the hypothesis be confirmed through historical metrics (xDS sync metrics, circuit breaker metrics)?
     - If evidence cannot be recovered, should the root cause be reframed as "Unknown — stale endpoints suspected but not confirmed"?
     - What post-incident testing can be done to validate the hypothesis?

2. **Missing Change Correlation Analysis (Pillar 5, Q1)**
   - Current state: No analysis of whether a recent change triggered the issue
   - Why critical: If a change caused this, it's a Change Failure Rate incident requiring deployment process improvements
   - Guiding questions:
     - Were there recent changes to gateway-proxy, Gloo control plane, Ingestion API, or Kubernetes cluster?
     - Was there a node drain, pod eviction, or network event before the incident?
     - Does the Pegasus deployment timeline show any relevant changes?

3. **Vague Prevention Action Item (Pillar 5, Q3)**
   - Current state: "Improve monitoring and alerting" without measurable acceptance criteria
   - Why critical: Without specificity, action item completion cannot be verified
   - Guiding questions:
     - What specific xDS sync metrics will be monitored?
     - What alert thresholds trigger incident escalation?
     - What runbook will be linked to the alert?
     - What is the completion deadline and who is the individual owner (not just "GRS")?

### 🟡 Medium Priority (Address Next — 30 min)

4. **External Communication Assessment Missing (Pillar 2, Q3)**
   - Current state: No mention of customer-facing communication
   - Guiding questions:
     - Was the public status page updated?
     - Were customers proactively notified about the 1% request failure rate?
     - What was the Public MTTA?

5. **MTTA Not Assessed (Pillar 2, Q4)**
   - Current state: No MTTA calculation or analysis
   - Guiding questions:
     - What was the MTTA (Slack report timestamp to acknowledgment timestamp)?
     - Was it acceptable for SEV2?

6. **Recurrence Analysis Missing (Pillar 5, Q2)**
   - Current state: No check for similar past incidents
   - Guiding questions:
     - Have there been previous gateway-proxy 503 incidents?
     - Have there been previous xDS desynchronization incidents?
     - Were previous action items completed?

7. **MTTR Acceptability Not Assessed (Pillar 4, Q1)**
   - Current state: 2h 2min MTTR documented but no acceptability analysis
   - Guiding questions:
     - Was 2 hours acceptable given 1% failure rate and SEV2 severity?
     - What caused the delay (initial failed mitigation attempt)?
     - How does this compare to historical MTTR?

### 🟢 Lower Priority (If Time Permits — 20 min)

8. **Rollback Not Considered (Pillar 4, Q3)**
   - Current state: No mention of rollback evaluation
   - Guiding questions:
     - Was rollback of recent changes considered?
     - Why was service restart chosen over rollback?

9. **SLO Impact Analysis Missing (Pillar 1, Q4-Q5)**
   - Current state: No mention of SLO impact or error budget
   - Guiding questions:
     - Were Ingestion API SLOs affected?
     - Were gateway-proxy SLOs affected?
     - How much error budget was consumed?

10. **Alert Quality Assessment Missing (Pillar 1, Q3)**
    - Current state: No evaluation of whether alerts were clear and actionable
    - Guiding questions:
      - Were there automated alerts for the 503 errors?
      - Did alerts guide responders to gateway-proxy component?

---

## Next Steps

### For the Retrospective Commander (EM/TL)

1. **Review this assessment** — Focus on 🔴 High Priority gaps (unconfirmed root cause, missing change analysis, vague action items)
2. **Gather additional data** before working session:
   - Attempt to retrieve Envoy config dumps or Gloo control plane logs from incident timeframe
   - Pull deployment timeline from Pegasus for gateway-proxy, Gloo, Ingestion API (March 25 - April 2)
   - Calculate MTTA (Slack report timestamp to incident acknowledgment timestamp)
   - Check for previous incidents with "gateway-proxy 503" or "xDS desynchronization"
3. **Schedule working session** — Coordinate with Process Eng and invite:
   - Incident Commander (Shivam Kumar)
   - GRS representative — for root cause validation and action item specificity
   - Data Platform representative — for detection timeline and external comms
4. **Pre-session prep:**
   - If root cause evidence cannot be recovered, prepare to reframe root cause as "Unknown — suspected stale endpoints but not confirmed due to lost diagnostic state"
   - Identify specific owner for RDGRS-2150 action item

### For Working Session Facilitator (Process Eng)

- **Facilitation focus:** 
  1. Root cause confirmation or explicit acknowledgment that it remains unconfirmed (Pillar 3, Q2)
  2. Change correlation analysis (Pillar 5, Q1)
  3. Action item specificity with measurable acceptance criteria (Pillar 5, Q3)
- **Watch for:** 
  - Defensive justifications for unconfirmed root cause
  - Action items that sound specific but lack measurable acceptance criteria
  - Confusion about when root cause can be stated as "Unknown"
- **Success criteria:** 
  - Root cause either confirmed with evidence OR reframed as "Unknown"
  - Change analysis documented
  - Action item has specific metrics, thresholds, owner, and deadline
  - Improve score by >20 points (target: 70+)

---

## Expected Outcome

**Target post-session:** >70% score (ready for VSL approval)
**Re-assessment:** Run post-assessment after VSL approval to measure final quality

---

**Generated by:** Koda Pre-Assessment Skill v2.0
**Framework Version:** RCA Framework v2.0 (6 pillars, 29 questions | Pre-Assessment: 26 questions)
**For questions:** Contact Process Engineering (Inês Matos, Vera Branco)
