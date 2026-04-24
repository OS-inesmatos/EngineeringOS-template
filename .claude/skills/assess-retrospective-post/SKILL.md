# Post-Assessment — Retrospective Quality

Evaluate retrospective quality using RCA Framework v2.0 **after VSL approval**.

## Usage

```
/assess-retrospective-post <confluence-url>
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

Evaluate **29 questions** across **6 pillars** (includes Pillar 6 Q3-Q5 for post-assessment).

**Scoring:**
- ✅ **1.0 — Fully Addressed**: Question explicitly answered with depth, evidence, and analysis
- ⚠️ **0.5 — Present but Weak**: Mentioned but lacks depth, analysis, or actionable details
- ❌ **0.0 — Missing**: Not addressed in the document
- 🚫 **N/A**: Question not relevant to this incident

**IMPORTANT — Pillar 5, Q3 (Action Items) Validation:**

When evaluating "Are prevention action items defined with clear ownership and tracking?":

1. **Extract Jira IDs** from action items section (regex: `[A-Z]+-\d+`)
2. **For each Jira ID**, run: `acli jira workitem view <ISSUE-KEY>`
3. **Check mandatory elements:**
   - **Description (Jira field)** — Clear and specific?
   - **Acceptance Criteria (within Description field)** — Look for section labeled "Acceptance Criteria", "AC:", "Success criteria:", or clear completion criteria. Must be measurable.
   - **Assignee (Jira field)** — Owner assigned? (not blank)
   - **Due Date (Jira field)** — Due Date populated? ⚠️ **MANDATORY**

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

### Pillar 6: Process Compliance ✅ (5 questions — all included in post-assessment)

1. Was incident management process followed?
2. If the mitigation required a change (RFC), did it follow Change Management policy?
3. **Was the retrospective completed within SLA (<14 days)?** 📊 *Post-assessment only*
4. **Is the retrospective documentation clear, complete, and actionable?** 📊 *Post-assessment only*
5. **Was the retrospective process followed correctly?** 📊 *Post-assessment only*

**Note:** Q3-Q5 evaluate the completed retrospective process itself (SLA, documentation quality, process compliance).

---

## Output Format

Generate assessment report in this format:

```markdown
# Retrospective Post-Assessment — [INCIDENT-ID]

**Incident:** [SEVx] - [Incident Title]
**Assessment Date:** [YYYY-MM-DD]
**Assessed By:** Koda Post-Assessment Skill v2.0
**Document:** [Confluence URL]
**VSL Approval Date:** [YYYY-MM-DD]

---

## Overall Quality Score: **[X/100]** [🟢/🟡/🔴]

**Status:** [Approved / Needs improvement / Quality concern]
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

**Overall Post-Assessment:** [X.X]/29 questions fully addressed

---

### [For each Pillar]

### 🕵️ Pillar 1: Detection & Monitoring ([X]/100)

**Score:** X.X / 6.0 points

#### ✅ Fully Addressed (X questions)

[List questions with ✅ and evidence]

#### ⚠️ Present but Weak (X questions)

[List questions with ⚠️, issue explanation, and "Needs depth" guidance]

#### ❌ Missing (X questions)

[List questions with ❌ and guiding questions]

---

[Repeat for all 6 pillars, including Pillar 6 Q3-Q5]

---

## Quality Summary

**Strengths:**
- [What the retrospective does well]

**Key Gaps:**
- [Most critical missing or weak areas]

**Process Observations:**
- [Pillar 6 Q3-Q5: SLA compliance, documentation quality, process adherence]

---

## Recommendations

**For Future Retrospectives:**
1. [Improvement recommendation based on gaps]
2. [Process recommendation based on Pillar 6 findings]
3. [Quality recommendation based on overall score]

**For Engineering Management:**
- [Pattern observations if this team has recurring quality issues]
- [Training or enablement needs identified]

---

## Audit Trail

**Pre-Assessment Score:** [X/100] (if available)
**Post-Assessment Score:** [X/100]
**Improvement:** [+/-X points] ([+/-X%])

**Timeline:**
- Incident Closure: [YYYY-MM-DD]
- Retrospective Completion: [YYYY-MM-DD]
- VSL Approval: [YYYY-MM-DD]
- Post-Assessment: [YYYY-MM-DD]

---

**Generated by:** Koda Post-Assessment Skill v2.0
**Framework Version:** RCA Framework v2.0 (6 pillars, 29 questions | Post-Assessment: all 29 questions)
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
- **Pillar 6 Q3-Q5** — These evaluate the retrospective process itself (meta-questions)

---

## Scoring Logic

**Per-Pillar Score:**
```
Pillar Score (%) = (Points Earned / Points Possible) × 100
```

**Overall Score:**
```
Overall Score (%) = (Total Points Earned / Total Points Possible) × 100
Post-Assessment max: 29 points
```

**Quality Thresholds:**
- **70%+** 🟢 — Good quality, meets standards
- **40-70%** 🟡 — Needs improvement, quality concerns
- **<40%** 🔴 — Significant gaps, quality failure

**N/A Handling:**
- N/A questions excluded from denominator
- Does not penalize score

---

## Post-Assessment Purpose

This assessment measures:
1. **Content Quality** (Pillars 1-5) — Was the incident properly analyzed?
2. **Process Quality** (Pillar 6) — Was the retrospective process followed correctly?

**Use cases:**
- Validate retrospective quality after VSL approval
- Identify quality patterns across teams
- Measure effectiveness of quality interventions (RCA working sessions)
- Provide input to governance dashboards
