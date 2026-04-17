# Retrospective Process — Operational Guide

**Status:** Draft for Confluence  
**Parent Page:** [WIP Retrospective Transformation Solution Proposed](https://outsystemsrd.atlassian.net/wiki/spaces/EEO/pages/6118113287/WIP+Retrospective+Transformation+Solution+Proposed)  
**Last Updated:** 2026-04-15

---

## Purpose

This guide provides step-by-step instructions for executing retrospectives under the new ownership model. It replaces presentation-based readouts with collaborative working sessions and framework-guided RCA execution.

**Target audience:** Engineering Managers, Team Leaders, Retrospective Commanders, and teams conducting retrospectives.

---

## What Changed?

### Old Model
- SRE leads all system-wide retrospectives
- Teams present completed retrospectives to reviewers
- Volunteer reviewer pool approves documents
- Average lead time: 72 days

### New Model
- **EM/TL of incident-causing team** assigned as Retrospective Commander
- **Collaborative working sessions** replace readouts
- **Framework-guided RCA** with objective scoring
- **Progressive autonomy** — teams gain independence as maturity grows
- **Target lead time:** <45 days

---

## Core Principles

1. **Team Ownership** — Teams that caused the incident lead the retrospective
2. **Manager Accountability** — EM/TL accountable for quality (can delegate execution)
3. **Framework-Based Quality** — Objective assessment via 6 pillars, not manual review
4. **Collaborative Learning** — Working sessions for RCA execution, not presentations
5. **Autonomy + Support** — Teams operate independently with Process Eng support when needed

---

## Process Overview — 7 Steps

```
Incident Closed → Commander Assigned → Document Created → Pre-Assessment → 
Working Session → Post-Assessment → VSL Approval → Closed
```

**Timeline:** <45 days end-to-end

---

## Step 1: Incident Resolution & Commander Assignment

**When:** Immediately after incident is marked as "Solved"

### What Happens

1. **Faulty asset identified** during troubleshooting by Incident Commander
   - Use "Impacted Assets" Jira field
   - Asset owner = team responsible for retrospective

2. **Retrospective Commander assigned**
   - Engineering Manager or Team Leader of asset-owning team
   - Can delegate execution to team members
   - Accountability remains with EM/TL

3. **Notification sent**
   - Commander notified via Jira + Slack (incident channel stays active)
   - Retrospective document template created automatically
   - Pre-assessment framework available

### Who Does What

| Role | Responsibility |
|------|---------------|
| **Incident Commander** | Identify faulty asset during troubleshooting |
| **Process Engineering** | Assign Retrospective Commander based on asset ownership |
| **EM/TL (Commander)** | Accept assignment, begin retrospective preparation |

### SLA

**⏱️ Time to assign:** <3 days from incident closure

---

## Step 2: Document Creation

**When:** Within 3 days of assignment

### What to Create

Initial retrospective document with **minimum content:**

1. **Incident Timeline**
   - Key events from detection to resolution
   - Source: RDINC Jira, incident Slack channel, Rootly

2. **Impact Assessment**
   - Customer impact: # affected, duration, severity
   - Business impact: revenue, SLA breaches, reputation

3. **Initial Root Cause Hypothesis**
   - Technical root cause (based on troubleshooting)
   - Contributing factors (if known)

4. **Detection Method**
   - How incident was discovered (alert, customer report, manual)
   - Alert effectiveness (if applicable)

### How to Create

**Option 1: Manual (using template)**
- Use standard retrospective template in Confluence
- Populate sections from incident Slack channel + RDINC

**Option 2: Automated (Koda skill - coming soon)**
- Skill generates draft using multiple sources (Rootly, RDINC, logs, metrics)
- Review and enrich auto-generated content

### Output

Draft retrospective document ready for **pre-assessment**

### SLA

**⏱️ Time to draft:** <3 days from commander assignment

---

## Step 3: Pre-RCA Assessment (Framework-Based)

**When:** After draft document created, before working session

### What is Pre-Assessment?

Framework-based evaluation that:
- Compares document against **6 quality pillars**
- Identifies gaps (missing or weak sections)
- Generates score: 0-100% based on questions addressed
- Produces actionable agenda for working session

### How to Run Assessment

**Tool:** Koda skill `/assess-retrospective` (in development)

**Manual Alternative (during pilot):**
- Review document against [RCA Framework Pillars](link-to-pillars)
- For each pillar, mark questions as:
  - ✅ **Fully addressed** — present with sufficient depth
  - ⚠️ **Present but weak** — exists but needs deeper analysis
  - ❌ **Missing** — not addressed
- Calculate score: % questions with ✅

### Assessment Output

**Pre-assessment report includes:**

1. **Overall Score** — e.g., 45% (9 of 20 questions fully addressed)

2. **Score by Pillar**
   - Detection & Monitoring: 🟢 83% (5/6)
   - Response & Communication: 🟡 50% (2/4)
   - Troubleshooting & Root Cause: 🔴 33% (1/3)
   - Recovery & Resolution: 🟡 50% (3/6)
   - Prevention & Learning: 🔴 40% (2/5)
   - Process Compliance: 🟢 75% (3/4)

3. **Gap Analysis**
   - ❌ Missing: Root cause depth, recurrence check, action item owners
   - ⚠️ Weak: MTTR analysis, customer impact quantification

4. **Recommended Focus for Working Session**
   - Priority 1: Deepen root cause analysis (Pillar 3)
   - Priority 2: Define action items with owners (Pillar 5)
   - Priority 3: Quantify customer impact (Pillar 4)

### What to Do with Results

**Before working session:**
- Review gaps with your team
- Gather additional information for weak/missing areas
- Prepare questions for working session participants

**You can iterate:**
- Update document based on gaps identified
- Re-run assessment to improve score before working session
- Goal: Start working session with >50% score

### SLA

**⏱️ Time to assess:** <1 day from draft creation

---

## Step 4: RCA Working Session

**When:** Within 7 days of draft creation

### What is a Working Session?

Collaborative session to **execute RCA**, not present finished work.

**Purpose:**
- Answer ❌ missing questions
- Deepen ⚠️ weak analysis
- Ensure all 6 pillars covered
- Define action items with clear owners

**Not a presentation** — this is hands-on RCA work together.

### Who Attends?

**Required:**
- Retrospective Commander (EM/TL) or delegate
- Process Engineering (facilitator)
- Key team members involved in incident

**Optional (based on incident):**
- SRE (Incident Commander)
- Quality (if testing gaps identified)
- Other teams (if multi-team incident)

### Session Structure (60-90 min)

**1. Review Pre-Assessment (5 min)**
- Share score and gap analysis
- Confirm focus areas

**2. Pillar-by-Pillar Review (50-70 min)**

For each pillar with gaps:
- **State the gap:** "Root cause analysis is weak — we said 'code bug' but didn't explain why"
- **Ask guiding questions:** "What conditions allowed this bug? Was there missing test coverage? Technical debt?"
- **Discuss collaboratively:** Team provides context, Process Eng facilitates
- **Document insights:** Update retrospective document in real-time or capture notes for later

**Focus time per pillar:**
- 🔴 Red (0-40%): 15-20 min
- 🟡 Yellow (40-70%): 10 min
- 🟢 Green (70-100%): 5 min or skip

**3. Action Items Definition (10-15 min)**
- What prevents recurrence?
- Short-term fixes vs long-term improvements
- **Each action item must have:**
  - Clear description
  - Owner (name, not "team")
  - Target date or priority
  - Tracking mechanism (Jira RPM, Problem Record)

**4. Next Steps (5 min)**
- Who updates document?
- When is document due?
- When to re-run assessment?

### Facilitation Tips

**Process Engineering role:**
- Guide discussion using framework questions
- Keep session focused on gaps
- Avoid blame — focus on learning
- Ensure action items are specific and owned

**Progressive Autonomy:**
- **Tier 1 teams (new to model):** Process Eng fully facilitates
- **Tier 2 teams (improving):** Team co-facilitates with Process Eng observing
- **Tier 3 teams (mature):** Team self-facilitates, Process Eng only consulted if needed

### Output

Updated retrospective document with:
- All ❌ missing questions addressed
- All ⚠️ weak sections deepened
- Action items defined with owners

### SLA

**⏱️ Time to session:** <7 days from draft creation

---

## Step 5: Document Update

**When:** Within 2 days of working session

### What to Do

1. **Update retrospective document**
   - Incorporate insights from working session
   - Address all gaps identified
   - Finalize action items section

2. **Create action item tracking**
   - Create Problem Records (RPM) for each action item
   - Link RPMs to retrospective
   - Assign owners in Jira

3. **Prepare for post-assessment**
   - Document should now be complete
   - All 6 pillars addressed

### Who Does What

| Role | Responsibility |
|------|---------------|
| **EM/TL (Commander)** | Ensure document updated (can delegate writing) |
| **Team member (if delegated)** | Write updates, create RPMs |
| **Process Engineering** | Review for completeness (if needed) |

### SLA

**⏱️ Time to update:** <2 days from session

---

## Step 6: Post-Assessment & Validation

**When:** After document updated

### What is Post-Assessment?

Re-run framework assessment to measure improvement.

**Purpose:**
- Validate all gaps addressed
- Calculate before/after score (e.g., 45% → 85%)
- Confirm quality threshold met for approval

### How to Run

Same process as pre-assessment (Step 3):
- Run Koda skill `/assess-retrospective` OR
- Manually review against framework pillars

### Quality Threshold

**Target for approval:** >70%

**If <70%:**
- Identify remaining gaps
- Update document or schedule follow-up discussion
- Re-assess until threshold met

### Before/After Comparison

**Example:**

| Pillar | Pre-Score | Post-Score | Improvement |
|--------|-----------|------------|-------------|
| Detection & Monitoring | 83% | 100% | +17% |
| Response & Communication | 50% | 75% | +25% |
| Troubleshooting & Root Cause | 33% | 100% | +67% |
| Recovery & Resolution | 50% | 83% | +33% |
| Prevention & Learning | 40% | 80% | +40% |
| Process Compliance | 75% | 100% | +25% |
| **Overall** | **45%** | **85%** | **+40%** |

**Learning visible:** Framework shows exactly where team improved.

### What Happens Next

**If score >70%:** Ready for VSL approval (Step 7)

**If score <70%:** Additional work needed — update document, address gaps, re-assess

### SLA

**⏱️ Time to post-assess:** Same day as document update

---

## Step 7: VSL Approval & Closure

**When:** After post-assessment confirms >70% score

### What Happens

1. **VSL Review**
   - Value Stream Leader reviews retrospective
   - Confirms quality threshold met
   - Approves or requests changes

2. **Approval Decision**
   - ✅ **Approved:** Retrospective closed, action items tracked via Problem Management
   - ❌ **Changes requested:** Update document, address feedback, resubmit

3. **Retrospective Closed**
   - Jira status: "Retrospective Completed"
   - Action items tracked separately in Problem Management
   - Retrospective document published (if not already)

### Who Does What

| Role | Responsibility |
|------|---------------|
| **EM/TL (Commander)** | Submit for approval when ready |
| **VSL** | Review and approve within 5 days |
| **Process Engineering** | Monitor approval timeline, escalate if delayed |

### SLA

**⏱️ Time to approval:** <5 days from submission

---

## End-to-End Timeline

| Step | Activity | SLA | Cumulative |
|------|----------|-----|------------|
| 1 | Incident closed → Commander assigned | 3 days | Day 3 |
| 2 | Draft document created | 3 days | Day 6 |
| 3 | Pre-assessment completed | 1 day | Day 7 |
| 4 | RCA working session held | 7 days | Day 14 |
| 5 | Document updated | 2 days | Day 16 |
| 6 | Post-assessment completed | same day | Day 16 |
| 7 | VSL approval | 5 days | Day 21 |

**Target: <45 days** (21 days baseline + buffer for iterations)

**Current average: 72 days** → Goal is 40% reduction

---

## The 6 Quality Pillars

Each retrospective is assessed against these 6 pillars.

### Pillar 1: Detection & Monitoring 🕵️

**Focus:** How effectively was the incident detected?

**Key questions:**
1. How was incident initially detected? (alert, customer, manual)
2. Did detection happen before customer impact?
3. Was the alert clear and actionable?
4. Was Error Budget (system-wide SLO) affected?
5. Was Error Budget (service-specific SLO) affected?
6. What can be improved in detection?

---

### Pillar 2: Response & Communication 📣

**Focus:** How timely and effective was the response?

**Key questions:**
1. Was incident declaration timely after detection?
2. Was communication effective (internal + external)?
3. Was MTTA documented and adequate?
4. Was status page communication timely and clear?

---

### Pillar 3: Troubleshooting & Root Cause 🔍

**Focus:** How effective was troubleshooting? Is root cause clear?

**Key questions:**
1. Were troubleshooting steps effective?
2. Is technical root cause clear and evidence-based?
3. Are there architectural issues to address?

---

### Pillar 4: Recovery & Resolution 🩹

**Focus:** How quickly was service restored? What blocked recovery?

**Key questions:**
1. Was MTTR adequate?
2. What was the primary mitigation method?
3. What slowed down recovery?
4. Were runbooks used? Were they accurate?
5. Did dependencies or cascading failures delay recovery?
6. Was customer impact quantified?

---

### Pillar 5: Prevention & Learning 🧠

**Focus:** What did we learn? How do we prevent recurrence?

**Key questions:**
1. Was incident caused by a recent change?
2. **Is this a recurring issue?** (Check previous incidents)
3. What action items prevent recurrence?
4. Were action items immediately owned and tracked?
5. Did team gain significant new insight?

---

### Pillar 6: Process Compliance ✅

**Focus:** Was the process followed correctly?

**Key questions:**
1. Did incident management process work?
2. Was retrospective completed within SLA?
3. Is documentation clear, complete, and actionable?
4. Was retrospective process followed correctly?

---

**Full pillar details:** [RCA Framework Pillars](link-to-rca-framework-pillars-doc)

---

## Roles & Responsibilities

### Retrospective Commander (EM/TL)

**Accountable for:**
- Retrospective completion within SLA (<45 days)
- Quality threshold met (>70% score)
- Action items defined with owners

**Can delegate:**
- Document writing
- Pre/post-assessment execution
- RPM creation

**Cannot delegate:**
- Accountability
- Working session attendance (or must designate clear delegate)
- Final approval submission

---

### Process Engineering

**Responsible for:**
- Assigning Retrospective Commander
- Facilitating working sessions (initially)
- Tracking SLAs and escalating delays
- Providing framework training and support
- Monitoring quality metrics

**Facilitates progressive autonomy:**
- Full facilitation for new teams
- Coaching for improving teams
- Advisory only for mature teams

---

### Value Stream Leader

**Responsible for:**
- Final approval of retrospectives
- Strategic oversight
- Escalating systemic issues to leadership

**Can request:**
- Deeper review for critical incidents
- Additional working session if quality gaps remain

---

### SRE

**New role: Advisory/Consultancy**
- Attends working sessions when requested
- Provides guidance on detection, monitoring, troubleshooting
- No longer leads all retrospectives
- Focuses on strategic work (patterns, tooling)

---

## Tools & Automation

### Current (Pilot Phase)

**Manual tools:**
- Confluence: Retrospective documentation
- Jira: Commander assignment, action item tracking (RPMs)
- Framework spreadsheet: Manual scoring

**Facilitation:**
- Process Engineering: Working session scheduling and facilitation

---

### Coming Soon (Q2-Q3 2026)

**Automated tools:**

1. **Koda Skill — Retrospective Generation**
   - Auto-generates draft document from incident data
   - Sources: RDINC, Rootly, Slack, logs, metrics
   - Reduces manual prep work from hours to minutes

2. **Koda Skill — Framework Assessment**
   - `/assess-retrospective`: Run pre/post assessment
   - Output: Score by pillar, gap analysis, session agenda
   - Enables self-service quality checking

3. **Recurrence Detection**
   - Automatically identifies similar past incidents
   - Flags if previous action items not executed
   - Prevents repeat failures from being ignored

4. **Dashboards (PowerBI)**
   - Retrospective lead time by team
   - Quality scores over time
   - Action item completion rates
   - Recurrence patterns

---

## Metrics & Governance

### Metrics Tracked

**Process metrics:**
- Retrospective lead time (target: <45 days)
- Assignment latency (target: <3 days)
- % retrospectives completed within SLA

**Quality metrics:**
- Average quality score by team
- % retrospectives meeting >70% threshold
- Improvement delta (pre vs post-assessment)

**Outcome metrics:**
- Incident recurrence rate
- Action item completion rate
- MTTR trends by team
- Detection ratio (proactive vs reactive)

---

### Governance Model

**Weekly:**
- Process Engineering tracks SLAs
- Alerts sent for retrospectives >30 days old

**Monthly:**
- Quality metrics reviewed with EMs
- Patterns identified (teams needing support)

**Quarterly:**
- Model effectiveness reviewed
- Adjustments based on data

---

## FAQ

### Q: Who is the Retrospective Commander?

**A:** The Engineering Manager or Team Leader of the team that owns the faulty asset identified during incident troubleshooting. Accountability stays with EM/TL, but they can delegate execution to team members.

---

### Q: What if multiple teams were involved?

**A:** EMs/TLs collaborate to decide which team leads. The EM/TL of the leading team is assigned as Commander. If ownership unclear, escalate to VSLs.

---

### Q: Can I delegate retrospective writing?

**A:** Yes. You can delegate document writing, assessment, RPM creation to team members. But **accountability** remains with you as Commander.

---

### Q: What if I miss the SLA?

**A:** Process Engineering monitors SLAs and will flag delays. If you're blocked, reach out early. Repeated SLA misses will trigger support/training.

---

### Q: Do I need to answer every framework question?

**A:** No. The framework is guidance, not a rigid checklist. Answer questions **relevant to your incident**. Aim for >70% overall score, but focus on depth over breadth.

---

### Q: What if my score is <70% after working session?

**A:** Address remaining gaps, update document, re-assess. If stuck, request another working session or Process Eng support. VSL can approve if close to threshold and critical gaps addressed.

---

### Q: How long are working sessions?

**A:** 60-90 minutes. Focus on gaps identified in pre-assessment. Not every retrospective needs a full 90-minute session — depends on complexity and score.

---

### Q: Can I skip the working session if my pre-assessment score is high?

**A:** If your pre-assessment score is >70% and all pillars are strong, you can request to skip the working session. Process Eng will review and approve. This is part of **progressive autonomy** — high-maturity teams can operate more independently.

---

### Q: What happens if we find a recurring issue?

**A:** Flag it immediately. The framework checks for recurrence (Pillar 5, Q2). If previous action items weren't executed, escalate to your EM and VSL. Recurrence with incomplete actions triggers problem management escalation (M3.4).

---

### Q: Where do I get help?

**Contact:**
- **Process Engineering:** Inês Matos, Vera Branco
- **SRE (advisory):** Pedro Charola Alves
- **Slack:** #retrospectives-support (to be created)

---

## Getting Started

### For Your First Retrospective

1. **Get assigned** — You'll receive Jira notification when assigned as Commander
2. **Review this guide** — Understand the 7 steps
3. **Create draft** — Use template, populate from incident data
4. **Run pre-assessment** — Manually review against framework pillars (or use skill when available)
5. **Schedule working session** — Coordinate with Process Eng
6. **Update document** — After working session
7. **Submit for approval** — When score >70%

**Timeline:** Plan for 3-4 weeks total (well within 45-day SLA)

---

### For Process Engineering (Facilitators)

**Before working session:**
- Review pre-assessment report with Commander
- Confirm attendees (SRE? Quality? Other teams?)
- Prepare guiding questions for each gap

**During working session:**
- Keep discussion focused on gaps
- Use framework questions to guide
- Capture insights in real-time or via notes
- Ensure action items are specific and owned

**After working session:**
- Support Commander with document update (if needed)
- Track post-assessment score
- Monitor VSL approval

---

## Resources

- **RCA Framework Pillars (detailed):** [link to RCA-FRAMEWORK-PILLARS.md]
- **Retrospective Template:** [link to Confluence template]
- **New Model Proposal (full context):** [link to PROPOSAL-NEW-MODEL.md]
- **Assessment Skill Documentation:** [link to Koda skill docs - coming soon]

---

## Changelog

**2026-04-15:** Initial operational guide created for Confluence publication

---

**Document Owner:** Inês Matos, Vera Branco  
**Status:** Draft — Ready for Confluence publication