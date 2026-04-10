# Retrospective Quality Assessment — RDINC-46603

---

## Overview

**Incident:** RDINC-46603 — Random error when publishing in ODC Studio and accessing roles in ODC Portal
**Retrospective:** [View retrospective](https://outsystemsrd.atlassian.net/wiki/spaces/RKB/pages/5246484554/Retrospective-SEV2-Random+error+when+publishing+in+ODC+Studio+and+acessing+roles+in+ODC+Portal)
**Severity:** SEV2
**MTTR:** ~8.5 hours (12:11 → 20:48 WEST)
**Assessment Date:** 2026-04-08

## Overall Score

🟡 **60/100**

**Status:** Needs Improvement — RCA Working Session Recommended

---

## Score Breakdown by Pillar

| Pillar | Score | Percentage | Status |
|--------|-------|------------|--------|
| 🕵️ **Detection** | 3/6 | 50% | 🟡 Needs Improvement |
| 🩹 **Troubleshooting & Recovery** | 5.5/8 | 69% | 🟡 Needs Improvement |
| 🧠 **Learning & Improvement** | 3.5/6 | 58% | 🟡 Needs Improvement |
| **TOTAL** | **12/20** | **60%** | 🟡 **Needs Improvement** |

---

### Pillar 1: Detection 🕵️ — 3/6 (50%)

🟡 **Needs Improvement**

| # | Question | Status | Notes |
|---|----------|--------|-------|
| 1 | How was the incident initially detected? | ✅ | Customer-reported via Zendesk (ticket 3206434). First customer report 09:29 CEST, first Gloo error log 10:45 CEST. Clear detection path documented. |
| 2 | Did detection happen before customer impact? | ❌ | Reactive, customer-detected. GRS has alerts for Gloo pod restarts but "they are not working properly" (RDGRS-1554). No proactive detection. |
| 3 | How effective was the alert's clarity/actionability? | ⚠️ | GRS Gloo restart alerts exist but documented as "not working properly." No analysis of alert clarity or actionability. |
| 4 | Was the Error Budget of a System-wide SLO affected? | ❌ | No mention of system-wide SLO impact or error budget consumption. |
| 5 | Was the Error Budget of a Service-specific SLO affected? | ⚠️ | States "SLOs for Gloo are not sys-wide and have no alerts" and "SLO for GA monitors proxy gateways which were always available." Mentioned but no quantification of error budget consumed. |
| 6 | What can be improved in detection? | ✅ | Multiple improvements identified: fix Gloo restart alerts (RDGRS-1554), add new SLOs for Gloo (RDPEN-1172), enable debug logs (cost estimation needed), investigate CloudFront monitoring for errors. Concrete detection improvements proposed. |

### Gaps to Address

**❌ Missing:**
1. **Detection timing (Q2):**
   - Why did customers report issues at 09:29 CEST but first Gloo error log wasn't until 10:45 CEST?
   - Were there earlier signals that existing alerts should have caught?
   - What would proactive detection look like for this type of Gloo issue?

2. **System-wide SLO impact (Q4):**
   - What was the error budget consumption for system-wide SLOs (e.g., 1CP success rate, ODC Portal availability)?
   - Were other SLOs affected beyond Gloo-specific metrics?
   - How does this incident affect overall SLO compliance?

**⚠️ Weak Analysis:**
1. **Alert effectiveness (Q3):**
   - Why are Gloo restart alerts "not working properly"?
   - What needs to be fixed to make them actionable?
   - Would the alerts have caught this issue if they were working?
   - Should alert thresholds or routing be adjusted?

2. **Service-specific SLO impact (Q5):**
   - Quantify the error budget consumed for Gloo or proxy gateway SLOs
   - What percentage of requests failed during the 8.5-hour incident?
   - Link to SLO dashboards showing impact over the incident duration

---

### Pillar 2: Troubleshooting and Recovery 🩹 — 5.5/8 (69%)

🟡 **Needs Improvement**

| # | Question | Status | Notes |
|---|----------|--------|-------|
| 1 | Was MTTR adequate? | ⚠️ | MTTR ~8.5h (12:11 → 20:48 WEST). Timeline documented but no analysis of adequacy or comparison to targets for SEV2 system-wide incidents. |
| 2 | Were troubleshooting steps effective? | ✅ | Effective: multiple teams involved (ODC Governance, GRS, Portals, Identity Business, Gloo Support), traced from Studio/Portal errors → CF 503s → Gloo pod leader election loop. Detailed investigation documented. |
| 3 | What slowed down recovery? | ✅ | Clearly documented: difficulty interpreting logs, Gloo doesn't generate error codes (led teams to suspect services not Gloo), 403 errors in CloudFront not appearing in Gloo logs, multiple team handoffs needed before finding root issue, WARN log level in Gloo not useful. |
| 4 | What was the primary method of mitigation? | ✅ | Immediate: Delete Gloo lease, restart Gloo pod (RFC-3187). Long-term: Disable leader election since only one Gloo pod running (RDGRS-1555), enable debug logs. Clear mitigation documented. |
| 5 | Did the incident management process work? | ⚠️ | Multiple IC handoffs (Rúben Nunes Capitão → Juan de Miguel Hernandez → Sam Audu), multiple team swarming (ODC Governance, GRS, Portals, Identity Business, Gloo Support), but no analysis of process effectiveness. 4h communication gap identified (RDPEN-1368). |
| 6 | Was communication effective? | ⚠️ | Critical gap documented: "Why GS was not notified the INC was declared system-wide?" - ~4h gap in communication (SRE team auto-removed, affecting status page updates). Investigation tracked in RDPEN-1368. No broader communication effectiveness analysis. |
| 7 | Were runbooks or documentation used? Were they accurate? | ✅ | Explicitly documented: "Runbook Evaluation: Non-existent." Clear acknowledgment of gap. |
| 8 | Did dependencies or cascading failures delay recovery? | ✅ | Yes, clearly documented: multiple services initially suspected (Identity, Portals), required coordination with Gloo Support team for resolution, logs from multiple sources (Studio, CF, Gloo) needed correlation. |

### Gaps to Address

**⚠️ Weak Analysis:**
1. **MTTR adequacy (Q1):**
   - Is 8.5h acceptable for SEV2 system-wide publishing/portal access impact?
   - What is the target MTTR for this severity?
   - How does this compare to historical MTTR for similar Gloo incidents?
   - Could earlier CloudFront log analysis have reduced MTTR?

2. **Incident management process (Q5):**
   - How effective were the 3 IC handoffs during the incident?
   - Did multiple team swarming help or hinder resolution?
   - Was escalation appropriate and timely?
   - What process improvements would help similar investigations?

3. **Communication effectiveness (Q6):**
   - Beyond the 4h GS notification gap, how were customers communicated with?
   - Were status updates timely during the 8.5h incident?
   - Was internal communication adequate across multiple swarmed teams?
   - What communication improvements are needed?

---

### Pillar 3: Learning & Improvement 🧠 — 3.5/6 (58%)

🟡 **Needs Improvement**

| # | Question | Status | Notes |
|---|----------|--------|-------|
| 1 | Is the technical root cause clear? | ⚠️ | **CRITICAL GAP:** Document explicitly states "we do not know what is the cause of the problem, if it is to happen again as we are now, we will still be in the same situation." Gloo pod stuck in leader election loop identified as symptom, but WHY this happened in GA eu-central-1 specifically remains unknown. "The reason is unknown, it is also happening on other clusters but it is not affecting customers." |
| 2 | Are there architectural issues to address? | ✅ | Multiple architectural issues identified: single Gloo pod with leader election enabled (unnecessary), SLO gaps (not system-wide, no alerts), Gloo restart alert issues, log interpretation challenges (Gloo doesn't generate error codes), WARN log level insufficient for troubleshooting. |
| 3 | Was the incident caused by a recent change? | ❌ | No recent change identified. Document does not link incident to any deployment, configuration change, or code change. |
| 4 | What action items prevent recurrence? | ✅ | Multiple specific action items: RDGRS-1555 (disable leader election - note: "not identified as root cause"), RDGRS-1554 (fix Gloo restart alerts), RDPEN-1172 (add new Gloo SLOs), RDPEN-1368 (fix GS notification gap), enable debug logs for observability, investigate CloudFront monitoring. Concrete items with Jira tracking. |
| 5 | Were follow-up actions immediately owned and tracked? | ⚠️ | RDGRS and RDPEN tickets mentioned with some tracking, but ownership for debug logs cost estimation and CloudFront monitoring investigation unclear. Some tracking but incomplete. |
| 6 | Did the team gain a significant new insight? | ✅ | Multiple valuable insights: Gloo pod restarts may be due to leader election issues not just OoM, leader election unnecessary with single pod, SLO gaps exist for Gloo, log interpretation challenges (errors in CF but not Gloo logs), proxy gateways can remain functional despite Gloo pod issues. |

### Gaps to Address

**❌ Missing:**
1. **Recent change identification (Q3):**
   - Was there a deployment, configuration change, or infrastructure change around July 14?
   - Was there a Gloo version update recently?
   - Was there any change to leader election configuration?
   - Understanding the trigger is critical for prevention

**⚠️ Weak Analysis:**
1. **Root cause clarity (Q1):**
   - **CRITICAL:** Document acknowledges root cause unknown - "we do not know what is the cause of the problem"
   - Why did leader election loop occur specifically in GA eu-central-1?
   - Why at that specific time (July 14)?
   - Why does it happen in other clusters without customer impact?
   - Is disabling leader election addressing root cause or just symptoms?
   - Next steps documented: "identify the user core journey and where the problem and logs may be available," contact ALM Consoles about error message

2. **Action item ownership (Q5):**
   - Who owns the debug logs cost estimation?
   - Who owns the CloudFront monitoring investigation?
   - What are the timelines for these actions?
   - How will completion be verified?

---

## Summary

### Strengths

**Transparent acknowledgment of gaps:**
- Document explicitly states root cause is unknown: "we do not know what is the cause of the problem"
- Honest assessment that "if it is to happen again as we are now, we will still be in the same situation"
- Clear documentation of what is known vs unknown

**Excellent troubleshooting documentation:**
- Detailed timeline with multiple team involvement
- Clear investigation path from symptoms (Studio/Portal errors) to Gloo pod leader election loop
- Challenges honestly documented (log interpretation difficulties, Gloo error code gaps)
- Collaboration across 5+ teams documented

**Strong action items and insights:**
- Multiple concrete improvements (disable leader election, fix alerts, add SLOs, fix communication gap)
- Valuable insight that Gloo restarts may be leader election issues not just OoM
- Architectural gaps clearly identified (SLO coverage, alert effectiveness, log observability)

### Key Gaps

**Root Cause Understanding:**
- **CRITICAL GAP:** Root cause unknown - document explicitly acknowledges this
- WHY leader election loop occurred specifically in GA eu-central-1 on July 14 remains unanswered
- No recent change identified that could have triggered the issue
- Mitigation (disable leader election) addresses symptoms not root cause
- Risk of recurrence remains without deeper root cause analysis

**Detection & Monitoring:**
- No SLO error budget quantification (system-wide or service-specific)
- Gloo restart alerts exist but "not working properly" - not analyzed in depth
- Reactive, customer-detected incident with no proactive detection

**Process & Communication:**
- MTTR adequacy not assessed (8.5h for SEV2 system-wide)
- Communication gap (4h GS notification delay) but broader communication not assessed
- Incident management process not evaluated despite 3 IC handoffs and 5+ team swarming
- Effectiveness of multi-team investigation not analyzed

---

## Recommended Actions

**Ready for RCA Working Session?** 🟡 **Yes, CRITICAL focus on Root Cause Analysis**

The retrospective has honest acknowledgment of gaps and good troubleshooting documentation, but explicitly states the root cause is unknown. All three pillars score between 50-69%, with the critical gap being incomplete root cause analysis.

An RCA working session is **ESSENTIAL** to:
- Investigate WHY leader election loop occurred (not just that it occurred)
- Identify any triggering change or condition
- Determine if mitigation (disable leader election) is sufficient or just symptom treatment

### RCA Working Session Plan

**Objective:** **PRIORITY: Complete root cause analysis** — investigate WHY Gloo leader election loop occurred in GA eu-central-1 on July 14. Secondary: quantify SLO impact and assess MTTR adequacy.

**Session Duration:** 75 minutes (extended due to incomplete root cause analysis)

**Who Should Attend:**
- Retrospective Commander (EM/TL)
- Incident Commander (Sam Audu)
- GRS team representative
- Gloo Support representative
- SRE representative
- ODC Governance representative
- Process Engineering (facilitator)

**Session Agenda:**

#### Part 1: Root Cause Analysis (45 minutes) — 🔴 CRITICAL PRIORITY

**CRITICAL:** Document states "we do not know what is the cause of the problem." This must be addressed.

1. **WHY did leader election loop occur? (P3-Q1, Q3):**
   - Investigate Gloo pod logs, Kubernetes events, etcd logs from July 14
   - Was there a Gloo version change, configuration change, or infrastructure change?
   - Why specifically GA eu-central-1 and not other regions?
   - Why at that specific time (July 14, starting ~10:45am CEST)?
   - Document states it also happens in other clusters "but it is not affecting customers" - investigate why
   - Is disabling leader election addressing root cause or just symptoms?
   - What evidence is needed to definitively identify root cause?

2. **Triggering Change Analysis (P3-Q3):**
   - Review all changes to Gloo, Kubernetes, networking, or infrastructure in days before July 14
   - Check Gloo version deployments across rings/regions
   - Review Kubernetes cluster events for eu-central-1
   - Check for any network or infrastructure changes

3. **Next Steps for Root Cause Investigation:**
   - Document acknowledges next step: "identify the user core journey and where the problem and logs may be available"
   - Status on contacting ALM Consoles about error message?
   - What additional investigation is planned?
   - Timeline for completing root cause analysis?

#### Part 2: Detection & SLO Impact (20 minutes) — 🟡 SECONDARY

1. **SLO Impact Quantification (P1-Q4, Q5):**
   - What was the error budget consumed for 1CP, ODC Portal, or publishing SLOs?
   - Quantify percentage of failed publishes/portal requests during 8.5 hours
   - How does this incident affect Q3 SLO compliance?
   - Document why Gloo SLO (monitoring proxy gateways) did not catch this

2. **Alert Effectiveness (P1-Q2, Q3):**
   - Why are Gloo restart alerts "not working properly"?
   - What needs to be fixed in RDGRS-1554?
   - Would functional alerts have enabled proactive detection?
   - Timeline for alert fixes?

3. **Detection Timing Gap (P1-Q2):**
   - Why did customers report at 09:29 CEST but first Gloo error log at 10:45 CEST?
   - Were there earlier signals that should have been detected?

#### Part 3: Process & Tracking (10 minutes) — 🟡 TERTIARY

1. **MTTR Assessment (P2-Q1):**
   - Is 8.5h acceptable for SEV2 system-wide publishing/portal access impact?
   - Target MTTR for this severity?
   - Could earlier CloudFront analysis have reduced MTTR?

2. **Incident Management (P2-Q5, Q6):**
   - How effective were 3 IC handoffs?
   - Did 5+ team swarming help or hinder?
   - Beyond 4h GS gap, was customer/internal communication adequate?

3. **Action Item Ownership (P3-Q5):**
   - Who owns debug logs cost estimation?
   - Who owns CloudFront monitoring investigation?
   - Timelines for all action items?

#### Part 4: Wrap-Up (5 minutes)

- Document root cause findings (or plan for continued investigation)
- Assign owners to all action items with timelines
- Schedule follow-up session if root cause investigation incomplete

**Before the Session:**
- Pull Gloo pod logs, Kubernetes events, etcd logs from July 13-14
- Review all Gloo and infrastructure changes in week before July 14
- Pull SLO dashboard data showing 1CP/Portal impact on July 14
- Check status of ALM Consoles contact (re: error message investigation)
- Gather Gloo version deployment history across rings/regions

**After the Session:**
- Update retrospective document with root cause findings
- Create Jira tickets for any additional investigation needed
- Assign owners to all action items with clear timelines
- Re-run assessment to measure improvement (target: >70%)
- **CRITICAL:** If root cause still unknown, schedule follow-up RCA session with timeline

---

## Assessment Methodology

This assessment uses **objective evaluation** against the **RCA Framework** (3 pillars, 20 questions).

**Scoring Criteria:**
- ✅ **Fully addressed (1 point)** — Question explicitly answered with depth, evidence, and analysis
- ⚠️ **Present but weak (0.5 points)** — Mentioned but lacks depth or analysis
- ❌ **Missing (0 points)** — Not addressed in the document

**Example:**
- "MTTR was 8.5h" = ⚠️ (data present but no analysis)
- "MTTR was 8.5h, which is acceptable given multi-team investigation complexity" = ✅ (data + analysis)
- No MTTR mentioned = ❌

---

## Scoring Logic

**Pillar Breakdown:**
- Pillar 1 (Detection): 3/6 = 50%
- Pillar 2 (Troubleshooting & Recovery): 5.5/8 = 69%
- Pillar 3 (Learning & Improvement): 3.5/6 = 58%

**Overall Score:** 12/20 = 60% (60/100)

**Quality Thresholds:**
- **70%+** 🟢 Good quality, ready for approval
- **40-70%** 🟡 Needs improvement, RCA working session recommended ← **Current Status**
- **<40%** 🔴 Significant gaps, requires substantial work

---

**Assessment Details:**
- **Date:** 2026-04-08
- **Framework:** RCA Quality Framework v1.0 (3 Pillars, 20 Questions)
- **Method:** Objective evaluation — scored based on what is written in the retrospective document
- **Assessed by:** Process Engineering (Automated RCA Quality Skill)
- **Critical Note:** Document explicitly acknowledges root cause is unknown - RCA working session is ESSENTIAL to complete root cause analysis
