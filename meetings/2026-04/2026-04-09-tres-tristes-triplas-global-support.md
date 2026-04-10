# Tres Tristes Triplas - Retrospectives Transformation
**Audience:** Global Support
**Duration:** 20 minutes
**Date:** 2026-04-09
**Presenter:** Inês Matos

---

## Session Goals

1. **Awareness** - Share the retrospective transformation we're implementing
2. **Input** - Gather Global Support perspectives on "process compliance" within the RCA framework
3. **Connection** - Clarify how Global Support insights can strengthen retrospective quality

---

## Structure (20 min)

### 1. The Problem (4 min)
### 2. The Solution (6 min)
### 3. The Quality Framework (5 min)
### 4. How Global Support Can Contribute (3 min)
### 5. Next Steps & Questions (2 min)

---

## 1. The Problem (4 min)

### Current State - The Data

**Lead Time Crisis:**
- Average lead time: **72 days** (incident resolution to retrospective closure)
- Assignment latency: **11 days** just to assign a Retrospective Commander
- Execution & approval: **64 days** to write, present, review, approve

**Bottlenecks:**
- SRE leads ALL system-wide incident retrospectives - capacity exceeded
- Reviewer pool shrinking - **63% of reviews done by only 2 people**
- Value Stream Leaders approval delays due to competing priorities

**Distribution of Time (last 6 months, 18 system-wide incidents):**

| Phase | Average Time | % of Total |
|-------|--------------|------------|
| "Solved" State | 15.8 days | 17% |
| **Retrospective In Progress** | **63.7 days** | **69%** |
| Retrospective Completed | 13.4 days | 14% |
| **TOTAL** | **92.9 days** | **100%** |

**Impact:**
- Stale action items - context lost by the time retrospective completes
- Learning delayed - exposure to same failure patterns continues
- Operational gridlock - SRE engineers juggling growing backlog

---

## 2. The Solution (6 min)

### Ownership Shift: From SRE-led to Team-led

**Core Changes:**

1. **Engineering Manager/Team Leader becomes Retrospective Commander**
   - EM/TL of the incident-causing team is accountable
   - Can delegate execution to team members
   - Owns quality and timelines

2. **Reviewer role eliminated**
   - No more dependency on shrinking volunteer pool
   - Quality maintained through framework-based auditing

3. **Working sessions replace presentation readouts**
   - Collaborative RCA execution, not presenting finished work
   - Teams learn by doing
   - Process Eng facilitates initially, teams graduate to self-led sessions

4. **Koda skill enables self-assessment**
   - Teams run skill BEFORE working session to identify gaps
   - Skill scores document 0-100% based on quality framework
   - Three levels: Fully addressed, Present but weak, Missing
   - Before/after scoring shows learning improvement

5. **SRE transitions to advisory role**
   - Consultancy and guidance, not execution bottleneck
   - Focus on strategic work (patterns, tooling)

**What Stays the Same:**
- Value Stream Leaders maintain strategic oversight and approval
- Quality expectations remain high
- Focus on high-impact incidents that matter
- Goal is learning, not blame

### Process Flow (7 Steps)

1. **Incident Resolution & Assignment** - EM/TL of team owning faulty asset assigned as Retrospective Commander
2. **Document Creation** - EM/TL drafts initial retrospective (within 3 days)
3. **Pre-RCA Assessment** - Team runs Koda skill to assess document quality (0-100% score)
4. **RCA Working Session** - Collaborative session to fill gaps, deepen analysis (Process Eng facilitates)
5. **Post-Session Validation** - Skill re-runs on updated document (before/after comparison)
6. **Action Items** - Determined offline, tracked via Problem Management
7. **Final Quality Check & Approval** - VSL approves when quality threshold met (target: >70%)

### Expected Impact

- Significant reduction in lead time (target: < 45 days)
- SRE bottleneck eliminated
- Reviewer bottleneck eliminated
- Greater team ownership and accountability
- Learning by doing through collaborative sessions
- Less bureaucracy, more autonomy

---

## 3. The Quality Framework (5 min)

### RCA Framework - 3 Pillars

The Koda skill assesses retrospective quality based on these three pillars:

#### Pillar 1: Detection
**Focus:** How did we find out about the incident?

Questions the framework addresses:
- How was the incident initially detected?
- Did detection happen before customer impact?
- How effective was the alert's clarity/actionability?
- Was the Error Budget of a System-wide SLO affected?
- Was the Error Budget of a Service-specific SLO affected?
- What can be improved in detection?

#### Pillar 2: Troubleshooting and Recovery
**Focus:** How did we respond and recover?

Questions the framework addresses:
- Was MTTR adequate?
- Were troubleshooting steps effective?
- What slowed down recovery?
- What was the primary method of mitigation?
- Did the incident management process work?
- Was communication effective?
- Were runbooks or documentation used? Were they accurate and helpful?
- Did dependencies or cascading failures significantly delay recovery?

**This is where "process compliance" fits** - incident management process adherence, communication effectiveness, runbook accuracy.

#### Pillar 3: Learning & Improvement
**Focus:** What did we learn and how do we prevent recurrence?

Questions the framework addresses:
- Is the technical root cause clear?
- Are there architectural issues to address?
- Was the incident caused by a recent change?
- What action items prevent recurrence?
- Were follow-up actions immediately owned and tracked?
- Did the team gain a significant new insight about the system?

### How the Skill Works

**Three-level assessment for each question:**
- ✅ **Fully addressed** - present with sufficient depth
- ⚠️ **Present but weak** - exists but needs depth (e.g., "human error" as root cause without deeper analysis)
- ❌ **Missing** - not addressed

**Output:**
- 0-100% score based on % of questions addressed
- Exact list of what was answered and what wasn't
- Guiding questions for each gap
- Actionable agenda for working session

**Example:**
- Team drafts retrospective → runs skill → 45% score
- Skill output: "❌ Missing: detection timing relative to customer impact", "⚠️ Present but weak: root cause states 'configuration error' without explaining why configuration was wrong"
- Working session focuses on filling ❌ and deepening ⚠️
- Post-session → re-run skill → 85% score
- Before/after delta shows value added

---

## 4. How Global Support Can Contribute (3 min)

### Your Role in This Transformation

**Why Global Support Matters:**
- You're often the first to hear from customers about what didn't work
- You observe incident management from the outside-in
- You have direct visibility into communication effectiveness
- You see patterns across multiple incidents that engineering teams might miss

### Input We're Looking For: "Process Compliance" Lens

Within **Pillar 2 (Troubleshooting and Recovery)**, we want to strengthen the "process compliance" dimension.

**Specific questions:**
1. **Incident Management Process**
   - When incidents happen, what process gaps do you observe?
   - Are there recurring patterns where the incident management process breaks down?
   - What would make the process work better from your perspective?

2. **Communication Effectiveness**
   - What communication gaps have you noticed during incidents?
   - What information do you need but don't get?
   - When communication works well, what makes it effective?

3. **Handoffs and Coordination**
   - Where do handoffs between Support and Engineering break down during incidents?
   - What would improve coordination?

4. **Documentation and Runbooks**
   - Are runbooks accurate when you need them?
   - What documentation gaps cause delays?

### How to Share Your Input

**Today:**
- Share any immediate thoughts in the Q&A

**Next 2 weeks:**
- I'll share a structured way to capture your inputs (likely a short form or async discussion)
- Your inputs will directly shape the "process compliance" questions in the RCA framework

**Ongoing:**
- When you observe incidents where process didn't work, flag them
- Your perspective helps us improve the framework over time

---

## 5. Next Steps & Questions (2 min)

### Timeline

- **April 13:** Present new model to Value Stream Leaders & Engineering Managers
- **April-May:** Finalize RCA framework, build Koda skill, organize training
- **June:** Pilot with mature teams (5-10 incidents)
- **July:** Full rollout to all teams

### How This Affects Global Support

**What changes:**
- Retrospectives will happen faster (target: < 45 days vs current 72 days)
- Teams will be more accountable for incident learnings
- Working sessions may include Global Support when your input adds value

**What stays the same:**
- Scope: all system-wide incidents still get retrospectives
- You're still key stakeholders in understanding what went wrong
- Your insights remain critical for improving processes

### Questions?

Open floor for questions, comments, or immediate inputs on "process compliance" gaps you've observed.

---

## Notes Section (for capturing inputs during session)

### Process Compliance Gaps Mentioned:

-

### Communication Gaps Mentioned:

-

### Documentation/Runbook Gaps Mentioned:

-

### Other Insights:

-

---

**Follow-up actions:**
- [ ] Share structured input form with Global Support (by April 16)
- [ ] Incorporate Global Support inputs into RCA framework "process compliance" questions
- [ ] Schedule follow-up session if needed to share how their input shaped the framework
