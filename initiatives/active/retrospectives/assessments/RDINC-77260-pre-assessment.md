# Retrospective Pre-Assessment - RDINC-77260

**Incident:** SEV2 - OS-DPL-40802 errors when performing 1CP publish and deploy operations in EA
**Assessment Date:** 2026-04-24
**Assessed By:** Koda Pre-Assessment Skill v2.0
**Document:** [Confluence - Retrospective RDINC-77260](https://outsystemsrd.atlassian.net/wiki/spaces/RKB/pages/6094454826/)

---

## Overall Quality Score: **44/100** 🟡

**Status:** Ready for working session
**Recommendation:** The retrospective covers the basics but lacks depth across most pillars. Root cause is partially understood (team acknowledges "we don't have the full timeline"). Detection analysis is surface-level, response/communication gaps are significant, and action items need strengthening. A focused working session (60-90 min) is recommended.

---

## Score Breakdown by Pillar

| Pillar | Score | Status | Summary |
|--------|-------|--------|---------|
| 🕵️ Detection & Monitoring | 42/100 | 🟡 | Alert fired but wasn't prioritized; no SLO error budget analysis |
| 📣 Response & Communication | 25/100 | 🔴 | Declaration delay noted but not analyzed; external comms and MTTA missing |
| 🔍 Troubleshooting & Root Cause | 50/100 | 🟡 | Root cause partially identified; team acknowledges incomplete understanding |
| 🩹 Recovery & Resolution | 50/100 | 🟡 | Mitigation documented; rollback consideration and runbooks missing |
| 🧠 Prevention & Learning | 50/100 | 🟡 | Change correlation clear; recurrence analysis missing, action items weak |
| ✅ Process Compliance | 50/100 | 🟡 | Roles documented; RFC compliance not fully assessed |

**Overall Pre-Assessment:** 11.5/26 points earned (5 fully addressed, 11 weak, 4 missing, 0 N/A)

---

## Detailed Assessment Per Pillar

### 🕵️ Pillar 1: Detection & Monitoring (42/100)

#### ✅ Fully Addressed (1 question)

**Q1: How was the incident initially detected?**
- ✅ **GOOD:** "The Maestro team received an alert at ~5:30PM (WET), but it was not prioritized alongside ongoing support work." Customer reports came at 8:06PM via Global Support. Three Zendesk cases documented with tenant details.
- **Evidence:** Two detection paths identified (automated alert + customer report) with timestamps for both.

#### ⚠️ Present but Weak (3 questions)

**Q2: Was the incident detected before customer impact?**
- ⚠️ **WEAK:** Alert fired at ~5:30PM, ~30 minutes after the bake fail at ~5:00PM. But it was not prioritized. Customer reports arrived at 8:06PM.
- **Issue:** The retrospective states the alert wasn't prioritized but doesn't analyze why this gap matters or what the customer impact timeline was.
- **Needs depth:** When did customers actually start experiencing errors? Was the alert truly before customer impact or did it just happen to fire around the same time?

**Q3: Were alerts clear and actionable?**
- ⚠️ **WEAK:** "The Maestro team received an alert at ~5:30PM (WET), but it was not prioritized alongside ongoing support work."
- **Issue:** The alert existed but its clarity and actionability are not assessed. Was the alert message clear about what was wrong? Did it provide enough context to act on?
- **Needs depth:** Was this a generic alert or a specific one? Would a clearer alert have been prioritized?

**Q6: What can be improved in detection?**
- ⚠️ **WEAK:** "Whenever we do a bake fail on PS, we should keep a closer eye to alarms on positive rings." "Continue to review alarms to remove unnecessary noise." "Team is considering to increase support capacity."
- **Issue:** Improvements are vague and process-oriented ("keep a closer eye", "considering"). No specific alert changes proposed.
- **Needs depth:** What specific alert would catch this faster? Should bake-fail operations automatically trigger enhanced monitoring?

#### ❌ Missing (2 questions)

**Q4: Was the Error Budget of a System-wide SLO affected?**
- ❌ **MISSING:** No mention of system-wide SLO impact or error budget consumption.
- **Guiding questions for working session:**
  - Was a system-wide SLO affected by this EA-ring incident?
  - If EA has separate SLOs, what was the error budget impact?

**Q5: Was the Error Budget of a Service-specific SLO affected?**
- ❌ **MISSING:** No mention of Publish Service or Deployment Controller SLO impact.
- **Guiding questions for working session:**
  - What are the SLOs for the Publish Service and Deployment Controller?
  - How much error budget was consumed during the 3-hour incident?

**Pillar 1 Calculation:** Q1=1.0, Q2=0.5, Q3=0.5, Q4=0.0, Q5=0.0, Q6=0.5 = 2.5/6 = **42/100**

---

### 📣 Pillar 2: Response & Communication (25/100)

#### ⚠️ Present but Weak (2 questions)

**Q1: Was incident declaration timely?**
- ⚠️ **WEAK:** Alert at ~5:30PM, incident formally started at 8:06PM (~2.5h gap). The root causes section notes the alert "was not prioritized alongside ongoing support work" but doesn't analyze the delay in depth.
- **Issue:** A 2.5-hour gap between alert and incident declaration is significant. The analysis stops at "not prioritized" without examining why or what would change this.
- **Needs depth:** What was the support workload at that time? What escalation path should have been followed? Was there a severity assessment when the alert first fired?

**Q2: Was internal communication effective?**
- ⚠️ **WEAK:** Internal Communications Leader (Sara Goncalves) assigned. Slack channel created. But no assessment of whether communication was timely or effective during the incident.
- **Issue:** Roles listed but communication effectiveness not evaluated.
- **Needs depth:** Were updates shared in the Slack channel? Was leadership informed? Was the secondary CSP impact communicated effectively?

#### ❌ Missing (2 questions)

**Q3: Was external communication effective?**
- ❌ **MISSING:** No mention of status page updates or customer-facing communications. Zendesk ticket #3321132 linked but no assessment of external response to the three affected customers.
- **Guiding questions for working session:**
  - Were the three affected EA tenants notified about the incident?
  - Was the status page updated?
  - What was the Public MTTA?

**Q4: Was MTTA (Mean Time to Acknowledge) adequate?**
- ❌ **MISSING:** MTTA not documented. Alert at ~5:30PM, incident declared at 8:06PM = ~2.5h effective MTTA. Not assessed.
- **Guiding questions for working session:**
  - What is the formal MTTA for this incident?
  - How does ~2.5h compare to historical SEV2 MTTA?
  - Is this acceptable given the alert wasn't prioritized?

**Pillar 2 Calculation:** Q1=0.5, Q2=0.5, Q3=0.0, Q4=0.0 = 1.0/4 = **25/100**

---

### 🔍 Pillar 3: Troubleshooting & Root Cause (50/100)

#### ⚠️ Present but Weak (3 questions)

**Q1: Were troubleshooting steps effective?**
- ⚠️ **WEAK:** "Analyzed 1CP logs for all reported traces - found only warnings, no errors." "Correlated bake fail of Publish Service with the start of OS-DPL-40802 errors." Tasks during resolution listed.
- **Issue:** Steps listed but effectiveness not assessed. The note about "no error logs, only warnings, making diagnosis more difficult" is a partial assessment but doesn't evaluate overall troubleshooting effectiveness.
- **Needs depth:** How long did it take to correlate the bake fail? What tools were most/least useful? Were the right people involved from the start?

**Q2: What is the technical root cause?**
- ⚠️ **WEAK:** "A bake fail was performed on the Publish Service, which led to an inconsistent state for applications that were being published around that time." Three-level Why analysis provided. But: "We don't have the full timeline of how the apps with errors evolved during PS and DC versions."
- **Issue:** Root cause is partially understood. The team explicitly acknowledges they don't fully understand the mechanism. "AppDeployment CR after new publishes stayed on a state that NATS2CRD apply was not handling as expected" is surface-level.
- **Needs depth:** What exactly is the inconsistent state? What specific NATS2CRD behavior failed? Why didn't contract tests catch this? This needs deeper technical investigation.

**Q3: Are there architectural issues to address?**
- ⚠️ **WEAK:** NATS2CRD not handling unexpected AppDeployment CR states. Contract tests not covering bake-fail scenarios. PS-DC deployment coupling.
- **Issue:** Issues mentioned within root cause but not explicitly analyzed as architectural concerns.
- **Needs depth:** Is the bake-fail-leaving-inconsistent-state a systemic issue? Does this affect other services? Is the PS-DC coupling a known risk?

**Pillar 3 Calculation:** Q1=0.5, Q2=0.5, Q3=0.5 = 1.5/3 = **50/100**

---

### 🩹 Pillar 4: Recovery & Resolution (50/100)

#### ✅ Fully Addressed (2 questions)

**Q2: What was the primary method of mitigation?**
- ✅ **GOOD:** "A new version of the Publish Service (DUV 1.0.265) was deployed, after which subsequent publishes started succeeding in EA." Fix-forward approach. DC deployment planned for next morning.
- **Evidence:** Method clear - fix-forward with new PS version. Secondary DC fix planned separately.

**Q7: Was customer impact quantified?**
- ✅ **GOOD:** "3 EA tenants across us-east-1 and eu-central-1 were unable to publish or deploy any application." Tenant IDs, prefixes, and regions documented in table. "Development was completely blocked for the duration of the incident."
- **Evidence:** Specific tenant count, tenant details, regions, and impact description provided.

#### ⚠️ Present but Weak (3 questions)

**Q1: What was the recovery time (MTTR) and was it acceptable?**
- ⚠️ **WEAK:** Started: 8:06PM, Mitigated: 10:17PM, Resolved: 11:19PM. MTTR ~2h (mitigation) / ~3h (resolution) from declaration.
- **Issue:** Timestamps present but no assessment of whether this was acceptable. No comparison to historical MTTR.
- **Needs depth:** Was 2-3h acceptable for a SEV2 EA-scoped incident? What is the typical MTTR for Publish Service issues?

**Q4: Are recovery blockers identified?**
- ⚠️ **WEAK:** "No error logs found in 1CP Logs - only warnings - making diagnosis more difficult." "Attempted to create an emergency RFC for the Deployment Controller deployment - blocked, as the RFC tooling required the ticket to be linked to a system-wide incident."
- **Issue:** Two blockers mentioned (log quality, RFC tooling) but not systematically analyzed. No mention of team confidence or capability gaps.
- **Needs depth:** What other blockers existed? Did the team have the right expertise available? How much time was lost to the RFC tooling block?

**Q6: Did dependencies or cascading failures significantly delay recovery?**
- ⚠️ **WEAK:** Secondary impact identified: without new DC version in EA, mobile apps had CSP issues. PS-DC dependency noted. "Clearly didn't have any impact on the contract tests we have in place between PS and DC."
- **Issue:** Dependencies mentioned but impact on recovery timeline not analyzed.
- **Needs depth:** Did the PS-DC coupling delay recovery? Could the PS fix have been deployed faster independently?

#### ❌ Missing (2 questions)

**Q3: Was rollback considered as a recovery option?**
- ❌ **MISSING:** The incident was *caused* by a bake fail (rollback). No mention of whether rollback was considered as a recovery option or why fix-forward was chosen instead.
- **Guiding questions for working session:**
  - Was rollback considered for recovery, given the irony that a rollback caused the incident?
  - Why was fix-forward (new PS version) chosen over other options?
  - Was the decision documented?

**Q5: Were runbooks or documentation used and assessed?**
- ❌ **MISSING:** No mention of runbooks or documentation used during recovery.
- **Guiding questions for working session:**
  - Does a runbook exist for Publish Service bake-fail scenarios?
  - Was any documentation consulted during troubleshooting?
  - Should a runbook be created for this scenario?

**Pillar 4 Calculation:** Q1=0.5, Q2=1.0, Q3=0.0, Q4=0.5, Q5=0.0, Q6=0.5, Q7=1.0 = 3.5/7 = **50/100**

---

### 🧠 Pillar 5: Prevention & Learning (50/100)

#### ✅ Fully Addressed (1 question)

**Q1: Was the incident caused by a recent change?**
- ✅ **GOOD:** "A bake fail had been performed on the Publish Service around 5:00PM (WET), which correlated with the onset of errors." Clear change correlation with specific time and service.
- **Evidence:** Direct causal link established between the bake fail and the incident.

#### ⚠️ Present but Weak (2 questions)

**Q3: Are prevention action items defined with clear ownership and tracking?**
- ⚠️ **WEAK:** Three action items listed:
  - Keep closer eye to alarms on positive rings after bake fail (HIGH, "already shared with team", no Jira)
  - Improve NATS2CRD error (HIGH, RDMAST-2693, due 2026-04-30)
  - Build E2E test (medium, RCQA-6580, due 2026-06-30)
  - Fix RFC tooling constraint (already done)
- **Issue:** First action item has no Jira ticket and is vague ("keep a closer eye"). Action items don't fully address the root cause - there's no action for preventing bake fails from leaving applications in inconsistent state.
- **Needs depth:** What specifically prevents a bake fail from creating inconsistent state in the future? The E2E test detects but doesn't prevent. Where's the systemic fix?

**Q4: What learnings did the team gain?**
- ⚠️ **WEAK:** Implicit learnings: bake fails can leave inconsistent state, NATS2CRD has handling gaps, RFC tooling has constraints for EA-scoped incidents.
- **Issue:** No explicit lessons learned section. Learnings are embedded in the root cause analysis without broader implications.
- **Needs depth:** What broader implications does this have? Can other bake-fail scenarios cause similar issues? Is this a known risk pattern?

#### ❌ Missing (1 question)

**Q2: Was recurrence analysis performed?**
- ❌ **MISSING:** No check for previous incidents with similar root cause (bake fail leaving inconsistent state, Publish Service issues, NATS2CRD failures).
- **Guiding questions for working session:**
  - Have there been previous incidents caused by bake fails on the Publish Service?
  - Are there past NATS2CRD-related incidents?
  - Were there similar "inconsistent state after rollback" issues in other services?

**Pillar 5 Calculation:** Q1=1.0, Q2=0.0, Q3=0.5, Q4=0.5 = 2.0/4 = **50/100**

---

### ✅ Pillar 6: Process Compliance (50/100)

**Score:** 1.0 / 2.0 points

#### ⚠️ Present but Weak (2 questions)

**Q1: Was incident management process followed?**
- ⚠️ **WEAK:** Roles assigned: IC (Kevin Tek), Engineer (Kevin Tek), Internal Comms (Sara Goncalves). Rootly used. But: alert at 5:30PM was not acted on for 2.5 hours. Same person as IC and Engineer.
- **Issue:** Roles documented but process effectiveness not assessed. The 2.5h gap between alert and incident declaration is a significant process gap that isn't analyzed.
- **Needs depth:** Why was the IC also the sole engineer? Was the response staffing adequate? Should the alert have triggered a different escalation path?

**Q2: If the mitigation required a change (RFC), did it follow Change Management policy?**
- ⚠️ **WEAK:** "Attempted to create an emergency RFC for the Deployment Controller deployment - blocked, as the RFC tooling required the ticket to be linked to a system-wide incident." RFC for PS deployment (DUV 1.0.265) not mentioned.
- **Issue:** DC RFC attempt documented and tooling constraint identified (and fixed). But no assessment of whether the PS deployment followed Change Management policy.
- **Needs depth:** Was an RFC created for the Publish Service deployment (DUV 1.0.265)? What change type was used? Was the emergency classification appropriate?

**Pillar 6 Calculation:** Q1=0.5, Q2=0.5 = 1.0/2 = **50/100**

---

## Overall Score Calculation

| Pillar | Points Earned | Points Possible |
|--------|--------------|-----------------|
| 🕵️ Detection & Monitoring | 2.5 | 6 |
| 📣 Response & Communication | 1.0 | 4 |
| 🔍 Troubleshooting & Root Cause | 1.5 | 3 |
| 🩹 Recovery & Resolution | 3.5 | 7 |
| 🧠 Prevention & Learning | 2.0 | 4 |
| ✅ Process Compliance | 1.0 | 2 |
| **Total** | **11.5** | **26** |

**Overall Pre-Assessment Score: 11.5 / 26 = 44/100** 🟡

---

## Prioritized Working Session Agenda

**Recommended focus for RCA working session (60-90 min):**

### 🔴 High Priority (Address First - 30 min)

1. **Root Cause Depth (Pillar 3, Q2)**
   - Current state: Team acknowledges "we don't have the full timeline." Root cause is "bake fail left inconsistent state" but mechanism isn't fully understood.
   - Why critical: Without understanding the exact mechanism, prevention action items may be insufficient. The E2E test detects but doesn't prevent.
   - Guiding questions:
     - What exactly is the inconsistent state in AppDeployment CR?
     - Why doesn't NATS2CRD handle this state?
     - Why didn't contract tests between PS and DC catch this?
     - What specific code path leads to the inconsistent state during bake fail?

2. **Prevention Gap (Pillar 5, Q3)**
   - Current state: Action items detect (E2E test) and improve diagnostics (NATS2CRD error) but don't prevent the root cause.
   - Why critical: Without a prevention mechanism, bake fails on PS could cause the same incident again.
   - Guiding questions:
     - How do we prevent bake fails from leaving applications in inconsistent state?
     - Should bake-fail operations include a validation/cleanup step?
     - Is the "keep a closer eye" action item sufficient, or do we need an automated check?

### 🟡 Medium Priority (Address Next - 20 min)

3. **Detection & Alert Response Gap (Pillar 1, Q3 + Pillar 2, Q1)**
   - Current state: Alert fired 2.5h before incident declaration but wasn't prioritized. Alert effectiveness not assessed.
   - Guiding questions:
     - What would make this alert impossible to ignore?
     - Should bake-fail operations on positive rings auto-escalate?
     - What was the team's support workload when the alert was deprioritized?

4. **External Communication (Pillar 2, Q3-Q4)**
   - Current state: No documentation of external comms or MTTA.
   - Guiding questions:
     - Were the three affected EA tenants notified?
     - Was the status page updated?
     - What was the MTTA?

5. **Recurrence Analysis (Pillar 5, Q2)**
   - Current state: No check for similar past incidents.
   - Guiding questions:
     - Have bake fails caused incidents before?
     - Are there past NATS2CRD or Publish Service incidents?

### 🟢 Lower Priority (If Time Permits - 10 min)

6. **SLO Error Budget (Pillar 1, Q4-Q5)**
   - Current state: No SLO impact documented.
   - What are the Publish Service SLOs and how much budget was consumed?

7. **Runbooks (Pillar 4, Q5)**
   - Current state: Not mentioned.
   - Should a runbook be created for bake-fail recovery scenarios?

8. **Rollback Consideration (Pillar 4, Q3)**
   - Current state: Ironic gap - incident caused by rollback, but no documentation of whether rollback was considered for recovery.
   - Was fix-forward the right choice? Why?

---

## Next Steps

### For the Retrospective Commander

1. **Review this assessment** - Focus on 🔴 High Priority gaps (root cause depth + prevention)
2. **Gather additional data:**
   - AppDeployment CR state analysis (what exactly went wrong in NATS2CRD)
   - Contract test coverage between PS and DC (why this wasn't caught)
   - Historical bake-fail incidents (recurrence analysis)
   - SLO error budget data for Publish Service
   - External communication records (status page, customer notifications)
3. **Schedule working session** - Coordinate with Process Engineering (60-90 min)
4. **Pre-session prep:**
   - Review guiding questions for root cause and prevention
   - Invite key participants: Maestro team lead, NATS2CRD owner, SRE (for bake-fail process)

### For Working Session Facilitator (Process Eng)

- **Facilitation focus:** Root cause depth and prevention are the critical gaps. The team needs to go deeper on the mechanism before they can write effective prevention action items.
- **Watch for:** Vague action items ("keep a closer eye", "consider increasing capacity"). Push for specific, automated, measurable improvements.
- **Success criteria:** Address all 🔴 High Priority gaps, improve score by >20 points to reach >65%.

---

## Expected Outcome

**Target post-session:** >70% score (ready for VSL approval)
**Re-assessment:** Run post-assessment after VSL approval to evaluate all 29 questions

---

**Generated by:** Koda Pre-Assessment Skill v2.0
**Framework Version:** RCA Framework v2.0 (6 pillars, 29 questions | Pre-Assessment: 26 questions)
**For questions:** Contact Process Engineering (Ines Matos, Vera Branco)
