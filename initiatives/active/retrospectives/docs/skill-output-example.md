# Retrospective Quality Assessment — Example Output

**Incident:** RDINC-12345 — Database Connection Pool Exhaustion
**Assessment Date:** 2026-04-06
**Assessed By:** Koda RCA Quality Skill
**Document URL:** [Confluence Retrospective Document](https://example.com/retro-doc)

---

## Overall Quality Score: **62/100** ⚠️

**Status:** Ready for working session — significant gaps identified
**Recommendation:** Schedule RCA working session to address missing and weak areas

---

## Score Breakdown by Pillar

| Pillar | Score | Status | Summary |
|--------|-------|--------|---------|
| 🕵️ **Detection** | 75/100 | ⚠️ Good | Detection method documented, but SLO impact analysis missing |
| 🩹 **Troubleshooting & Recovery** | 55/100 | ⚠️ Needs Work | MTTR documented but weak analysis of what slowed recovery |
| 🧠 **Learning & Improvement** | 50/100 | ❌ Critical Gaps | Root cause too surface-level, action items lack ownership |

---

## Detailed Assessment

### 🕵️ Pillar 1: Detection (75/100)

#### ✅ Fully Addressed (3 questions)

**1. How was the incident initially detected?**
- ✅ **GOOD:** "Incident detected by automated alert from Datadog monitoring: `database.connections.active > 95% for 5 minutes`"
- Evidence: Clear detection method documented with specific alert rule

**2. Did the detection happen before customer impact?**
- ✅ **GOOD:** "Alert fired 2 minutes before customer-facing errors appeared. Proactive detection window was short but present."
- Evidence: Timeline shows alert at 14:32, first customer report at 14:34

**3. How effective was the alert's clarity/actionability?**
- ✅ **GOOD:** "Alert provided clear metric (connection pool usage) but lacked actionable next steps. On-call engineer had to search runbooks."
- Evidence: Specific feedback about alert quality documented

#### ⚠️ Present but Weak (1 question)

**4. Was the Error Budget of a System-wide SLO affected?**
- ⚠️ **WEAK:** "Yes, system-wide SLO was affected."
- Issue: No quantification of impact (burn rate, error budget consumption, duration)
- **Needs depth:** How much error budget consumed? What's the remaining budget? Impact on monthly SLO target?

#### ❌ Missing (2 questions)

**5. Was the Error Budget of a Service-specific SLO affected?**
- ❌ **MISSING:** No mention of service-specific SLO impact
- **Guiding questions for working session:**
  - Which services were most affected? (Orders API, Payment API, etc.)
  - What was the error budget consumption for each affected service?
  - Are any services now close to breaching monthly SLO targets?
  - Should service-specific incident response be triggered?

**6. What can be improved in detection?**
- ❌ **MISSING:** No detection improvement actions proposed
- **Guiding questions for working session:**
  - Should alert threshold be lowered (from 95% to 90%)?
  - Should alert include actionable runbook link?
  - Are there earlier indicators we could monitor (e.g., slow query trends)?
  - Should we add pre-emptive alerts for connection pool growth rate?

---

### 🩹 Pillar 2: Troubleshooting & Recovery (55/100)

#### ✅ Fully Addressed (3 questions)

**1. Was MTTR adequate?**
- ✅ **GOOD:** "MTTR was 47 minutes. Historical average for database incidents: 35 minutes. This incident was 34% longer than average."
- Evidence: MTTR documented with historical comparison and analysis

**2. What was the primary method of mitigation?**
- ✅ **GOOD:** "Primary mitigation: Emergency increase of connection pool max size from 200 to 400 via config change. No code deployment required."
- Evidence: Clear mitigation method documented

**3. Did the incident management process work?**
- ✅ **GOOD:** "Incident Commander declared SEV2 at 14:40. Roles assigned effectively. Process worked well — clear ownership and escalation."
- Evidence: Process assessment included with specific examples

#### ⚠️ Present but Weak (3 questions)

**4. Were troubleshooting steps effective?**
- ⚠️ **WEAK:** "Team used standard database runbook and found the issue quickly."
- Issue: No detail on what worked or what didn't. No assessment of tooling adequacy.
- **Needs depth:** What specific troubleshooting steps were taken? Were logs/metrics/traces helpful? What tools were used? Any gaps in observability?

**5. Was communication effective?**
- ⚠️ **WEAK:** "Communication was good. Team kept stakeholders updated."
- Issue: Too vague. No specific assessment of internal vs external communication.
- **Needs depth:** Were customer comms timely? Did leadership get adequate updates? Any communication delays or gaps?

**6. Were runbooks or documentation used?**
- ⚠️ **WEAK:** "Yes, database troubleshooting runbook was used."
- Issue: No assessment of runbook quality or accuracy.
- **Needs depth:** Was the runbook accurate? Did it help reduce MTTR? What's missing from the runbook? Should it be updated?

#### ❌ Missing (2 questions)

**7. What slowed down recovery?**
- ❌ **MISSING:** No analysis of recovery delays
- **Guiding questions for working session:**
  - What caused the 47-minute MTTR (vs 35-minute average)?
  - Were there specific blockers? (Knowledge gaps, tooling issues, coordination delays?)
  - What could have been faster?
  - Root cause diagnosis time vs mitigation execution time — which took longer?

**8. Did dependencies or cascading failures significantly delay recovery?**
- ❌ **MISSING:** No mention of cascading failures or dependency impact
- **Guiding questions for working session:**
  - Did upstream services (e.g., API gateway) amplify the issue?
  - Did downstream services degrade as a result?
  - Were there cascading failures that complicated recovery?
  - Did cross-team coordination slow down response?

---

### 🧠 Pillar 3: Learning & Improvement (50/100)

#### ✅ Fully Addressed (1 question)

**3. Was the incident caused by a recent change?**
- ✅ **GOOD:** "Yes. Incident caused by deployment of new batch job (v3.2.1) on 2026-03-28, which opened 50 long-lived database connections without releasing them. Change Failure Rate implications noted."
- Evidence: Clear correlation to recent change, deployment details documented

#### ⚠️ Present but Weak (2 questions)

**1. Is the technical root cause clear?**
- ⚠️ **WEAK:** "Root cause: Connection pool exhausted due to batch job not closing database connections."
- Issue: Too surface-level. This describes the symptom, not the deeper root cause.
- **Needs depth:**
  - Why did the batch job fail to close connections? (Code bug? Framework misuse? Missing finally block?)
  - Why didn't pre-production testing catch this?
  - Why didn't code review catch this pattern?
  - Was there architectural guidance on connection management?

**4. What action items prevent recurrence?**
- ⚠️ **WEAK:** "Action items: 1) Fix batch job connection handling. 2) Improve monitoring."
- Issue: Too generic. No specificity, no timelines, no measurability.
- **Needs depth:** What specific code changes? What specific monitoring improvements? Define "improve monitoring" with concrete metrics.

#### ❌ Missing (4 questions)

**2. Are there architectural issues to address?**
- ❌ **MISSING:** No architectural analysis
- **Guiding questions for working session:**
  - Is connection pool size adequate for current load?
  - Should we implement connection pool per service/component?
  - Are there design patterns to enforce connection lifecycle management?
  - Should we add circuit breakers or backpressure mechanisms?

**5. Were the follow-up actions immediately owned and tracked?**
- ❌ **MISSING:** No ownership or tracking information
- **Guiding questions for working session:**
  - Who owns each action item?
  - What are the target completion dates?
  - How will action items be tracked? (Jira tickets? Problem Management?)
  - What's the priority of each item? (Urgent vs long-term improvement)

**6. Did the team gain a significant new insight about the system?**
- ❌ **MISSING:** No learning insights documented
- **Guiding questions for working session:**
  - What did the team learn about the system?
  - Were there surprises during troubleshooting?
  - Did this expose unknown risks or vulnerabilities?
  - What systemic patterns should other teams be aware of?

**Note:** Question 2 (architectural issues) is missing entirely, which is critical for this type of incident.

---

## Prioritized Session Agenda

**Recommended focus for RCA working session:**

### 🔴 High Priority (Address First)

1. **Root Cause Depth (Pillar 3)**
   - Current answer is surface-level ("connections not closed")
   - Dig deeper: Why did code not close connections? Why didn't testing catch this?
   - Use 5 Whys technique to get to systemic root cause

2. **Action Item Ownership & Tracking (Pillar 3)**
   - Generic action items need specificity
   - Assign clear owners, timelines, and tracking mechanisms
   - Define measurable outcomes for each action

3. **What Slowed Recovery? (Pillar 2)**
   - MTTR was 34% longer than average — why?
   - Identify specific recovery bottlenecks
   - Determine what could have been faster

### 🟡 Medium Priority (Address Next)

4. **Architectural Analysis (Pillar 3)**
   - Missing entirely — critical for preventing recurrence
   - Discuss connection pool architecture
   - Identify design patterns or safeguards needed

5. **SLO Impact Quantification (Pillar 1)**
   - "SLO affected" is too vague
   - Quantify error budget consumption
   - Assess remaining budget and risk

6. **Cascading Failures & Dependencies (Pillar 2)**
   - Not addressed — important for understanding full impact
   - Map upstream/downstream effects
   - Identify coordination gaps

### 🟢 Lower Priority (If Time Permits)

7. **Detection Improvements (Pillar 1)**
   - Good foundation, but no improvement actions yet
   - Propose specific alert tuning or new monitoring

8. **Communication & Runbook Quality (Pillar 2)**
   - Both marked as "good" but weak depth
   - Validate communication effectiveness
   - Assess runbook accuracy and completeness

---

## Next Steps

### For the Team

1. **Schedule working session** — 60-90 minutes recommended
2. **Pre-session prep:**
   - Review this assessment
   - Gather additional data if needed (logs, metrics, deployment records)
   - Invite key participants (batch job owner, database engineer, incident commander)

3. **During session:**
   - Focus on 🔴 High Priority items first
   - Use guiding questions to drive discussion
   - Document answers directly in retrospective document

4. **Post-session:**
   - Re-run this skill to measure improvement
   - Target: >75% score for approval
   - Finalize action item tracking in Jira

### For Process Engineering

- **Facilitation focus:** Root cause depth + action item specificity
- **Watch for:** Surface-level answers, generic action items, missing ownership
- **Success criteria:** Before/After score improvement of >20 points

---

## Assessment Methodology

**Evaluation Criteria:**
- ✅ **Fully addressed:** Question answered with sufficient depth, evidence-based, actionable
- ⚠️ **Present but weak:** Question addressed but lacks depth, specificity, or evidence
- ❌ **Missing:** Question not addressed in the document

**Scoring:**
- ✅ = 100% (full credit)
- ⚠️ = 50% (partial credit)
- ❌ = 0% (no credit)

**Pillar Score:** (Sum of question scores) / (Total questions in pillar) × 100
**Overall Score:** (Sum of all pillar scores) / 3

---

**Generated by:** Koda RCA Quality Skill v1.0
**Framework Version:** RCA Pillars v1.0 (Detection, Troubleshooting & Recovery, Learning & Improvement)
**For questions or feedback:** Contact Process Engineering team
