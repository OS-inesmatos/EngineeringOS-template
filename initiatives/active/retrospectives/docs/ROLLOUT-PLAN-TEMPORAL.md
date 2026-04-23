# Retrospectives Process — Temporal Rollout Plan

**Version:** 1.0
**Created:** 2026-04-21
**Owner:** Inês Matos, Vera Branco
**Status:** Active — Week-by-week execution plan

---

## Executive Summary

**Goal:** Roll out new retrospective ownership model (EM/TL-led, Koda skill-based assessment, collaborative working sessions) to replace current SRE-led bottleneck process.

**Timeline:** April 21 – August 31, 2026 (19 weeks)

**Critical Success Factors:**
1. Koda skill operational and integrated into workflow by June 1
2. 5-10 pilot retrospectives completed with positive feedback by June 30
3. <45 day lead time achieved by end of Q3

**Current Status (Week of April 21):**
- ✅ Presentation delivered April 13 to VS Leaders + EMs
- ✅ RCA Framework v1.8 finalized (29 questions, 6 pillars)
- ✅ Scoring Guide v1.3 published
- ⏳ Koda skill development in progress
- ⏳ Brown Bag sessions not yet scheduled

---

## Phase Overview

| Phase | Dates | Focus | Key Milestone |
|-------|-------|-------|---------------|
| **Preparation** | Apr 21 – May 31 (6 weeks) | Build enablement materials, Koda skill, Brown Bags | Skill operational by June 1 |
| **Pilot** | Jun 1 – Jun 30 (4 weeks) | Test with 5-10 mature teams | Proven model by June 30 |
| **Rollout** | Jul 1 – Jul 31 (4 weeks) | Expand to all teams | 100% adoption by July 31 |
| **Optimize** | Aug 1 – Aug 31 (4 weeks) | Measure, iterate, scale | <45 day lead time achieved |

---

## Preparation Phase: April 21 – May 31 (6 weeks)

**Goal:** Build all enablement materials, operationalize Koda skill, train teams

---

### Week 1: April 21–27

**Theme:** Finalize framework documentation + begin skill development

#### Deliverables

| # | Deliverable | Owner | Due | Status |
|---|-------------|-------|-----|--------|
| 1.1 | Review and publish RCA Framework Pillars v1.8 to Confluence | Inês | Apr 23 | ⏳ |
| 1.2 | Review and publish Scoring Guide v1.3 to Confluence | Inês | Apr 23 | ⏳ |
| 1.3 | Review and publish Change Management Patterns v1.0 to Confluence | Inês | Apr 23 | ⏳ |
| 1.4 | Create Confluence Quick Reference card (1-page) for EM/TLs | Inês | Apr 25 | ⏳ |
| 1.5 | Draft Koda skill prompt (input: retro doc, output: score + gaps) | Inês, Parreira | Apr 27 | ⏳ |
| 1.6 | Align with Parreira on skill integration before his departure | Inês | Apr 25 | 🔴 CRITICAL |

#### Risks
- 🔴 **Parreira departure timing** — If skill integration not documented, handoff will block pilot
  - **Mitigation:** Schedule 1-hour working session with Parreira by April 24

---

### Week 2: April 28 – May 4

**Theme:** Skill development + process documentation

#### Deliverables

| # | Deliverable | Owner | Due | Status |
|---|-------------|-------|-----|--------|
| 2.1 | Koda skill MVP functional (assess 1 retro, output score + gaps) | Inês, Parreira | May 2 | ⏳ |
| 2.2 | Test skill against 3 historical retrospectives (RDINC-72566, RDINC-55778, RDINC-49925) | Inês | May 4 | ⏳ |
| 2.3 | Validate skill output: compare AI score vs manual assessment | Inês, Vera | May 4 | ⏳ |
| 2.4 | Create Process SLA dashboard spec (control points, OLAs) | Inês | May 4 | ⏳ |
| 2.5 | Draft Confluence Operational Guide (7-step process) | Vera | May 4 | ⏳ |
| 2.6 | Map Faulty Assets → Owning Teams (Confluence or EOM) | Vera, João | May 4 | ⏳ |
| 2.7 | Define Jira custom fields needed (see Jira Requirements section below) | Inês | May 4 | ⏳ |

#### Checkpoint
- **Go/No-Go Decision Point:** Skill MVP functional and validated by May 4?
  - **Yes** → Continue to Brown Bag prep
  - **No** → Delay pilot by 2 weeks, focus on skill stabilization

---

### Week 3: May 5–11

**Theme:** Brown Bag preparation + pilot team selection

#### Deliverables

| # | Deliverable | Owner | Due | Status |
|---|-------------|-------|-----|--------|
| 3.1 | Identify 5-10 pilot teams (mature teams with recent incidents) | Vera, João | May 7 | ⏳ |
| 3.2 | Reach out to pilot team EMs/TLs for commitment | Vera | May 9 | ⏳ |
| 3.3 | Create Brown Bag slide deck (problem, solution, demo, Q&A) | Inês, Vera | May 9 | ⏳ |
| 3.4 | Schedule Brown Bag sessions (3 sessions: May 19, May 21, May 23) | Inês | May 11 | ⏳ |
| 3.5 | Validate with João/Vera: when does Internal Communications motion disappear? | Inês | May 7 | ⏳ |
| 3.6 | Create Jira ticket for admin: add custom fields (Owning Team, Retro Commander, Quality Score, dates) | Inês | May 11 | ⏳ |
| 3.7 | Record async Brown Bag video (30min walkthrough) | Inês, Vera | May 11 | ⏳ |

#### Pilot Team Criteria
- Mature teams (Identity-like)
- Dedicated SRE or strong operational maturity
- Recent system-wide incident (last 6 months)
- EM/TL willing to participate actively
- Target: 5-10 teams, at least 1 per Value Stream

---

### Week 4: May 12–18

**Theme:** Template creation + working session facilitation guide

#### Deliverables

| # | Deliverable | Owner | Due | Status |
|---|-------------|-------|-----|--------|
| 4.1 | Create standardized Confluence retrospective template | Vera | May 14 | ⏳ |
| 4.2 | Create RCA Working Session Facilitation Guide (for Process Eng) | Inês, Vera | May 16 | ⏳ |
| 4.3 | Define progressive autonomy tiers (Tier 1/2/3 criteria) | Inês | May 16 | ⏳ |
| 4.4 | Finalize PowerBI dashboard spec (SLA tracking) | Inês | May 18 | ⏳ |
| 4.5 | Test Koda skill integration with Confluence API (read retro doc) | Inês | May 18 | ⏳ |
| 4.6 | Jira admin: create custom fields (Owning Team, Retro Commander, Quality Score, dates) | Jira Admin | May 16 | ⏳ |
| 4.7 | Test Jira fields in sandbox RDINC issue | Inês | May 18 | ⏳ |

#### RCA Working Session Facilitation Guide
**Contents:**
- Pre-session: Run skill, review gaps, prepare agenda
- During session: Focus on ❌ and ⚠️ questions, collaborative discussion
- Post-session: Update doc, re-run skill, compare before/after score
- Tier-based facilitation (Tier 1: Process Eng leads, Tier 2: Co-facilitate, Tier 3: Observe)

---

### Week 5: May 19–25

**Theme:** Brown Bag sessions + skill finalization

#### Deliverables

| # | Deliverable | Owner | Due | Status |
|---|-------------|-------|-----|--------|
| 5.1 | Conduct Brown Bag Session #1 (May 19, 2pm) | Inês, Vera | May 19 | ⏳ |
| 5.2 | Conduct Brown Bag Session #2 (May 21, 10am) | Inês, Vera | May 21 | ⏳ |
| 5.3 | Conduct Brown Bag Session #3 (May 23, 3pm) | Inês, Vera | May 23 | ⏳ |
| 5.4 | Implement Jira automation: Auto-assign Retrospective Commander | Inês | May 23 | ⏳ |
| 5.5 | Implement Jira automation: SLA breach alerts (Slack) | Inês | May 25 | ⏳ |
| 5.4 | Collect feedback from Brown Bags, iterate on messaging | Inês | May 24 | ⏳ |
| 5.5 | Finalize Koda skill with feedback loop (iterate based on pilot) | Inês | May 25 | ⏳ |

#### Brown Bag Agenda (60min)
1. **Problem statement** (10min) — Current bottleneck, 72-day lead time, reviewer shrinkage
2. **New model overview** (15min) — EM/TL ownership, skill-based assessment, working sessions
3. **Framework walkthrough** (10min) — 6 pillars, 29 questions, scoring
4. **Koda skill demo** (10min) — Live assessment of sample retro
5. **Process walkthrough** (10min) — 7 steps, SLAs, progressive autonomy
6. **Q&A** (5min)

---

### Week 6: May 26 – June 1

**Theme:** Final prep + pilot kickoff

#### Deliverables

| # | Deliverable | Owner | Due | Status |
|---|-------------|-------|-----|--------|
| 6.1 | Publish all Confluence documentation (framework, guide, template) | Inês, Vera | May 28 | ⏳ |
| 6.2 | Send pilot kickoff email to selected teams | Vera | May 29 | ⏳ |
| 6.3 | Schedule RCA working sessions for pilot retrospectives | Inês | May 30 | ⏳ |
| 6.4 | Finalize PowerBI dashboard for SLA tracking (Time to Draft, Time to Session, Time to Approval) | Inês | Jun 1 | ⏳ |
| 6.5 | Communicate pilot start to leadership (João, Vera) | Vera | Jun 1 | ⏳ |

#### Checkpoint
- **Go/No-Go Decision Point:** All materials ready, pilot teams committed by June 1?
  - **Yes** → Start pilot
  - **No** → Delay pilot by 1 week, finalize gaps

---

## Pilot Phase: June 1 – June 30 (4 weeks)

**Goal:** Test new model with 5-10 mature teams, validate skill accuracy, gather feedback

---

### Week 7–10: June 1–30

**Theme:** Execute pilot, iterate based on feedback

#### Target Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| Pilot retrospectives completed | 5-10 | Count of retros closed |
| Average lead time | <45 days | Incident resolution → retro closure |
| Skill accuracy | >80% | AI score vs manual assessment |
| EM/TL satisfaction | >70% positive | Post-pilot survey |
| Before/after score delta | +20-30% avg | Skill pre-session vs post-session |

#### Weekly Cadence (Weeks 7-10)

**Monday:**
- Review dashboard: which pilot retros are in progress?
- Check SLA adherence: Time to Draft, Time to Session, Time to Approval
- Identify blockers or delays

**Wednesday:**
- Facilitate 1-2 RCA working sessions (Tier 1: Process Eng leads)
- Run skill pre-session, drive agenda from gaps
- Post-session: re-run skill, document before/after score

**Friday:**
- Collect feedback from EM/TLs: What worked? What didn't?
- Update framework or process if patterns emerge
- Report to leadership: pilot progress, key learnings

#### Pilot Retrospectives

| Team | Incident | EM/TL | Status | Lead Time | Before/After Score |
|------|----------|-------|--------|-----------|---------------------|
| [TBD] | [TBD] | [TBD] | ⏳ | — | — |
| [TBD] | [TBD] | [TBD] | ⏳ | — | — |
| [TBD] | [TBD] | [TBD] | ⏳ | — | — |
| [TBD] | [TBD] | [TBD] | ⏳ | — | — |
| [TBD] | [TBD] | [TBD] | ⏳ | — | — |

*(Fill in during Week 3: May 5-11)*

#### Risks During Pilot

| Risk | Impact | Mitigation |
|------|--------|------------|
| Teams don't prioritize retrospectives | Pilot stalls | Escalate to VS Leaders, enforce SLAs |
| Skill produces inaccurate assessments | Lost credibility | Manual validation, iterate skill prompt |
| EM/TLs lack RCA capability | Low-quality retros | Process Eng facilitates more actively (Tier 1) |
| VSL approval delays | Pilot lead time exceeds target | Pre-align with VSLs on approval cadence |

---

### Checkpoint: June 30

**Go/No-Go Decision Point:** Expand to all teams?

**Criteria:**
- ✅ 5+ pilot retrospectives completed
- ✅ Average lead time <50 days (allow 5-day buffer)
- ✅ Skill accuracy >75%
- ✅ EM/TL feedback >60% positive
- ✅ No major process blockers identified

**If Yes:**
- Proceed to full rollout July 1
- Communicate success to leadership
- Publish pilot results and learnings

**If No:**
- Extend pilot by 2 weeks (July 1-14)
- Address identified gaps
- Re-evaluate July 14

---

## Rollout Phase: July 1 – July 31 (4 weeks)

**Goal:** Expand to all teams, achieve 100% adoption of new model

---

### Week 11: July 1–6

**Theme:** Rollout communication + training

#### Deliverables

| # | Deliverable | Owner | Due | Status |
|---|-------------|-------|-----|--------|
| 11.1 | Send rollout announcement to all EMs/TLs | Vera, João | Jul 2 | ⏳ |
| 11.2 | Publish pilot results and success stories | Inês | Jul 3 | ⏳ |
| 11.3 | Schedule additional Brown Bag sessions for missed teams | Inês | Jul 4 | ⏳ |
| 11.4 | Update Confluence documentation with pilot learnings | Inês, Vera | Jul 6 | ⏳ |

#### Rollout Announcement
**Key messages:**
- Pilot successful: [X] retros completed, [Y]% lead time reduction
- New model operational July 1
- EM/TL assigned as Retrospective Commander for all new system-wide incidents
- Support available: Process Eng facilitates working sessions, SRE provides consultancy
- Expectations: <45 day lead time, quality score >70%

---

### Week 12–14: July 7–27

**Theme:** Full adoption, active facilitation

#### Weekly Cadence (Weeks 12-14)

**Monday:**
- Review dashboard: all active retrospectives
- Identify retrospectives at risk (SLA breach imminent)
- Reach out to EM/TLs for blockers

**Tuesday/Wednesday/Thursday:**
- Facilitate 3-5 RCA working sessions per week
- Progressive autonomy: move mature teams to Tier 2 (co-facilitate)
- Track before/after scores, report improvements

**Friday:**
- Leadership report: retrospectives by status, lead time trends, quality scores
- Identify teams needing additional support
- Plan next week's working sessions

#### Target Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| Active retrospectives using new model | 100% | All new system-wide incidents |
| Average lead time | <50 days | Trending toward <45 days |
| Quality score | >70% | Framework-based assessment |
| Time to Draft | <3 days | Incident resolution → draft created |
| Time to RCA Session | <7 days | Draft created → session held |
| Time to VSL Approval | <5 days | Session → VSL approval |

---

### Week 15: July 28 – August 3

**Theme:** Rollout retrospective + optimization planning

#### Deliverables

| # | Deliverable | Owner | Due | Status |
|---|-------------|-------|-----|--------|
| 15.1 | Conduct rollout retrospective with Process Eng team | Vera, Inês | Jul 30 | ⏳ |
| 15.2 | Analyze rollout data: lead time, quality scores, SLA adherence | Inês | Aug 1 | ⏳ |
| 15.3 | Identify 3-5 optimization priorities for August | Inês, Vera | Aug 3 | ⏳ |
| 15.4 | Report rollout results to VS Leaders | Vera, João | Aug 3 | ⏳ |

#### Rollout Retrospective Questions
1. What worked well during rollout?
2. What didn't work?
3. Where are teams still struggling?
4. What enablement gaps remain?
5. What should we iterate in August?

---

## Optimize Phase: August 1 – August 31 (4 weeks)

**Goal:** Measure outcomes, iterate based on data, achieve <45 day lead time

---

### Week 16–19: August 4–31

**Theme:** Data-driven iteration + progressive autonomy scaling

#### Focus Areas

**1. Progressive Autonomy Scaling**
- Move teams from Tier 1 (Process Eng leads) → Tier 2 (co-facilitate) → Tier 3 (self-led)
- Target: 30% of teams at Tier 2 or higher by end of August
- Process Eng focuses on Tier 1 teams (low maturity, low scores)

**2. Skill Optimization**
- Analyze skill accuracy: AI score vs manual assessment
- Iterate prompt based on false positives/negatives
- Target: >85% skill accuracy by end of August

**3. SLA Adherence**
- Focus on control points with highest variance
- Identify systemic blockers (e.g., VSL approval delays)
- Implement process improvements

**4. Quality Improvement**
- Track quality scores by team
- Identify teams with consistently low scores (<50%)
- Provide targeted support: 1:1 coaching, SRE consultancy

#### Weekly Cadence (Weeks 16-19)

**Monday:**
- Review dashboard: lead time trends, quality scores, SLA adherence
- Identify teams for progressive autonomy promotion (Tier 1 → Tier 2)
- Plan week's facilitation: which teams need Tier 1 support?

**Wednesday:**
- Monthly leadership report (first week of month)
- Metrics: lead time, quality score, SLA adherence, progressive autonomy distribution
- Success stories: teams achieving <45 day lead time

**Friday:**
- Skill accuracy review: compare AI vs manual assessments
- Framework iteration: any new questions or patterns emerging?
- Plan next week

#### Target Metrics (End of August)

| Metric | Target | Measurement |
|--------|--------|-------------|
| Average lead time | <45 days | Incident resolution → retro closure |
| Quality score | >80% | Framework-based assessment |
| SLA adherence: Time to Draft | >90% | <3 days |
| SLA adherence: Time to RCA Session | >85% | <7 days |
| SLA adherence: Time to VSL Approval | >80% | <5 days |
| Progressive autonomy: Tier 2+ | >30% | Teams at Tier 2 or Tier 3 |
| Skill accuracy | >85% | AI score vs manual assessment |

---

## Success Criteria (6-Month Horizon)

By **October 31, 2026** (6 months from rollout), we should achieve:

### Must-Have
- ✅ Retrospective lead time: <45 days (from 72 days baseline)
- ✅ Assignment latency: <3 days (from 11 days baseline)
- ✅ 90% of mandatory incidents have complete retrospective
- ✅ 0 issues without assigned Retrospective Commander

### Should-Have
- ✅ Retrospective quality score: >80% (based on framework)
- ✅ Koda skill effectively identifies quality gaps (>85% accuracy)
- ✅ 50% of teams at Tier 2+ (progressive autonomy)
- ✅ SRE capacity reallocated to strategic work (consultancy, not execution)

### Nice-to-Have
- ✅ Teams report higher autonomy and lower bureaucracy (survey)
- ✅ Correlation between retro quality and MTTR/detection ratio improvements
- ✅ Model exported to non-incident retrospectives (drills, changes)

---

## Communication Plan

### Stakeholder Groups

| Group | Frequency | Channel | Content |
|-------|-----------|---------|---------|
| **VS Leaders** | Monthly | Email + Confluence | Lead time trends, quality scores, success stories |
| **Engineering Managers** | Bi-weekly | Slack + Confluence | SLA adherence, teams needing support, process updates |
| **Team Leaders** | Weekly | Slack | Active retrospectives, working session schedule, quick wins |
| **Process Eng Team** | Daily | Standup | Dashboard review, facilitation schedule, blockers |

### Key Messages

**For EM/TLs:**
- "You're accountable for your team's retrospective quality — we're here to support you"
- "Less bureaucracy, more autonomy — own your incidents, own your learnings"
- "Skill gives you instant feedback — iterate before the working session"

**For VS Leaders:**
- "SRE bottleneck removed — teams now own their retrospectives"
- "Data-driven quality assurance — framework + skill replace manual review"
- "Lead time reduced from 72 to <45 days — faster learning, faster improvement"

**For SRE:**
- "Your expertise is now consultancy, not execution — guide, don't do"
- "Focus on strategic work: patterns, tooling, training"
- "Support teams on-demand, not on-schedule"

---

## Risk Register

| Risk | Probability | Impact | Mitigation | Owner |
|------|-------------|--------|------------|-------|
| **Koda skill integration blocked by Parreira departure** | High | High | Document integration before April 25, 1-hour working session | Inês |
| **EM/TLs don't prioritize retrospectives** | Medium | High | Enforce SLAs, escalate to VS Leaders, track publicly | Vera |
| **Skill produces inaccurate assessments** | Medium | Medium | Manual validation during pilot, iterate prompt | Inês |
| **VSL approval delays** | Medium | Medium | Pre-align on approval cadence, automate reminders | Vera |
| **Teams lack RCA capability** | High | Medium | Process Eng facilitates (Tier 1), Brown Bags, SRE consultancy | Inês, Vera |
| **PowerBI dashboard delays** | Low | Medium | Manual tracking via Confluence until dashboard ready | Inês |
| **Pilot fails to achieve <50 day lead time** | Low | High | Extend pilot, address blockers, re-evaluate criteria | Vera, Inês |
| **Faulty Asset not identified during troubleshooting** | Medium | High | Process Eng identifies manually during pilot, document gaps | Inês |
| **Internal Communications motion disappears before Jira fields ready** | Medium | High | Delay motion removal until Jira fields operational (align with João) | Vera |
| **Mapping Asset → Team is outdated** | Low | Medium | Monthly validation, EMs can reassign manually via Jira | Vera |
| **Jira admin capacity constraints** | Medium | Medium | Escalate to João/Vera, mark as critical blocker | Inês |

---

## Dependencies

### External Dependencies
- **Koda skill platform availability** — Skill must be integrated and operational by June 1
- **Confluence API access** — Skill needs to read retrospective documents
- **PowerBI dashboard development** — Process Eng or BI team to build SLA tracking dashboard
- **Jira admin availability** — Custom fields must be created by May 16

### Internal Dependencies
- **VS Leader buy-in** — Must enforce EM/TL accountability
- **Engineering Manager commitment** — Must prioritize retrospectives within SLAs
- **SRE availability** — Must provide consultancy on-demand during pilot and rollout
- **Faulty Asset identification** — Incident Commanders must identify owning team during troubleshooting
- **Asset → Team mapping maintenance** — João/Vera must maintain mapping table

---

## Jira & Automation Requirements

**Critical Gap:** When Internal Communications motion is removed, we need an automated way to identify which team caused the incident and assign the EM/TL as Retrospective Commander.

### Problem Statement

**Today (with Internal Communications motion):**
```
Incident → Rootly → Internal Communications Leader identified → 
Retrospective Commander assigned manually
```

**Future (when motion disappears):**
```
Incident → Faulty Asset identified → Owning Team lookup → 
EM/TL auto-assigned as Retrospective Commander
```

### Jira Custom Fields Required

| Field | Type | Purpose | Example |
|-------|------|---------|---------|
| **Faulty Asset** | Text/Component | Asset that caused the incident | "DUV", "NATS Operator", "Identity Service" |
| **Owning Team** | Select/Team | Team responsible for faulty asset | "ICE Team", "RDM Team", "Identity Team" |
| **Retrospective Commander** | User Picker | EM/TL of owning team (auto-populated) | "@João Silva (EM - ICE)" |
| **Retrospective Status** | Status | Lifecycle tracking | "Draft", "Skill Run", "Session Scheduled", "VSL Approval", "Closed" |
| **Quality Score** | Number (0-100) | Koda skill output | "68" |
| **Draft Created Date** | Date | SLA tracking: Time to Draft | "2026-05-10" |
| **Session Held Date** | Date | SLA tracking: Time to Session | "2026-05-17" |
| **VSL Approval Date** | Date | SLA tracking: Time to Approval | "2026-05-22" |

### Jira Automations

**Automation 1: Auto-assign Retrospective Commander**
```
Trigger: Issue transitioned to "Retrospective In Progress"
Condition: Faulty Asset is not empty
Action:
  - Look up Owning Team from Faulty Asset (mapping table)
  - Auto-assign Retrospective Commander = EM/TL of Owning Team
  - Send Slack notification to EM/TL
```

**Automation 2: SLA Breach Alerts**
```
Trigger: Daily scheduled (9am)
Condition: 
  - Status = "Draft" AND Days since incident resolved > 3
  OR Status = "Skill Run" AND Days since draft > 7
Action:
  - Send Slack alert to Retrospective Commander + Process Eng
  - Flag issue as "SLA at risk"
```

**Automation 3: Dashboard Data Push**
```
Trigger: Field updated (Draft Created Date, Session Held Date, VSL Approval Date)
Action:
  - Push data to PowerBI via API or export to CSV
  - Update control point metrics
```

### Asset → Team Mapping

**Implementation Options:**

**Option A: Confluence page (manual maintenance)**
- Publish mapping table in Confluence
- Teams update when ownership changes
- Jira automation reads from Confluence API
- **Pro:** Simple to implement
- **Con:** Manual maintenance overhead

**Option B: Jira Components (built-in)**
- Use Jira Components to represent assets
- Link Components to Teams via Jira settings
- Auto-populate Owning Team and EM/TL
- **Pro:** Built-in Jira functionality
- **Con:** Limited to Jira Project scope

**Option C: EOM API Integration**
- Query EOM (Engineering Organization Management) API
- Asset → Team → EM/TL lookup
- **Pro:** Auto-updated, accurate
- **Con:** Requires API integration work

**Recommendation for Pilot:** Option A (Confluence mapping table) — simplest to implement, can migrate to Option C post-pilot.

### Implementation Timeline

**Week 2-3 (Apr 28 – May 11):**
- Create Asset → Team mapping table (Confluence)
- Define Jira custom fields specification
- Validate with João/Vera: when does Internal Communications motion disappear?

**Week 4 (May 12-18):**
- Jira admin creates custom fields
- Test fields in sandbox RDINC issue

**Week 5 (May 19-25):**
- Implement Automation 1: Auto-assign Retrospective Commander
- Implement Automation 2: SLA breach alerts (Slack)
- Test automations in sandbox

**Week 6 (May 26 – Jun 1):**
- PowerBI integration with Jira fields (Automation 3)
- Validate dashboard with historical data

### Transition Plan (Internal Communications Motion)

**Short-term (Pilot Phase - June):**
- Internal Communications motion still active
- Use existing mechanism as fallback
- Jira fields populated manually if needed
- Validate automation accuracy

**Long-term (Post-Rollout - August+):**
- Internal Communications motion can be safely removed
- Jira automation fully operational
- Asset → Team mapping maintained by VS Leaders/EMs
- Process Eng monitors automation accuracy

### Success Criteria

- ✅ 90% of incidents have Retrospective Commander auto-assigned within 24h
- ✅ SLA breach alerts trigger correctly (no false positives)
- ✅ PowerBI dashboard receives data from Jira fields in real-time
- ✅ Asset → Team mapping accuracy >95% (validated monthly)

---

## Metrics Dashboard (PowerBI)

### Control Points

**Lead Time Funnel:**
```
Incident Resolved → Draft Created → Skill Run → RCA Session → Doc Updated → VSL Approved → Closed
       (3 days)        (1 day)     (7 days)       (2 days)       (5 days)
```

**SLA Tracking:**
- Time to Draft: <3 days (EM/TL accountable)
- Time to Skill Assessment: <1 day (EM/TL accountable)
- Time to RCA Session: <7 days (Process Eng + EM/TL accountable)
- Time to Document Update: <2 days (EM/TL accountable)
- Time to VSL Approval: <5 days (VSL accountable)
- **Total Lead Time: <45 days** (end-to-end)

**Quality Metrics:**
- Quality score distribution (by team, by pillar)
- Before/after score delta (working session value-add)
- Skill accuracy (AI score vs manual assessment)
- Progressive autonomy distribution (Tier 1/2/3)

**Volume Metrics:**
- Active retrospectives (by status, by age)
- Retrospectives completed per week
- Retrospectives at risk (SLA breach imminent)

---

## Weekly Execution Template

**For Process Eng team use during rollout**

### Monday Standup (15min)
1. Dashboard review: active retrospectives, SLA status
2. This week's RCA working sessions: schedule and prep
3. Blockers or escalations needed?

### Wednesday Working Sessions (2-3 per week)
- Pre-session: Run skill, review gaps, prepare agenda
- During session: Facilitate discussion, focus on ❌ and ⚠️ questions
- Post-session: Update doc, re-run skill, document before/after score

### Friday Retrospective (15min)
1. What worked this week?
2. What didn't work?
3. What should we iterate?
4. Leadership report: key metrics and highlights

---

## Change Log

**Version 1.1 (2026-04-21)**
- Added Jira & Automation Requirements section
- Defined custom fields needed (Faulty Asset, Owning Team, Retro Commander, Quality Score, dates)
- Specified 3 Jira automations (auto-assign, SLA alerts, dashboard push)
- Added Asset → Team mapping options (Confluence, Jira Components, EOM API)
- Updated Weeks 2-5 deliverables with Jira implementation tasks
- Added 4 new risks to Risk Register (Faulty Asset identification, motion timing, mapping accuracy, Jira admin capacity)

**Version 1.0 (2026-04-21)**
- Initial temporal rollout plan created
- Week-by-week milestones from April 21 – August 31, 2026
- Phase breakdown: Preparation (6 weeks), Pilot (4 weeks), Rollout (4 weeks), Optimize (4 weeks)
- Deliverables, owners, checkpoints, and risk mitigation defined

---

**Document Owner:** Inês Matos, Vera Branco
**Status:** Active — Execute week-by-week
**Related Documents:**
- [PROPOSAL-NEW-MODEL.md](./PROPOSAL-NEW-MODEL.md) — Full retrospective transformation proposal
- [RCA-FRAMEWORK-PILLARS.md](./RCA-FRAMEWORK-PILLARS.md) — Quality framework (29 questions, 6 pillars)
- [RCA-FRAMEWORK-SCORING-GUIDE.md](./RCA-FRAMEWORK-SCORING-GUIDE.md) — Scoring criteria
- [CHANGE-MANAGEMENT-PATTERNS.md](./CHANGE-MANAGEMENT-PATTERNS.md) — Pillar 6, Q2 reference
