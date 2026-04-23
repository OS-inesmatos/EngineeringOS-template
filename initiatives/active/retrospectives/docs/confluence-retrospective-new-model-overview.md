# New Retrospective Model — Overview

**Status:** Active  
**Effective:** Q2 2026 (Pilot: June 2026)  
**Last Updated:** 2026-04-23 (v1.2 - Corrected approval flow: VSL approval before post-assessment)

---

## What Changed?

### From: SRE-Led, Presentation-Based
- SRE leads all retrospectives
- Teams present finished work to reviewers
- Volunteer reviewer approval required

### To: Team-Led, Collaboration-Based
- **EM/TL of incident-causing team** leads retrospective
- **Collaborative working sessions** replace presentations
- **Framework-guided quality** replaces reviewer approval

---

## Why This Matters

**Current problems:**
- 72-day average lead time (2.4 months!)
- SRE operational capacity exceeded
- Reviewer pool shrinking (63% done by 2 people)
- Action items not executed → incidents recur

**New model solves:**
- ✅ Decentralizes ownership → faster execution
- ✅ Eliminates reviewer bottleneck → no more waiting
- ✅ Framework-based quality → objective, consistent
- ✅ Recurrence detection → prevents repeat failures

---

## How It Works — 7 Steps

```
1. Commander Assigned (EM/TL) → 2. Draft Created → 3. Pre-Assessment → 
4. Working Session → 5. Document Updated → 6. VSL Approval → 7. Post-Assessment
```

**Timeline:** <45 days (~35% faster than current 72 days)

---

## When Retrospectives Are Required

Retrospectives are **mandatory** for:

- ✅ **All incidents posted to external status page**
- ✅ **High/Critical incidents with customer impact**
- ✅ **Incidents with recurrence patterns**
- ✅ **Near-misses with high potential impact**

**Future refinement:** Once Service Incidents vs Customer Incidents classification is implemented (M3.3), scope will be refined to Service Incidents SEV1 and SEV2.

---

## Key Concepts

### 1. Retrospective Commander = EM/TL

**Who:** Engineering Manager or Team Leader of team owning faulty asset

**Accountable for:**
- Retrospective completion within <45 days
- Quality sufficient for VSL approval
- Action items defined with owners

**Can delegate:**
- Document writing
- Assessment execution
- Working session prep

**Cannot delegate:**
- Accountability
- Final sign-off

---

### 2. Framework-Based Quality (6 Pillars)

Every retrospective assessed against **6 pillars:**

1. 🕵️ **Detection & Monitoring** — How was incident detected?
2. 📣 **Response & Communication** — Was response timely?
3. 🔍 **Troubleshooting & Root Cause** — Is root cause clear?
4. 🩹 **Recovery & Resolution** — How quickly recovered? Did team lack confidence?
5. 🧠 **Prevention & Learning** — What prevents recurrence?
6. ✅ **Process Compliance** — Was process followed?

**Assessment:** Pre-assessment guides working session, post-assessment measures final quality

**Approval:** VSL evaluates using critical judgment, not fixed score threshold

---

### 3. Working Sessions (Not Presentations)

**Old way:** Team presents finished retrospective, reviewers approve

**New way:** Team **executes RCA collaboratively** in working session

**How it works:**
1. Pre-assessment identifies gaps (missing/weak sections)
2. Working session focuses on filling gaps
3. Process Eng facilitates discussion
4. Document updated with insights
5. VSL approves using critical judgment
6. Post-assessment measures final quality (for metrics)

**Example:**
- Pre-score: 45% (many gaps)
- Working session: Fill gaps, deepen analysis
- VSL approves
- Post-score: 85% (improvement measured)

---

### 4. Progressive Autonomy

Teams gain independence based on maturity:

| Tier | Score Range | Facilitation Level |
|------|-------------|-------------------|
| **Tier 1 (New)** | 0-40% | Process Eng fully facilitates |
| **Tier 2 (Improving)** | 40-70% | Team co-facilitates, Process Eng observes |
| **Tier 3 (Mature)** | 70-100% | Team self-leads, Process Eng consults only |

**Goal:** High-maturity teams operate independently, Process Eng supports teams that need it.

---

### 5. Recurrence Detection

Framework checks: **"Is this a recurring issue?"**

**If yes:**
- Were previous retrospectives completed?
- Were action items executed?
- If not → red flag, escalate to leadership

**Prevents:** Same incident recurring because action items ignored.

---

## Roles & Responsibilities

### Retrospective Commander (EM/TL)
- Create draft within 3 days
- Run pre-assessment
- Lead or delegate working session attendance
- Update document within 2 days post-session
- Submit for VSL approval when document is complete

### Process Engineering
- Assign Commander within 3 days of incident closure
- Facilitate working sessions (initially)
- Track SLAs, escalate delays
- Monitor quality metrics

### Value Stream Leader
- Approve retrospective within 5 days
- Strategic oversight
- Escalate systemic issues

### SRE
- **New role: Advisory only**
- Attend working sessions when requested
- Provide guidance, not execution

### Quality Team
**Joins retrospectives when incident involves:**
- Testing gaps identified
- Quality gate failures or bypasses
- Bug escape analysis (customer-reported vs internal detection)

**Quality provides:**
- Testing gap assessment and recommendations
- Quality improvement suggestions
- Quality metrics baseline for improvement tracking

**Contact:** Vijay (Quality Lead)

### Global Support (GS)
- Join retrospectives when needed (e.g., when they have context on missing information or questions they want answered)
- GS handles customer-facing RCA communication based on retrospective outcomes

---

## Timeline & SLAs

| Step | SLA | Owner |
|------|-----|-------|
| Commander assigned | <3 days | Process Eng |
| Draft created | <3 days | EM/TL |
| Pre-assessment | <1 day | EM/TL |
| Working session | <7 days | Process Eng + EM/TL |
| Document updated | <2 days | EM/TL |
| VSL approval | <5 days | VSL |
| Post-assessment | <2 days | Process Eng |
| **Total** | **<45 days** | **End-to-end** |

**Current average:** 72 days → **Target:** 45 days (~35% reduction)

---

## Tools & Automation

### Now (Pilot Phase)
- **Manual:** Confluence docs, framework spreadsheet
- **Process Eng:** Working session facilitation

### Coming Soon (Q2-Q3 2026)
- **Koda skill:** Auto-generate draft from incident data
- **Koda skill:** `/assess-retrospective` for pre/post scoring
- **Recurrence detection:** Auto-flag similar past incidents
- **PowerBI dashboards:** Lead time, quality scores, patterns

---

## Metrics Tracked

**Process:**
- Lead time (target: <45 days)
- Assignment latency (target: <3 days)
- % completed within SLA

**Quality:**
- Average post-assessment score by team
- Quality score distribution (>70%, 40-70%, <40%)
- Pre vs post-assessment improvement delta
- Both pre and post scores stored per retrospective to measure working session effectiveness

**Outcome:**
- Incident recurrence rate
- Action item completion rate
- MTTR trends
- Detection ratio (proactive vs reactive)

---

## Getting Started

### If You're Assigned as Commander

1. **Notification:** Jira + Slack when assigned
2. **Review guide:** [Operational Guide (detailed step-by-step)](link-to-operational-guide)
3. **Create draft:** Use template, pull from incident data
4. **Pre-assess:** Review against [6 pillars](link-to-pillars)
5. **Working session:** Schedule with Process Eng
6. **Update & submit:** When document is complete and critical gaps addressed

**First time?** Process Eng will guide you through each step.

---

### If You're Facilitating (Process Eng)

1. **Before session:** Review pre-assessment with Commander
2. **During session:** Guide discussion using framework gaps
3. **After session:** Support document update, track approval
4. **Progressive autonomy:** Gradually hand over to mature teams

---

## Quick Links

- **[Operational Guide (detailed)](link)** — Step-by-step instructions for all 7 steps
- **[RCA Framework Pillars](link)** — Detailed pillar questions and quality signals
- **[Retrospective Template](link)** — Confluence template for drafts
- **[Full Proposal](link)** — Complete context and rationale for new model

---

## FAQ

**Q: Why is EM/TL the Commander?**  
A: They have deepest context on their team's systems, incidents, and technical debt. They're already accountable for team quality — retrospectives are part of that accountability.

**Q: Can I delegate?**  
A: Yes, you can delegate execution (writing, assessment) to team members. But accountability stays with you.

**Q: What if I miss the SLA?**  
A: Process Eng monitors and will flag delays. If blocked, reach out early. Repeated misses trigger support.

**Q: Do I need a working session if my pre-assessment looks strong?**  
A: High-maturity teams can request to skip if pre-assessment shows good coverage. This is progressive autonomy.

**Q: What quality standard must I meet for VSL approval?**  
A: VSL evaluates using critical judgment: Is root cause clear? Are action items specific? Did the team learn? No fixed score threshold — focus on depth and quality.

**Q: What if we find a recurring issue?**  
A: Flag immediately. If previous action items weren't executed, escalate to your EM and VSL. This triggers problem management (M3.4).

---

## Support

**Need help?**
- **Process Engineering:** Inês Matos, Vera Branco
- **SRE (advisory):** Pedro Charola Alves
- **Slack:** #retrospectives-support (coming soon)

---

## Changelog

**v1.2 (2026-04-23):**
- Corrected process flow: Post-assessment now Step 7 (after VSL approval), not Step 6
- Removed fixed ">70% threshold" for approval — VSL uses critical judgment
- Clarified post-assessment is for metrics, not approval gate
- Updated timeline: baseline changed from Day 21 to Day 23
- Added FAQ: "What quality standard must I meet for VSL approval?"
- Updated Pillar 4 to include "Did team lack confidence?"
- **Added:** Pre and post scores stored per retrospective to measure working session effectiveness
- **Assessment scope:** Pre-assessment evaluates 26 questions (excludes Pillar 6 Q3-Q5), post-assessment evaluates all 29 questions

**v1.1 (2026-04-15):**
- Added mandatory criteria & Quality involvement

**v1.0 (2026-04-08):**
- Initial version

---

**Document Owner:** Inês Matos, Vera Branco  
**Status:** Active