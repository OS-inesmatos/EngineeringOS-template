# Pre-Assessment — Retrospective Quality

Evaluate retrospective quality using RCA Framework v2.0 **before working session**.

## Usage

```
/assess-retrospective-pre <confluence-url>
```

---

## Instructions

### Step 1: Get the retrospective content

Accept:
- Confluence page URL (fetch with WebFetch)
- Markdown file path (use Read)
- Direct paste

If given Confluence URL, fetch content and save the URL for the report.

### Step 2: Analyze against RCA Framework v2.0

Evaluate **26 questions** across **6 pillars** (Pillar 6 Q1-Q2 only, Q3-Q5 are post-assessment).

**Scoring:**
- ✅ **1.0 — Fully Addressed**: Question explicitly answered with depth, evidence, and analysis
- ⚠️ **0.5 — Present but Weak**: Mentioned but lacks depth, analysis, or actionable details
- ❌ **0.0 — Missing**: Not addressed in the document
- 🚫 **N/A**: Question not relevant to this incident

**IMPORTANT — Pillar 5, Q3 (Action Items) Validation:**

When evaluating "Are prevention action items defined with clear ownership and tracking?":

1. **Extract Jira IDs** from action items section (regex: `[A-Z]+-\d+`)
2. **For each Jira ID**, run: `acli jira workitem view <ISSUE-KEY>`
3. **Check mandatory fields:**
   - **Description** — Clear and specific?
   - **Acceptance Criteria** — Measurable and present in Description?
   - **Assignee** — Owner assigned? (not blank)
   - **Due Date** — Due Date field populated? ⚠️ **MANDATORY**

4. **Scoring:**
   - ✅ **1.0**: All action items have Jira IDs + all mandatory fields complete (Description, Acceptance Criteria, Assignee, **Due Date**)
   - ⚠️ **0.5**: Jira IDs present but 1+ mandatory fields missing (especially **Due Date**) OR action items vague
   - ❌ **0.0**: No Jira IDs OR Jira tickets don't exist

5. **Output format** for Q3:
```markdown
### Q3: Are prevention action items defined with clear ownership and tracking?

**Jira Validation:**

| Ticket | Description | Acceptance Criteria | Owner | Due Date | Score |
|--------|-------------|---------------------|-------|----------|-------|
| RPLAT-3819 | ✅ Clear | ✅ Present | ✅ Pedro Cardoso | ❌ **Missing** | ⚠️ |
| RPLAT-3823 | ✅ Clear | ✅ Present | ✅ Marco Barbosa | ❌ **Missing** | ⚠️ |

**Overall:** ⚠️ **Present but Weak** — Action items have clear descriptions and acceptance criteria, but **Due Date is missing** on all tickets. Due Date is mandatory for tracking commitment and detecting delays.

**Evidence from Jira:**
- RPLAT-3819: [Summary from Jira]
- RPLAT-3823: [Summary from Jira]
```

If `acli` fails or not available:
```markdown
### Q3: Are prevention action items defined with clear ownership and tracking?

⚠️ **INCONCLUSIVE** — Jira IDs referenced (RPLAT-3819, RPLAT-3823) but unable to validate. Manual verification required.

**Recommendation:** Verify that all action items have:
- Clear Description and Acceptance Criteria
- Assigned Owner
- **Due Date populated** ⚠️ **MANDATORY**
```

---

## Framework Questions

### Pillar 1: Detection & Monitoring 🕵️ (6 questions)

1. How was the incident initially detected?
2. Was the incident detected before customer impact?
3. Were alerts clear and actionable?
4. Was the Error Budget of a System-wide SLO affected?
5. Was the Error Budget of a Service-specific SLO affected?
6. What can be improved in detection?

### Pillar 2: Response & Communication 📣 (4 questions)

1. Was incident declaration timely?
2. Was internal communication effective?
3. Was external communication effective?
4. Was MTTA (Mean Time to Acknowledge) adequate?

### Pillar 3: Troubleshooting & Root Cause 🔍 (3 questions)

1. Were troubleshooting steps effective?
2. What is the technical root cause?
3. Are there architectural issues to address?

### Pillar 4: Recovery & Resolution 🩹 (7 questions)

1. What was the recovery time (MTTR) and was it acceptable?
2. What was the primary method of mitigation?
3. Was rollback considered as a recovery option?
4. Are recovery blockers identified?
5. Were runbooks or documentation used and assessed?
6. Did dependencies or cascading failures significantly delay recovery?
7. Was customer impact quantified?

### Pillar 5: Prevention & Learning 🧠 (4 questions)

1. Was the incident caused by a recent change?
2. Was recurrence analysis performed?
3. Are prevention action items defined with clear ownership and tracking? ⚠️ **JIRA VALIDATION REQUIRED**
4. What learnings did the team gain?

### Pillar 6: Process Compliance ✅ (2 questions — pre-assessment only)

1. Was incident management process followed?
2. If the mitigation required a change (RFC), did it follow Change Management policy?

**Note:** Q3-Q5 of Pillar 6 are **post-assessment only** (evaluate completed retrospective process).

---

## Output Format

Generate assessment report in this format:

```markdown
# Retrospective Pre-Assessment — [INCIDENT-ID]

**Incident:** [SEVx] - [Incident Title]
**Assessment Date:** [YYYY-MM-DD]
**Assessed By:** Koda Pre-Assessment Skill v2.0
**Document:** [Confluence URL]

---

## Overall Quality Score: **[X/100]** [🟢/🟡/🔴]

**Status:** [Ready for working session / Needs significant work before working session]
**Recommendation:** [Brief recommendation based on score]

---

## Score Breakdown by Pillar

| Pillar | Score | Status | Summary |
|--------|-------|--------|---------|
| 🕵️ Detection & Monitoring | X/100 | [🟢/🟡/🔴] | [Brief summary] |
| 📣 Response & Communication | X/100 | [🟢/🟡/🔴] | [Brief summary] |
| 🔍 Troubleshooting & Root Cause | X/100 | [🟢/🟡/🔴] | [Brief summary] |
| 🩹 Recovery & Resolution | X/100 | [🟢/🟡/🔴] | [Brief summary] |
| 🧠 Prevention & Learning | X/100 | [🟢/🟡/🔴] | [Brief summary] |
| ✅ Process Compliance | X/100 | [🟢/🟡/🔴] | [Brief summary] |

**Overall Pre-Assessment:** [X.X]/26 questions fully addressed

---

### [For each Pillar]

### 🕵️ Pillar 1: Detection & Monitoring ([X]/100)

**Score:** X.X / 6.0 points

#### ✅ Fully Addressed (X questions)

[List questions with ✅ and evidence]

#### ⚠️ Present but Weak (X questions)

[List questions with ⚠️, issue explanation, and "Needs depth" guidance]

#### ❌ Missing (X questions)

[List questions with ❌ and guiding questions for working session]

---

[Repeat for all 6 pillars]

---

## Prioritized Working Session Agenda

**Recommended focus for RCA working session (60-90 min):**

### 🔴 High Priority (Address First — 30 min)

[List critical gaps with:
- Current state
- Why critical
- Guiding questions]

### 🟡 Medium Priority (Address Next — 20 min)

[List moderate gaps]

### 🟢 Lower Priority (If Time Permits — 10 min)

[List minor gaps]

---

## Next Steps

### For the Retrospective Commander (EM/TL)

1. **Review this assessment** — Focus on 🔴 High Priority gaps
2. **Gather additional data** before working session: [List specific data needed]
3. **Schedule working session** — Invite: [List required attendees]
4. **Pre-session prep:** [List preparation tasks]

### For Working Session Facilitator (Process Eng)

- **Facilitation focus:** [Top 3 priorities]
- **Watch for:** [Common pitfalls]
- **Success criteria:** [What defines successful session]

---

## Expected Outcome

**Target post-session:** >70% score (ready for VSL approval)
**Re-assessment:** Run post-assessment after VSL approval to measure final quality

---

**Generated by:** Koda Pre-Assessment Skill v2.0
**Framework Version:** RCA Framework v2.0 (6 pillars, 29 questions | Pre-Assessment: 26 questions)
**For questions:** Contact Process Engineering (Inês Matos, Vera Branco)
```

---

## Tips

- **Be objective** — Score based on what's written, not assumptions
- **Evidence matters** — Good retrospectives have data, metrics, logs
- **Check depth** — Surface-level answers get ⚠️ 0.5, not ✅ 1.0
- **Action Items Validation** — Always run Jira validation for Q3 of Pillar 5
- **Due Date is mandatory** — Missing Due Date always results in ⚠️ 0.5 or lower
- **N/A when appropriate** — Not every question applies to every incident

---

## Scoring Logic

**Per-Pillar Score:**
```
Pillar Score (%) = (Points Earned / Points Possible) × 100
```

**Overall Score:**
```
Overall Score (%) = (Total Points Earned / Total Points Possible) × 100
Pre-Assessment max: 26 points
```

**Quality Thresholds:**
- **70%+** 🟢 — Good quality, ready for approval
- **40-70%** 🟡 — Needs improvement, working session recommended
- **<40%** 🔴 — Significant gaps, requires substantial work

**N/A Handling:**
- N/A questions excluded from denominator
- Does not penalize score
