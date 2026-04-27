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

### Step 1b: Load process reference documents

Read the following before starting evaluation — these calibrate gap detection for Pillars 2 and 6:

- `initiatives/active/retrospectives/docs/INCIDENT-RESPONSE-PROCESS-REFERENCE.md` — OutSystems incident response process rules (scenarios, roles, severity SLAs, recovery sequence, Jira workflow)
- `initiatives/active/retrospectives/docs/RCA-FRAMEWORK-SCORING-GUIDE.md` — Scoring criteria
- `initiatives/active/retrospectives/docs/change-management-official.md` — Change Management policy (for P6 Q2: RFC compliance evaluation)

### Step 1c: Check external status page

Navigate to `https://status.outsystems.com/history` using Playwright and search for entries matching the incident date.

- **If found:** extract title, start/end timestamps, and public description. Use this to evaluate **Pillar 2 Q3** (external communication) with concrete evidence. Calculate the lag between incident start time (from retrospective) and first status page entry.
- **If not found:** note in Q3 assessment — either no external communication was published, or the entry has expired from history (~3 months retention).

### Step 1d: Identify incident scenario

Before evaluating, determine the incident scenario from the retrospective content:

- **Scenario 1** — Without system-wide impact (1 tenant only) → Retrospective optional; IC: Dev Team
- **Scenario 2** — With system-wide impact (>1 tenant or full region) → Retrospective mandatory; IC: SRE
- **Scenario 3** — Late detection of system-wide impact (started as Sc1, escalated) → Retrospective mandatory; IC: SRE

**State the scenario at the top of the assessment header.** This anchors evaluation for:
- **P4 Q3** (rollback — mandatory consideration per process in all scenarios)
- **P6 Q1** (process followed — IC role, Slack channel creation, and Jira as single source of truth are required for Sc2/3)

---

### Step 2: Analyze against RCA Framework v2.0

Evaluate **25 questions** across **6 pillars** (Pillar 5 has 3 questions; Pillar 6 Q1-Q2 only, Q3-Q5 are post-assessment).

**Scoring:**
- ✅ **1.0 — Fully Addressed**: Question explicitly answered with depth, evidence, and analysis
- ⚠️ **0.5 — Present but Weak**: Mentioned but lacks depth, analysis, or actionable details
- ❌ **0.0 — Missing**: Not addressed in the document
- 🚫 **N/A**: Question not relevant to this incident

**IMPORTANT — Pillar 5, Q3 (Action Items) Validation:**

When evaluating "Are prevention action items defined with clear ownership and tracking?":

1. **Extract Jira IDs** from action items section (regex: `[A-Z]+-\d+`)
2. **For each Jira ID**, use `mcp__claude_ai_Atlassian__getJiraIssue` (preferred — acli does not return `duedate` reliably)
3. **Check mandatory fields:**
   - **Assignee (Jira field)** — Owner assigned in Jira? (field not blank) ⚠️ **MANDATORY** — do NOT flag mismatches between retrospective text and Jira assignee; only check that the Jira field is populated
   - **Due Date (Jira field)** — Due Date populated? ⚠️ **MANDATORY**
     - ⚠️ **RPOR project exception:** For tickets in the RPOR project, Due Date is stored as **"Target end"** (`customfield_15486`), not `duedate`. Request both fields when calling `getJiraIssue`.
   - **RDINC Link** — Ticket must have a Jira link of type **"reviews"** pointing to the RDINC issue of this retrospective ⚠️ **MANDATORY**
     - Check the `issuelinks` field in the `getJiraIssue` response (include `issuelinks` in `fields` param)
4. **Red flags (flag but do not auto-fail):**
   - **Discarded status** — action item may not be executed; requires explanation

5. **Scoring:**
   - ✅ **1.0**: All action items have Jira IDs + all mandatory fields complete (Assignee + Due Date + RDINC link) + no Discarded tickets without explanation
   - ⚠️ **0.5**: Jira IDs present but 1+ mandatory fields missing OR any ticket in Discarded without documented replacement/rationale
   - ❌ **0.0**: No Jira IDs OR Jira tickets don't exist

6. **Output format** for Q3:
```markdown
### Q3: Are prevention action items defined with clear ownership and tracking?

**Jira Validation:**

| Ticket | Assignee | Due Date | RDINC Link | Status | Score |
|--------|----------|----------|------------|--------|-------|
| RPLAT-3819 | ✅ Pedro Cardoso | ✅ 2026-06-30 | ✅ reviews RDINC-78746 | To Do | ✅ |
| RPLAT-3823 | ❌ **Unassigned** | ✅ 2026-06-30 | ❌ **Missing** | To Do | ⚠️ |

**Overall:** ⚠️ **Present but Weak** — RPLAT-3823 has no assignee and no RDINC link. Both are mandatory.
```

If MCP Atlassian fails or not available:
```markdown
### Q3: Are prevention action items defined with clear ownership and tracking?

⚠️ **INCONCLUSIVE** — Jira IDs referenced (RPLAT-3819, RPLAT-3823) but unable to validate. Manual verification required.

**Recommendation:** Verify that all action items have:
- Assigned Owner ⚠️ **MANDATORY**
- **Due Date populated** ⚠️ **MANDATORY**
- **Jira link type "reviews" pointing to the RDINC issue** ⚠️ **MANDATORY**
- Status is not Discarded (or if so, document why)
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

### Pillar 5: Prevention & Learning 🧠 (3 questions)

1. Was the incident caused by a recent change?
2. Was recurrence analysis performed?
3. Are prevention action items defined with clear ownership and tracking? ⚠️ **JIRA VALIDATION REQUIRED**

### Pillar 6: Process Compliance ✅ (2 questions — pre-assessment only)

1. Did the incident management process work as expected, and were any gaps identified?
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

## Calibration Rules

### N/A decision rules

Use 🚫 N/A when the **question genuinely doesn't apply to this incident type** — not when the answer is missing from the document. ❌ 0.0 means the document failed to address something relevant; N/A removes it from the denominator entirely.

**Common N/A scenarios:**
- **P2 Q3 (external communication):** N/A for infrastructure-only incidents with no customer-facing app impact. "System-wide impact: Yes" in Rootly means infra scope, not customer visibility. Status page entries are for outages visible to end-users. A telemetry/ingestion infra incident ≠ customer app degradation.
- **P5 Q1 (caused by recent change):** N/A when evidence clearly points to environmental drift, stale state, or infrastructure causes — not triggered by a deployment, config change, or code release. If the retrospective treats it as drift and there is no evidence of a recent change, the question doesn't apply.

### No double-penalization

Identify the most direct question for a gap and penalize it there. Do not use the same weakness to justify low scores across multiple questions.

**Example:** If detection was downstream/symptomatic rather than at the source:
- Penalize in **Q3** (alerts didn't target the right signal) and/or **Q6** (improvement opportunity)
- Do NOT also penalize **Q2** for the same reason — Q2 asks about timing relative to customer impact, not detection quality

### Re-read before scoring ❌

Before assigning ❌ 0.0 to any question, do a targeted re-read of the document searching specifically for evidence of that question. Cascading effects, impact quantification, and process steps are often documented in narrative sections (executive summary, resolution, timeline) rather than in dedicated headers. Missing something that is present is a scoring error.

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
