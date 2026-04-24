# Retrospective Pre-Assessment — RDINC-77259

**Incident:** SEV2 - Database Scripts Generation failures in OSALL/EA
**Assessment Date:** 2026-04-24
**Assessed By:** Koda Pre-Assessment Skill v2.0
**Document:** https://outsystemsrd.atlassian.net/wiki/spaces/RKB/pages/6094454826/

---

## Overall Quality Score: **65/100** 🟡

**Status:** Ready for working session
**Recommendation:** Strong technical root cause analysis but significant gaps in response/communication assessment and action item specificity. Schedule working session to address high-priority gaps before VSL approval.

---

## Score Breakdown by Pillar

| Pillar | Score | Status | Summary |
|--------|-------|--------|---------|
| 🕵️ Detection & Monitoring | 67/100 | 🟡 | Detection method clear but delayed by 57h; SLO analysis present but weak |
| 📣 Response & Communication | 25/100 | 🔴 | Incident declaration analyzed but external comms and MTTA completely missing |
| 🔍 Troubleshooting & Root Cause | 100/100 | 🟢 | Excellent depth with 5-Whys, evidence-based analysis, architectural issues identified |
| 🩹 Recovery & Resolution | 64/100 | 🟡 | MTTR documented, rollback justified, but runbook usage and dependency analysis weak |
| 🧠 Prevention & Learning | 63/100 | 🟡 | Change correlation strong, action items present but lack specificity and tracking |
| ✅ Process Compliance | 50/100 | 🟡 | Incident management covered but RFC compliance not evaluated (2 questions only) |

**Overall Pre-Assessment:** 16.5/26 questions fully addressed

---

### 🕵️ Pillar 1: Detection & Monitoring (67/100)

**Score:** 4.0 / 6.0 points

#### ✅ Fully Addressed (3 questions)

**Q1: How was the incident initially detected?**
- ✅ **GOOD:** "SLO Name: osall - Database Scripts Generation - SR - us-east-1 (osall-database-scripts-generation-sr-us-east-1) ... Alert Conditions: Remaining budget ≤ 0%"
- **Evidence:** Clear identification that detection came from SLO budget exhaustion alert on March 19 7:25 PM WET

**Q4: Was the Error Budget of a System-wide SLO affected?**
- ✅ **GOOD:** "SLO Service Name: Sys-wide - OSALL - 1CP Composite (sys-wide-osall-1cp-composite) ... Remaining budget ≤ 0%"
- **Evidence:** System-wide SLO explicitly identified and budget exhaustion documented

**Q6: What can be improved in detection?**
- ✅ **GOOD:** "Ensure RDOS raises service-level alerts when S3 URL calls fail, so failures are surfaced independently of SLO budget drain" and "RDMMS alarms did not trigger, the service failed silently without raising its own alerts"
- **Evidence:** Specific action items identify observability gaps at both RDOS and RDMMS service levels

#### ⚠️ Present but Weak (2 questions)

**Q2: Was the incident detected before customer impact?**
- ⚠️ **WEAK:** "The issue had been present in OSALL since 2026-03-17 13:46 UTC, two days before it was detected" and "Approximately 20 tenants in OSALL and 10 tenants in EA were impacted"
- **Issue:** Customer impact timing documented but analysis is superficial
- **Needs depth:** What was the customer experience during those 57 hours? Were customers reporting issues before the SLO alert fired? If yes, why weren't those signals surfaced earlier?

**Q3: Were alerts clear and actionable?**
- ⚠️ **WEAK:** Alert conditions documented but no assessment of alert quality
- **Issue:** No evaluation of whether the SLO alert provided sufficient context for rapid troubleshooting
- **Needs depth:** Did the alert guide responders to the right service? Did it suggest next steps? Would a different alert type (burn rate vs budget exhaustion) have detected this faster?

#### ❌ Missing (1 question)

**Q5: Was the Error Budget of a Service-specific SLO affected?**
- ❌ **MISSING:** Only system-wide SLO mentioned; no analysis of RDMMS or RDOS service-specific SLO impact
- **Guiding questions for working session:**
  - Were RDMMS service-specific SLOs affected?
  - Were RDOS service-specific SLOs affected?
  - Why didn't service-level SLOs fire before the system-wide composite SLO?

---

### 📣 Pillar 2: Response & Communication (25/100)

**Score:** 1.0 / 4.0 points

#### ✅ Fully Addressed (1 question)

**Q1: Was incident declaration timely?**
- ✅ **GOOD:** "The bug entered OSALL on 2026-03-17 and was only acted on 2026-03-19" and timeline shows initial assessment as single-tenant issue ("After investigation, this is confirmed as a tenant-isolated issue") before later being upgraded to system-wide at 10:47 PM WET
- **Evidence:** Declaration delay analyzed with root cause (partial impact pattern led to misdiagnosis as single-tenant issue)

#### ❌ Missing (3 questions)

**Q2: Was internal communication effective?**
- ❌ **MISSING:** No assessment of internal communication quality during incident response
- **Guiding questions for working session:**
  - Was the incident channel active and focused?
  - Were updates to leadership timely?
  - Did cross-team coordination work effectively (SRE, Maestro, Runtime Data Model, ODC RDO)?

**Q3: Was external communication effective?**
- ❌ **MISSING:** No mention of customer-facing communication or status page updates
- **Guiding questions for working session:**
  - Was the public status page updated?
  - Were affected customers notified?
  - What was the Public MTTA?
  - Were customer-facing updates clear about impact and recovery timeline?

**Q4: Was MTTA (Mean Time to Acknowledge) adequate?**
- ❌ **MISSING:** No MTTA calculation or analysis
- **Guiding questions for working session:**
  - What was the MTTA (time from alert to acknowledgment)?
  - Was it within acceptable range for SEV2?
  - How does it compare to historical MTTA?

---

### 🔍 Pillar 3: Troubleshooting & Root Cause (100/100)

**Score:** 3.0 / 3.0 points

#### ✅ Fully Addressed (3 questions)

**Q1: Were troubleshooting steps effective?**
- ✅ **GOOD:** "Acknowledged alert and identified DB script generation failures in RDOS logs (S3 403 Forbidden on PUT)" and "Confirmed root cause: `platform-api-core v59.1.0` S3 URL masking in RDMMS 1.0.250 causing the WAF to block S3 PUT requests"
- **Evidence:** Clear troubleshooting progression from symptom (RDOS S3 failures) to root cause (platform-api-core change in RDMMS)

**Q2: What is the technical root cause?**
- ✅ **GOOD:** Excellent 6-level 5-Whys analysis with evidence: "RDMMS 1.0.250 upgraded to `platform-api-core v59.1.0`, which introduced S3 Pre-signed URL Masking by default. This routes S3 pre-signed URLs through the tenant domain, placing the WAF in the path of S3 PUT requests. The WAF blocks those PUT requests in some cases (403 Forbidden), failing DB script generation in RDOS."
- **Evidence:** Root cause goes deep beyond surface symptoms, includes timeline evidence (bug introduced 2026-03-17, detected 2026-03-19), change correlation (platform-api-core v59.1.0), and technical mechanism (WAF blocking masked S3 URLs)

**Q3: Are there architectural issues to address?**
- ✅ **GOOD:** "Two compounding observability gaps allowed it to remain silent: RDMMS alarms did not trigger, and RDOS logs an incorrect 'Job ended with Successful' status even when the S3 PUT fails, obscuring the failure in RDOS logs"
- **Evidence:** Architectural observability gaps clearly identified — service-level alerting failure and false-positive logging in RDOS

---

### 🩹 Pillar 4: Recovery & Resolution (64/100)

**Score:** 4.5 / 7.0 points

#### ✅ Fully Addressed (3 questions)

**Q1: What was the recovery time (MTTR) and was it acceptable?**
- ✅ **GOOD:** "Mitigated At: March 19 10:38 PM WET, Resolved At: March 20 1:39 AM WET" — 3h 12min to mitigation, 6h 13min to resolution from detection (March 19 7:26 PM WET)
- **Evidence:** MTTR documented with justification for timeline (rollback unsafe, fix-forward required with reduced bake times)

**Q3: Was rollback considered as a recovery option?**
- ✅ **GOOD:** "The bug entered OSALL on 2026-03-17 and was only acted on 2026-03-19. In the intervening two days, multiple RDMMS versions (1.0.251, 1.0.252, etc.) had been deployed across rings. A service rollback to pre-1.0.250 would have reverted all those changes, making it operationally unsafe."
- **Evidence:** Rollback explicitly considered and rejected with clear, documented justification

**Q7: Was customer impact quantified?**
- ✅ **GOOD:** "Approximately 20 tenants in OSALL and 10 tenants in EA were impacted; GA was not affected."
- **Evidence:** Customer impact quantified with specific numbers by ring

#### ⚠️ Present but Weak (3 questions)

**Q2: What was the primary method of mitigation?**
- ⚠️ **WEAK:** "A code fix reverting the offending change was merged and released as RDMMS 1.0.255. Ring bake times were temporarily decreased to accelerate propagation."
- **Issue:** Mitigation method identified but incomplete — what specifically was reverted?
- **Needs depth:** Was S3 URL masking completely disabled, or was it configured differently? Was the revert a full rollback of platform-api-core v59.1.0, or just a feature flag disable?

**Q5: Were runbooks or documentation used and assessed?**
- ⚠️ **WEAK:** No mention of runbook usage during recovery
- **Issue:** No evidence that runbooks were consulted or assessed for improvement
- **Needs depth:** Did runbooks exist for RDMMS rollback or emergency deployment? Were they used? If not, should they be created?

**Q6: Did dependencies or cascading failures significantly delay recovery?**
- ⚠️ **WEAK:** Multiple team escalations documented (SRE → Maestro → Runtime Data Model → ODC RDO) but impact not analyzed
- **Issue:** Cross-team coordination complexity visible in timeline but not assessed as a recovery blocker
- **Needs depth:** Did the need to coordinate across 4 teams delay recovery? How much time was spent on handoffs vs active troubleshooting?

#### ❌ Missing (1 question)

**Q4: Are recovery blockers identified? Did the team lack confidence or capability?**
- ❌ **MISSING:** No analysis of what slowed recovery or whether capability gaps existed
- **Guiding questions for working session:**
  - What was the longest delay in the recovery process?
  - Were there missing tools, information, or expertise?
  - Did the team lack confidence in any recovery action (e.g., version banning, bake time reduction)?
  - What would have accelerated recovery if available?

---

### 🧠 Pillar 5: Prevention & Learning (63/100)

**Score:** 2.5 / 4.0 points

#### ✅ Fully Addressed (2 questions)

**Q1: Was the incident caused by a recent change?**
- ✅ **GOOD:** "RDMMS 1.0.250 upgraded to `platform-api-core v59.1.0` (company-wide migration [request](https://outsystems.slack.com/archives/C02DKPZK72L/p1773076307523179), Mar 9), which introduced S3 Pre-signed URL Masking by default."
- **Evidence:** Direct change correlation with evidence (RDMMS version, platform-api-core upgrade, company announcement)

**Q2: Was recurrence analysis performed?**
- ✅ **GOOD:** "Positive-ring system tests were already enabled (from [RPLAT-3807](https://outsystemsrd.atlassian.net/browse/RPLAT-3807)), but the WAF blocking condition is partial and tenant-specific, the tests did not exercise the tenant conditions that trigger it"
- **Evidence:** Recurrence prevention mechanism (positive-ring tests) assessed and gap identified (tests didn't catch tenant-specific failure patterns)

#### ⚠️ Present but Weak (2 questions)

**Q3: Are prevention action items defined with clear ownership and tracking?**
- ⚠️ **WEAK:** Four action items listed with Jira IDs (RPLAT-3819, RPLAT-3823, RPLAT-3824) but descriptions are vague
- **Issue:** Action items lack specificity and measurable acceptance criteria
- **Needs depth:** 
  - RPLAT-3819: "Upgrade platform-api-core and opt out of S3 URL masking" — is opt-out temporary or permanent? What prevents this from recurring in future platform-api-core upgrades?
  - RPLAT-3823: "Ensure RDOS raises service-level alerts when S3 URL calls fail" — what specific alert will be added? What threshold? What runbook will it link to?
  - RPLAT-3824: "Fix RDOS false-positive log status" — what is the definition of "success" vs "failure" in RDOS? How will this be tested?
  - SRE action: "Clarify SLO-to-team ownership mapping" — what deliverable proves this is complete?

**Q4: What learnings did the team gain?**
- ⚠️ **WEAK:** Implicit learning about observability gaps and test coverage but not explicitly captured
- **Issue:** No "Learnings" section summarizing insights that could benefit other teams
- **Needs depth:** What did the team learn about S3 URL masking risks? About budget-exhaustion SLOs vs burn-rate SLOs? About false-positive logging patterns? What can other teams learn from this?

---

### ✅ Pillar 6: Process Compliance (50/100)

**Score:** 1.0 / 2.0 points (pre-assessment evaluates Q1-Q2 only)

#### ✅ Fully Addressed (1 question)

**Q1: Was incident management process followed?**
- ✅ **GOOD:** Timeline shows clear incident progression with roles assigned (Incident Commander: Sam Audu → Kevin Tek, Internal Communications Leader: Hugo Gaspar, Engineers from multiple teams), escalation path followed (SRE → Maestro → Runtime Data Model → ODC RDO), and incident declaration process followed (initially assessed as single-tenant, later upgraded to system-wide)
- **Evidence:** Incident management process clearly documented in timeline

#### ⚠️ Present but Weak (1 question)

**Q2: If the mitigation required a change (RFC), did it follow Change Management policy?**
- ⚠️ **WEAK:** Timeline mentions "Ring bake times were temporarily decreased to accelerate propagation; bake times were restored once the fix reached the affected rings" and "Affected versions were banned to prevent the issue from reaching GA"
- **Issue:** Mentions deployment process changes (bake time reduction, version banning) but no evaluation of whether an RFC was required or if Emergency RFC was used
- **Needs depth:** 
  - Was an RFC created for the emergency fix deployment (RDMMS 1.0.255)?
  - Was Emergency RFC justified (system-wide impact was declared)?
  - Was the bake time reduction documented and approved through Change Management?
  - Were the affected version bans documented as changes?

---

## Prioritized Working Session Agenda

**Recommended focus for RCA working session (60-90 min):**

### 🔴 High Priority (Address First — 30 min)

1. **Missing External Communication Assessment (Pillar 2, Q3)**
   - Current state: No mention of customer-facing communication or status page updates
   - Why critical: SEV2 with 30 affected tenants across 2 days requires customer communication; absence of analysis suggests process gap
   - Guiding questions:
     - Was the public status page updated?
     - Were affected customers proactively notified?
     - What was the Public MTTA?
     - How did customers discover the issue (proactive outreach vs support tickets)?

2. **Vague Prevention Action Items (Pillar 5, Q3)**
   - Current state: Four action items listed but lack specificity, acceptance criteria, and timelines
   - Why critical: Without measurable action items, improvements won't be trackable or verifiable
   - Guiding questions:
     - RPLAT-3819: Is S3 URL masking opt-out permanent? How do we prevent recurrence in future upgrades?
     - RPLAT-3823: What specific alert threshold and runbook will be added to RDOS?
     - RPLAT-3824: How will "success" vs "failure" be redefined in RDOS logs? How will this be validated?
     - What are the completion timelines for each action item?

3. **RFC Compliance Not Evaluated (Pillar 6, Q2)**
   - Current state: Emergency deployment process mentioned but Change Management compliance not assessed
   - Why critical: Emergency changes during incident response must follow policy; bake time reduction and version banning are changes requiring documentation
   - Guiding questions:
     - Was an Emergency RFC created for RDMMS 1.0.255 deployment?
     - Was the bake time reduction approved through Change Management?
     - Were version bans documented as changes?
     - If Emergency RFC was used, was it justified by system-wide impact declaration?

### 🟡 Medium Priority (Address Next — 20 min)

4. **Recovery Blockers Not Identified (Pillar 4, Q4)**
   - Current state: Recovery timeline documented but no analysis of what slowed recovery or capability gaps
   - Guiding questions:
     - What was the longest delay between troubleshooting steps?
     - Were there missing tools, runbooks, or expertise that slowed recovery?
     - Did the team lack confidence in any recovery action?
     - What would have accelerated recovery by 30+ minutes?

5. **MTTA Not Assessed (Pillar 2, Q4)**
   - Current state: No MTTA calculation or comparison to historical baseline
   - Guiding questions:
     - What was the MTTA (alert fired 7:25 PM, acknowledged 7:26 PM)?
     - Was 1-minute MTTA acceptable for SEV2?
     - How does this compare to historical MTTA for system-wide SLO alerts?

6. **Missing Learnings Synthesis (Pillar 5, Q4)**
   - Current state: Technical root cause strong but no explicit learnings section for cross-team benefit
   - Guiding questions:
     - What did the team learn about S3 URL masking risks?
     - What is the lesson about budget-exhaustion SLOs vs burn-rate SLOs?
     - What can other teams learn about false-positive logging patterns?
     - How should teams evaluate the impact of platform-api-core upgrades?

### 🟢 Lower Priority (If Time Permits — 10 min)

7. **Weak Alert Quality Assessment (Pillar 1, Q3)**
   - Current state: Alert conditions documented but no evaluation of whether alert was actionable
   - Guiding questions:
     - Did the SLO budget exhaustion alert guide responders to the right service?
     - Would a burn-rate alert have detected the issue faster than budget exhaustion?
     - What improvements to the alert payload would have accelerated troubleshooting?

8. **Service-Specific SLO Analysis Missing (Pillar 1, Q5)**
   - Current state: Only system-wide SLO analyzed; no mention of RDMMS or RDOS service-level SLOs
   - Guiding questions:
     - Were RDMMS service-specific SLOs affected?
     - Why didn't service-level alerts fire before the system-wide composite alert?

---

## Next Steps

### For the Retrospective Commander (EM/TL)

1. **Review this assessment** — Focus on 🔴 High Priority gaps (external comms, action item specificity, RFC compliance)
2. **Gather additional data** before working session:
   - Status page update history for incident period (March 17-20)
   - RFC records for RDMMS 1.0.255 deployment
   - MTTA calculation (alert timestamp to acknowledgment timestamp)
   - Action item acceptance criteria and completion timelines from Jira
3. **Schedule working session** — Coordinate with Process Eng and invite:
   - Incident Commander (Kevin Tek)
   - Internal Comms Leader (Hugo Gaspar) — for external comms assessment
   - RDMMS team representative — for action item specificity
   - SRE representative — for SLO and alert analysis
4. **Pre-session prep:**
   - Review 🔴 High Priority guiding questions
   - Validate whether Emergency RFC was used or required

### For Working Session Facilitator (Process Eng)

- **Facilitation focus:** 
  1. External communication assessment (Pillar 2, Q3)
  2. Action item specificity with measurable criteria (Pillar 5, Q3)
  3. RFC compliance evaluation (Pillar 6, Q2)
- **Watch for:** 
  - Defensive justifications for missing external comms
  - Action items that sound specific but lack acceptance criteria
  - Confusion about when Emergency RFC is required
- **Success criteria:** 
  - Address all 🔴 High Priority gaps
  - Improve score by >15 points (target: 80+)
  - All action items have measurable acceptance criteria and timelines
  - RFC compliance clearly documented

---

## Expected Outcome

**Target post-session:** >70% score (ready for VSL approval)
**Re-assessment:** Run post-assessment after VSL approval to measure final quality

---

**Generated by:** Koda Pre-Assessment Skill v2.0
**Framework Version:** RCA Framework v2.0 (6 pillars, 29 questions | Pre-Assessment: 26 questions)
**For questions:** Contact Process Engineering (Inês Matos, Vera Branco)
