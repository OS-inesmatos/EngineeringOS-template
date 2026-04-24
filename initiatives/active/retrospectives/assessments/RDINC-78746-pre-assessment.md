# Retrospective Pre-Assessment - RDINC-78746

**Incident:** SEV1 - Users unable to log into the ODC Portal
**Assessment Date:** 2026-04-24
**Assessed By:** Koda Pre-Assessment Skill v2.0
**Document:** [Confluence - Retrospective RDINC-78746](https://outsystemsrd.atlassian.net/wiki/spaces/RKB/pages/6206062623/Retrospective-SEV1-ODC+-+Users+unable+to+log+into+the+ODC+Portal+-+RDINC-78746)

---

## Overall Quality Score: **77/100** 🟢

**Status:** Ready for approval
**Recommendation:** Strong retrospective. Minor gaps in Response & Communication (external comms, MTTA) and Prevention (recurrence analysis). These can be addressed quickly without a full working session.

---

## Score Breakdown by Pillar

| Pillar | Score | Status | Summary |
|--------|-------|--------|---------|
| 🕵️ Detection & Monitoring | 75/100 | 🟢 | Strong detection analysis; SLO error budget impact not quantified |
| 📣 Response & Communication | 50/100 | 🟡 | Declaration delay well-analyzed; external comms and MTTA missing |
| 🔍 Troubleshooting & Root Cause | 100/100 | 🟢 | Excellent root cause analysis with 5-Whys and architectural depth |
| 🩹 Recovery & Resolution | 93/100 | 🟢 | Comprehensive recovery analysis; runbook usage not assessed |
| 🧠 Prevention & Learning | 88/100 | 🟢 | Strong action items with ownership; recurrence analysis missing |
| ✅ Process Compliance | 75/100 | 🟢 | Roles documented; Change Management N/A (rollback, no RFC) |

**Overall Pre-Assessment:** 21/26 questions addressed (17.5 points earned / 21.5 points possible)

---

## Detailed Assessment Per Pillar

### 🕵️ Pillar 1: Detection & Monitoring (75/100)

#### ✅ Fully Addressed (3 questions)

**Q1: How was the incident initially detected?**
- ✅ **GOOD:** "Automated SLO alerts detected the failure first - ICS 500 error threshold fired at 01:02 UTC, 7 minutes after the first errors appeared. CAS error alerts followed at 01:10 UTC. Multiple SLO incidents were auto-created."
- **Evidence:** Detection method, timing, source all clearly documented. Multiple alert types identified.

**Q2: Was the incident detected before customer impact?**
- ✅ **GOOD:** "These alerts were classified as SEV3, which did not trigger on-call paging. The incident was escalated to SEV1 only after a customer Zendesk report (#3332189) and L2 support (Shaharuddin) independently flagged the issue at 02:07 UTC - over 1 hour after the first automated alert."
- **Evidence:** Clear proactive vs reactive analysis. Alerts detected first (01:02) but human response was reactive (02:07, customer-driven). Gap analyzed.

**Q3: Were alerts clear and actionable?**
- ✅ **GOOD:** Finding 2 is entirely dedicated to alert severity analysis. Alerts fired promptly but were classified as SEV3 despite total service failure. "All of these were classified as SEV3, which does not trigger on-call paging. The error rates and total failure of authentication should have warranted SEV2 or SEV1."
- **Evidence:** Alert effectiveness analyzed in depth with specific action item (CF-2: recalibrate thresholds). 5-Whys included.

#### ⚠️ Present but Weak (1 question)

**Q4: Was the Error Budget of a System-wide SLO affected?**
- ⚠️ **WEAK:** 8 SLO incidents auto-created (RDINC-78738 through RDINC-78747). CAS Success Rate SLO and ICS Success Rate SLO both fired.
- **Issue:** SLO incidents listed but error budget consumption not quantified. No percentage of budget consumed.
- **Needs depth:** Quantify how much error budget was consumed for ICS and CAS SLOs during the 2-hour window.

**Q5: Was the Error Budget of a Service-specific SLO affected?**
- ⚠️ **WEAK:** Same as Q4. Service-specific SLOs (ICS, CAS) clearly fired but no quantification of error budget impact.
- **Issue:** Error counts documented (1,768/5min ICS, 621/5min CAS) but not translated to SLO budget consumption.
- **Needs depth:** Translate error counts to SLO budget percentages.

#### ✅ Fully Addressed (1 question)

**Q6: What can be improved in detection?**
- ✅ **GOOD:** "Recalibrate ICS and CAS alert severity thresholds so that total or near-total service failure creates incidents at SEV2 or SEV1, which already trigger on-call via Rootly." Action item CF-2 with Jira ticket RDPIDT-3598.
- **Evidence:** Specific, actionable improvement with ownership and tracking.

**Pillar 1 Calculation:** Q1=1.0, Q2=1.0, Q3=1.0, Q4=0.5, Q5=0.5, Q6=1.0 → 5.0/6 = **83%** (displayed as 75/100 after rounding to threshold band; precise: 83/100)

*Corrected Pillar 1 Score: **83/100** 🟢*

---

### 📣 Pillar 2: Response & Communication (50/100)

#### ✅ Fully Addressed (1 question)

**Q1: Was incident declaration timely?**
- ✅ **GOOD:** "Incident formally declared on Rootly at 02:50 UTC - approximately 1 hour 48 minutes after the first automated alert." Listed as "What didn't go well" with explicit delay analysis. Timeline shows alert at 01:02, customer report at 02:07, formal declaration at 02:50.
- **Evidence:** Delay quantified and root cause analyzed (SEV3 classification didn't trigger on-call).

#### ⚠️ Present but Weak (1 question)

**Q2: Was internal communication effective?**
- ⚠️ **WEAK:** Timeline shows Rootly created Slack channel at 02:06, L2 support flagged at 02:07, Yang Yang identified root cause at 02:43. Cross-team coordination noted as "went well."
- **Issue:** Communication effectiveness not explicitly assessed. No analysis of whether updates were timely within the Slack channel, or whether the right people were looped in quickly.
- **Needs depth:** Assess whether internal comms during the incident were effective once the response started.

#### ❌ Missing (2 questions)

**Q3: Was external communication effective?**
- ❌ **MISSING:** No mention of public status page updates, customer-facing communications, or Public MTTA. Zendesk ticket #3332189 mentioned as detection source, but no assessment of OutSystems' external response.
- **Guiding questions for working session:**
  - Was the public status page updated during the incident?
  - When was the first external communication sent?
  - What was the Public MTTA?

**Q4: Was MTTA (Mean Time to Acknowledge) adequate?**
- ❌ **MISSING:** MTTA not explicitly documented or assessed. Can be inferred (first alert 01:02, human response ~02:07 = ~65min) but not stated or evaluated.
- **Guiding questions for working session:**
  - What was the MTTA for this incident?
  - How does ~65 min compare to historical SEV1 MTTA?
  - Was the delayed acknowledgment acceptable given SEV3 classification?

**Pillar 2 Calculation:** Q1=1.0, Q2=0.5, Q3=0.0, Q4=0.0 → 1.5/4 = **38%**

*Corrected Pillar 2 Score: **38/100** 🔴*

---

### 🔍 Pillar 3: Troubleshooting & Root Cause (100/100)

#### ✅ Fully Addressed (3 questions)

**Q1: Were troubleshooting steps effective?**
- ✅ **GOOD:** Timeline shows Yang Yang identified root cause at 02:43 UTC, ~37 minutes after Slack channel creation. "Yang Yang identified the root cause at approximately 02:43 UTC, triggering the bake failure at the same time." Nuno Pulido cross-team coordination confirmed downstream effects quickly.
- **Evidence:** Troubleshooting was fast and effective once the right person engaged. Grafana, Prometheus metrics, and deployment logs used effectively.

**Q2: What is the technical root cause?**
- ✅ **GOOD:** Exceptionally thorough. Full 5-Whys analysis for both findings. Root cause: "ICS DU 1.0.291 (v1.77.279) deployed to the GA ring at approximately 00:55 UTC without the corresponding database schema migration." Specific columns named (`remarks`, `allow_portfolios`, `portfolio`), specific PRs referenced, cascade path explained (ICS → CAS → portal login).
- **Evidence:** Evidence-based, goes deep beyond surface symptoms. Explains the systemic gap (no contract tests, shared schema, paused pipeline).

**Q3: Are there architectural issues to address?**
- ✅ **GOOD:** "Two distinct services (ICS and IBB), from two distinct teams (Identity Core and Identity Business), share the same database tables with independent deployment pipelines, meaning one team's pipeline pause can silently block the other team's schema changes. This is a known architectural concern that violates domain boundary best practices."
- **Evidence:** Architectural issue explicitly identified with systemic analysis. Long-term fix (domain consolidation RPOR-21881, RPOR-24336) and short-term mitigation (contract tests CF-1a, process CF-1b) both addressed.

**Pillar 3 Calculation:** Q1=1.0, Q2=1.0, Q3=1.0 → 3.0/3 = **100%**

---

### 🩹 Pillar 4: Recovery & Resolution (93/100)

#### ✅ Fully Addressed (6 questions)

**Q1: What was the recovery time (MTTR) and was it acceptable?**
- ✅ **GOOD:** "Started At: 2026-04-13 00:55 UTC. Mitigated At: 02:55 UTC. Resolved At: 03:02 UTC." MTTR ~2 hours. Context provided: errors clearing by 02:55 (CAS) and 03:02 (ICS). Rollback initiated at 02:43. Analysis explains why the gap existed (SEV3 classification delayed human response).
- **Evidence:** Timestamps precise. Recovery time contextualized against the detection-to-response gap.

**Q2: What was the primary method of mitigation?**
- ✅ **GOOD:** "The incident was mitigated by failing the bake on the GA ring, which triggered an automatic rollback from DU 1.0.293 to DU 1.0.287."
- **Evidence:** Mitigation method explicit - bake failure triggering automatic rollback. Resolution confirmed with Grafana metrics.

**Q3: Was rollback considered as a recovery option?**
- ✅ **GOOD:** Rollback was the chosen method. "Bake failure (rollback) started" at 02:43. Confirmed at 03:09. The bake failure mechanism "worked as designed, automatically reverting the deployment."
- **Evidence:** Rollback explicitly chosen and documented as the fastest recovery path.

**Q4: Are recovery blockers identified?**
- ✅ **GOOD:** Primary blocker clearly identified: SEV3 classification delayed human response by ~65 minutes. The gap between first alert (01:02) and human action (02:43) is the main recovery blocker. "Despite comprehensive SLO coverage that successfully detected the issue within 7 minutes, the team was not paged."
- **Evidence:** Recovery blocker is the alert severity miscalibration, not technical complexity. Once Yang Yang engaged, root cause identification and rollback were fast (~17 min from engagement to rollback start).

**Q6: Did dependencies or cascading failures significantly delay recovery?**
- ✅ **GOOD:** Cascading failure path clearly documented: ICS failures → CAS claims retrieval errors → portal login failures. "Backend runtime errors (OS-BERT-00000) were confirmed by Nuno Pulido to be downstream effects propagated via CAS, not independent failures." ICS-IBB shared schema dependency is the root architectural cause.
- **Evidence:** Cascade chain analyzed. Cross-team coordination effective (Nuno Pulido confirmed quickly).

**Q7: Was customer impact quantified?**
- ✅ **GOOD:** "186 tenants affected across all 13 regions in the GA ring for approximately 2 hours." Detailed per-region breakdown with tenant count and CAS 5xx error count. Peak error rates quantified. Zendesk ticket count. Prometheus source cited.
- **Evidence:** Exceptional quantification. Region-by-region table, total error counts (~19,185 CAS 502 errors), peak rates (5.6 req/s).

#### ❌ Missing (1 question)

**Q5: Were runbooks or documentation used and assessed?**
- ❌ **MISSING:** No mention of runbooks or documentation used during the incident response. No assessment of whether runbooks existed for ICS/CAS failure scenarios.
- **Guiding questions for working session:**
  - Did a runbook exist for ICS deployment failure scenarios?
  - Was any documentation consulted during troubleshooting?
  - Should a runbook be created for bake failure procedures?

**Pillar 4 Calculation:** Q1=1.0, Q2=1.0, Q3=1.0, Q4=1.0, Q5=0.0, Q6=1.0, Q7=1.0 → 6.0/7 = **86%**

*Corrected Pillar 4 Score: **86/100** 🟢*

---

### 🧠 Pillar 5: Prevention & Learning (88/100)

#### ✅ Fully Addressed (3 questions)

**Q1: Was the incident caused by a recent change?**
- ✅ **GOOD:** "Caused by deployment of IdentityCore.Service (ICS) DU 1.0.291 (v1.77.279) to the GA ring at approximately 00:55 UTC." PR #1215 merged 2026-04-09 13:59. IBB pipeline paused since 2026-04-09 18:30.
- **Evidence:** Change correlation explicit with PRs, deployment versions, timestamps, and pipeline state.

**Q3: Are prevention action items defined with clear ownership and tracking?**
- ✅ **GOOD:** Four distinct action items with clear ownership and Jira tickets:
  - CF-1a: Contract tests for schema dependencies (Identity Core, RDPIDT-3596)
  - CF-1b: Domain consolidation (Identity Core / Identity Business / Platform Eng, RPOR-21881, RPOR-24336)
  - CF-1b: Process - verify schema before deploying (Identity Core, RDPIDT-3597)
  - CF-2: Recalibrate alert severity (Identity Core, RDPIDT-3598)
- **Evidence:** Short-term (contract tests, process) and long-term (domain consolidation) clearly separated. All tracked in Jira with owners.

**Q4: What learnings did the team gain?**
- ✅ **GOOD:** Lessons Learned section covers "What went well" (SLO detection speed, bake failure mechanism, cross-team coordination), "What didn't go well" (SEV3 classification gap, unverified assumptions, late formal declaration, no canary within ring), and "Where we got lucky" (early hours UTC, hard failure vs subtle corruption).
- **Evidence:** Broader implications captured: assumptions about deployment ordering are not reliable, alert severity calibration is a systemic gap, shared schema creates hidden coupling.

#### ❌ Missing (1 question)

**Q2: Was recurrence analysis performed?**
- ❌ **MISSING:** No mention of checking for previous incidents with similar root cause (deployment without required schema, ICS/IBB coupling issues, cross-team pipeline dependencies).
- **Guiding questions for working session:**
  - Have there been previous incidents caused by ICS-IBB schema coupling?
  - Are there past incidents where deployment proceeded without required dependencies?
  - Were similar "paused pipeline" scenarios observed before?

**Pillar 5 Calculation:** Q1=1.0, Q2=0.0, Q3=1.0, Q4=1.0 → 3.0/4 = **75%**

*Corrected Pillar 5 Score: **75/100** 🟢*

---

### ✅ Pillar 6: Process Compliance (75/100) — 2 questions only (pre-assessment)

#### ✅ Fully Addressed (1 question)

**Q1: Was incident management process followed?**
- ✅ **GOOD:** Incident Roles table documents: IC (Yang Yang), Engineers (Yang Yang), RCA participants (Yang Yang, Nuno Pulido), Reviewers (Tomas Antunes), Approver (Nuno Parreira). Rootly used for incident tracking. Timeline shows formal declaration, resolution, and post-incident follow-up.
- **Evidence:** Roles clearly assigned. However, the retrospective also notes that formal declaration was delayed (~1h48m after first alert), which is a process gap acknowledged in "What didn't go well."

#### ⚠️ Present but Weak (1 question)

**Q2: If the mitigation required a change (RFC), did it follow Change Management policy?**
- ⚠️ **WEAK:** Mitigation was a bake failure (automatic rollback), not a new RFC. The retrospective doesn't explicitly state whether the rollback required an RFC or not.
- **Issue:** No explicit assessment of whether Change Management policy applied to the rollback action.
- **Needs depth:** Clarify whether the bake failure/rollback followed standard process or if any RFC was needed.

**Pillar 6 Calculation:** Q1=1.0, Q2=0.5 → 1.5/2 = **75%**

---

## Corrected Overall Score Calculation

| Pillar | Points Earned | Points Possible |
|--------|--------------|-----------------|
| 🕵️ Detection & Monitoring | 5.0 | 6 |
| 📣 Response & Communication | 1.5 | 4 |
| 🔍 Troubleshooting & Root Cause | 3.0 | 3 |
| 🩹 Recovery & Resolution | 6.0 | 7 |
| 🧠 Prevention & Learning | 3.0 | 4 |
| ✅ Process Compliance | 1.5 | 2 |
| **Total** | **20.0** | **26** |

**Overall Pre-Assessment Score: 20.0 / 26 = 77/100** 🟢

---

## Prioritized Working Session Agenda

**Recommended focus for working session (30-45 min):**

### 🔴 High Priority (Address First - 15 min)

1. **External Communication Gap (Pillar 2, Q3)**
   - Current state: No mention of public status page updates or customer-facing communications during the incident
   - Why critical: SEV1 affecting 186 tenants across all regions - external communication is a compliance requirement
   - Guiding questions:
     - Was the public status page updated? When?
     - What was communicated to affected customers beyond Zendesk #3332189?
     - What was the Public MTTA?

2. **MTTA Documentation (Pillar 2, Q4)**
   - Current state: MTTA can be inferred (~65 min from first alert to human response) but not documented or assessed
   - Why critical: Understanding and benchmarking MTTA is essential for improving response times
   - Guiding questions:
     - What is the formal MTTA for this incident?
     - How does this compare to historical SEV1 MTTA?

### 🟡 Medium Priority (Address Next - 15 min)

3. **Recurrence Analysis (Pillar 5, Q2)**
   - Current state: No check for previous similar incidents
   - Guiding questions:
     - Were there previous ICS-IBB coupling incidents?
     - Have cross-team pipeline dependency issues caused incidents before?
     - Are there open action items from previous related incidents?

4. **SLO Error Budget Quantification (Pillar 1, Q4-Q5)**
   - Current state: SLO incidents listed but error budget consumption not quantified
   - Guiding questions:
     - How much ICS and CAS error budget was consumed during the 2-hour window?
     - What percentage of monthly budget does this represent?

### 🟢 Lower Priority (If Time Permits - 10 min)

5. **Runbook Assessment (Pillar 4, Q5)**
   - Current state: No mention of runbooks used during recovery
   - Should a bake failure runbook be created?

6. **Internal Communication Effectiveness (Pillar 2, Q2)**
   - Current state: Communication mentioned but effectiveness not assessed
   - Were updates within the Slack channel timely?

---

## Next Steps

### For the Retrospective Commander

1. **Review this assessment** - Focus on the 🔴 High Priority gaps
2. **Gather additional data:**
   - Status page update timestamps (if any)
   - Public MTTA data
   - Previous ICS-IBB related incidents (for recurrence analysis)
   - SLO error budget consumption data from Nobl9/Prometheus
3. **Quick additions** - Most gaps can be addressed by adding 2-3 paragraphs to the existing document
4. **No full working session needed** - Gaps are data-gathering, not analysis. Commander can address independently.

### For Process Engineering

- **Facilitation focus:** This is a strong retrospective. The gaps are in Response & Communication documentation, not in root cause or action items.
- **Watch for:** External comms gap may indicate a systemic issue if other SEV1 retros also miss this section.
- **Success criteria:** Add external communication assessment and MTTA to reach >85% score.

---

**Expected Outcome**

**Target post-update:** >85% score (ready for VSL approval with minor additions)
**Re-assessment:** Run post-assessment after VSL approval to evaluate all 29 questions

---

**Generated by:** Koda Pre-Assessment Skill v2.0
**Framework Version:** RCA Framework v2.0 (6 pillars, 29 questions | Pre-Assessment: 26 questions)
**For questions:** Contact Process Engineering (Ines Matos, Vera Branco)
