# Retrospective Process — Quick Reference

**For:** Retrospective Commanders (EM/TL)  
**Last Updated:** 2026-04-15

---

## Your Retrospective in 7 Steps

### ✅ Step 1: You're Assigned (Day 0)
**Notification:** Jira + Slack  
**Action:** Accept assignment, review incident data  
**SLA:** Assigned within 3 days of incident closure

---

### 📝 Step 2: Create Draft (Days 1-3)
**What to include:**
- Incident timeline (from RDINC, Slack)
- Customer impact (# affected, duration)
- Initial root cause hypothesis
- Detection method

**Where:** Confluence (use template)  
**SLA:** <3 days from assignment

---

### 📊 Step 3: Pre-Assessment (Day 4)
**Tool:** Koda skill `/assess-retrospective` OR manual review

**Output:**
- Score: 0-100%
- Gaps: What's missing or weak
- Focus areas for working session

**SLA:** <1 day from draft

---

### 🤝 Step 4: Working Session (Days 5-14)
**Who:** You (or delegate), Process Eng, key team members  
**Duration:** 60-90 min  
**Purpose:** Fill gaps, deepen analysis, define action items

**Structure:**
1. Review pre-assessment (5 min)
2. Discuss gaps pillar-by-pillar (50-70 min)
3. Define action items with owners (10-15 min)
4. Confirm next steps (5 min)

**SLA:** <7 days from draft

---

### ✏️ Step 5: Update Document (Days 15-16)
**What to do:**
- Incorporate working session insights
- Address all gaps
- Create Problem Records (RPMs) for action items

**SLA:** <2 days from session

---

### ✅ Step 6: Post-Assessment (Day 16)
**Tool:** Re-run assessment (same as Step 3)

**Check:**
- Score improved? (e.g., 45% → 85%)
- All gaps addressed?
- Score >70%? → Ready for approval

**If <70%:** Fix remaining gaps, re-assess

---

### 👍 Step 7: VSL Approval (Days 17-21)
**Action:** Submit to VSL for approval  
**VSL reviews:** Confirms quality, approves  
**Done:** Retrospective closed, action items tracked

**SLA:** <5 days from submission

---

## Timeline Summary

| Step | Days | Cumulative |
|------|------|------------|
| 1. Assigned | 0 | Day 0 |
| 2. Draft | 1-3 | Day 3 |
| 3. Pre-assess | +1 | Day 4 |
| 4. Session | +7-10 | Day 14 |
| 5. Update | +2 | Day 16 |
| 6. Post-assess | same | Day 16 |
| 7. Approval | +5 | Day 21 |

**Target:** <45 days (21-day baseline + buffer)

---

## The 6 Quality Pillars

Your retrospective is scored against these:

| Pillar | Focus | Key Question |
|--------|-------|--------------|
| 🕵️ **Detection** | Was detection effective? | How was incident detected? Before customer impact? |
| 📣 **Response** | Was response timely? | Was incident declared quickly? MTTA acceptable? |
| 🔍 **Troubleshooting** | Is root cause clear? | Is root cause documented with evidence? |
| 🩹 **Recovery** | Was recovery fast? | Was MTTR adequate? What slowed us down? |
| 🧠 **Prevention** | How prevent recurrence? | Is this recurring? Action items defined with owners? |
| ✅ **Process** | Was process followed? | Was retrospective completed in SLA? |

**Target score:** >70% for approval

**Full details:** [RCA Framework Pillars](link)

---

## Scoring Guide

### What Does My Score Mean?

| Score | Level | What to Do |
|-------|-------|------------|
| **70-100%** 🟢 | **Excellent** | Ready for approval. May skip working session if all pillars strong. |
| **50-69%** 🟡 | **Good Progress** | Working session will help fill gaps. Focus on weak pillars. |
| **30-49%** 🟡 | **Needs Work** | Significant gaps. Working session critical. Consider iteration. |
| **0-29%** 🔴 | **Incomplete** | Major gaps across pillars. Gather more data before working session. |

---

## Working Session Tips

### Before Session
- ✅ Review pre-assessment gaps
- ✅ Gather additional data for weak areas
- ✅ Prepare questions for participants
- ✅ Confirm attendees (SRE? Quality? Other teams?)

### During Session
- Focus on **gaps** (❌ missing, ⚠️ weak)
- Not a presentation — collaborative discussion
- Aim to answer: "What happened? Why? How prevent?"
- Define action items with **clear owners + dates**

### After Session
- Update document with insights
- Create RPMs for action items
- Re-run assessment to confirm improvement

---

## Action Items Checklist

Every action item must have:

- ✅ **Clear description** — What specific action?
- ✅ **Owner** — Person's name (not "team")
- ✅ **Target date or priority** — When?
- ✅ **Tracking** — Jira RPM or Problem Record

**Bad example:**  
❌ "Improve monitoring" (vague, no owner, no date)

**Good example:**  
✅ "Add alert for queue depth >1000 (Owner: João Silva, Due: 2026-05-01, RPM-1234)"

---

## Red Flags to Avoid

| Red Flag | Why It's Bad | How to Fix |
|----------|-------------|------------|
| Root cause is "human error" | Too surface-level | Ask "why" 5 times — what enabled the error? |
| No recurrence check | Miss patterns | Always check: similar incidents in last 90 days? |
| Action items generic | Not actionable | Make specific: who, what, when |
| Customer impact vague | Can't prioritize | Quantify: # users, duration, revenue impact |
| No MTTR analysis | Miss recovery gaps | Document MTTR, compare to historical, identify blockers |
| Detection method unclear | Can't improve | Be specific: which alert? Customer report? Manual? |

---

## When to Escalate

**Escalate to Process Eng if:**
- Blocked on data/information
- Can't identify faulty asset owner
- Multi-team incident with ownership dispute
- SLA at risk

**Escalate to VSL if:**
- Systemic issue detected
- Recurring incident with incomplete prior action items
- Critical incident needing faster review

---

## Progressive Autonomy

As your team matures, you gain independence:

| Your Score | Autonomy Level |
|------------|----------------|
| **Tier 1 (0-40%)** | Process Eng fully facilitates sessions |
| **Tier 2 (40-70%)** | You co-facilitate, Process Eng observes |
| **Tier 3 (70-100%)** | You self-lead, Process Eng consults only |

**Goal:** High-maturity teams operate independently.

---

## Quick Checklist: Am I Ready for Approval?

Before submitting to VSL, confirm:

- ✅ Post-assessment score >70%
- ✅ All 6 pillars addressed (no major gaps)
- ✅ Root cause clearly documented with evidence
- ✅ Action items defined with owners and dates
- ✅ RPMs created and linked
- ✅ Customer impact quantified
- ✅ Recurrence check completed
- ✅ Document clear and well-structured

**If all ✅ → Submit for approval**

---

## Tools

### Current (Pilot)
- **Confluence:** Retrospective docs
- **Jira:** Commander assignment, RPMs
- **Manual:** Framework spreadsheet for scoring

### Coming Soon
- **Koda skill:** Auto-generate draft
- **Koda skill:** `/assess-retrospective`
- **Dashboards:** Lead time, quality trends

---

## Need Help?

**Contact:**
- **Process Engineering:** Inês Matos, Vera Branco
- **SRE (advisory):** Pedro Charola Alves
- **Slack:** #retrospectives-support (coming soon)

**Documentation:**
- [Operational Guide (detailed)](link) — Step-by-step for all 7 steps
- [RCA Framework Pillars](link) — Detailed questions for each pillar
- [Full Proposal](link) — Complete context and rationale

---

**Print this page for quick reference during your retrospective!**