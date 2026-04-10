# Assess Retrospective Quality

This skill evaluates retrospective quality against the RCA Framework pillars (Detection, Troubleshooting & Recovery, Learning & Improvement).

## Instructions

### Step 1: Get the retrospective content

Ask the user for the retrospective to analyze. Accept:
- Confluence page URL (use WebFetch to get content)
- Markdown file path (use Read tool)
- Direct text paste

If given a Confluence URL, fetch the page content first. **Save the retrospective URL** — you'll need it for the Overview section to create a clickable link back to the original document.

### Step 2: Analyze against RCA Framework

Evaluate the retrospective against **3 pillars** and **23 key questions**.

**IMPORTANT: This is an OBJECTIVE assessment** — evaluate based on what is WRITTEN in the document, not what could be inferred or assumed.

For each question, assign one of three levels:
- ✅ **Fully addressed (1 point)** — Question is explicitly answered in the document with sufficient depth, evidence, and analysis
- ⚠️ **Present but weak (0.5 points)** — Question is mentioned but lacks depth, analysis, or actionable details (e.g., "human error" as root cause without deeper investigation, or data mentioned without analysis)
- ❌ **Missing (0 points)** — Question is not addressed or not found in the document

**Scoring Criteria:**

**✅ Fully addressed means:**
- The question is explicitly answered in the retrospective
- Evidence or data is provided
- Analysis or assessment is present (not just stating facts)
- Actionable insights or learnings are documented

**⚠️ Present but weak means:**
- The topic is mentioned but without analysis
- Data exists but no assessment of "was this adequate/effective?"
- Surface-level answer without deeper investigation
- Missing actionable insights

**❌ Missing means:**
- The question is not addressed in the document
- No mention of the topic at all
- Only tangentially related information

**Example scoring:**
- "MTTR was 6.8 hours" = ⚠️ (data present but no analysis of adequacy)
- "MTTR was 6.8 hours, which is acceptable given the complexity of the race condition" = ✅ (data + analysis)
- No MTTR mentioned = ❌

### Step 3: Generate assessment report

**Important formatting notes:**
- Semaphore emoji (🟢/🟡/🔴) appears on the score value line, NOT in the heading
- Pillar headings use H3 (###), nested under "Score Breakdown by Pillar" (H2)
- When publishing to Confluence, the Table of Contents must be added manually (user will add it via `/toc` in Confluence editor)

Output format:

```markdown
# Retrospective Quality Assessment — [Incident ID]

---

## Overview

**Incident:** [Incident ID] — [Incident Title]
**Retrospective:** [View retrospective](URL to Confluence retrospective page)
**Severity:** [SEVx]
**MTTR:** [Duration]
**Assessment Date:** [Date]

## Overall Score

🟡 **[X/100]**

**Status:** [Needs Improvement / Good Quality / Significant Gaps] — [RCA Working Session Recommended / Ready for Approval / Requires Substantial Work]

---

## Score Breakdown by Pillar

| Pillar | Score | Percentage | Status |
|--------|-------|------------|--------|
| 🕵️ **Detection** | X/7 | X% | 🔴/🟡/🟢 Status |
| 🩹 **Troubleshooting & Recovery** | X/9 | X% | 🔴/🟡/🟢 Status |
| 🧠 **Learning & Improvement** | X/7 | X% | 🔴/🟡/🟢 Status |
| **TOTAL** | **X/23** | **X%** | 🟡 **Status** |

---

### Pillar 1: Detection 🕵️ — [X/7] ([percentage]%)

| # | Question | Status | Notes |
|---|----------|--------|-------|
| 1 | How was the incident initially detected? | ✅ / ⚠️ / ❌ | Brief note |
| 2 | Did detection happen before customer impact? | ✅ / ⚠️ / ❌ | Brief note |
| 3 | How effective was the alert's clarity/actionability? | ✅ / ⚠️ / ❌ | Brief note |
| 4 | Was the Error Budget of a System-wide SLO affected? | ✅ / ⚠️ / ❌ | Brief note |
| 5 | Was the Error Budget of a Service-specific SLO affected? | ✅ / ⚠️ / ❌ | Brief note |
| 6 | What can be improved in detection? | ✅ / ⚠️ / ❌ | Brief note |
| 7 | Was incident declaration timely after detection? | ✅ / ⚠️ / ❌ | Brief note |

### Gaps to Address

[List ❌ and ⚠️ items with guiding questions]

---

### Pillar 2: Troubleshooting and Recovery 🩹 — [X/9] ([percentage]%)

| # | Question | Status | Notes |
|---|----------|--------|-------|
| 1 | Was MTTR adequate? | ✅ / ⚠️ / ❌ | Brief note |
| 2 | Were troubleshooting steps effective? | ✅ / ⚠️ / ❌ | Brief note |
| 3 | What slowed down recovery? | ✅ / ⚠️ / ❌ | Brief note |
| 4 | What was the primary method of mitigation? | ✅ / ⚠️ / ❌ | Brief note |
| 5 | Did the incident management process work? | ✅ / ⚠️ / ❌ | Brief note |
| 6 | Was communication effective? | ✅ / ⚠️ / ❌ | Brief note |
| 7 | Were runbooks or documentation used? Were they accurate? | ✅ / ⚠️ / ❌ | Brief note |
| 8 | Did dependencies or cascading failures delay recovery? | ✅ / ⚠️ / ❌ | Brief note |
| 9 | Was customer impact quantified? | ✅ / ⚠️ / ❌ | Brief note |

### Gaps to Address

[List ❌ and ⚠️ items with guiding questions]

---

### Pillar 3: Learning & Improvement 🧠 — [X/7] ([percentage]%)

| # | Question | Status | Notes |
|---|----------|--------|-------|
| 1 | Is the technical root cause clear? | ✅ / ⚠️ / ❌ | Brief note |
| 2 | Are there architectural issues to address? | ✅ / ⚠️ / ❌ | Brief note |
| 3 | Was the incident caused by a recent change? | ✅ / ⚠️ / ❌ | Brief note |
| 4 | What action items prevent recurrence? | ✅ / ⚠️ / ❌ | Brief note |
| 5 | Were follow-up actions immediately owned and tracked? | ✅ / ⚠️ / ❌ | Brief note |
| 6 | Did the team gain a significant new insight? | ✅ / ⚠️ / ❌ | Brief note |
| 7 | Is this a recurring issue? | ✅ / ⚠️ / ❌ | Brief note |

### Gaps to Address

[List ❌ and ⚠️ items with guiding questions]

---

## Summary

**Strengths:**
- [What the retrospective does well]

**Key Gaps:**
- [Most critical missing or weak areas]

---

## Recommended Actions

**Ready for RCA Working Session?** [🟢/🟡/🔴] **[Yes/No - explain why]**

[Brief summary of which pillars need strengthening and why a working session is recommended]

### RCA Working Session Plan

**Objective:** [Primary focus based on lowest-scoring pillar]

**Session Duration:** [45-60 minutes based on number of gaps]

**Who Should Attend:**
- Retrospective Commander (EM/TL)
- Incident Commander
- [Relevant technical teams based on incident]
- Process Engineering (facilitator)

**Session Agenda:**

#### Part 1: [Highest Priority Pillar] ([time] minutes) — 🔴 PRIORITY

[List critical missing/weak questions with specific guidance on what data/context is needed]

#### Part 2: Quick Wins ([time] minutes) — 🟡 SECONDARY

[List remaining ⚠️ and ❌ questions]

#### Part 3: Wrap-Up (5 minutes)

- Document all answers directly in the retrospective
- Assign owners to new action items
- Schedule follow-up if needed

**Before the Session:**
[List specific prep work and data to gather]

**After the Session:**
- Update retrospective document with session findings
- Re-run assessment to measure improvement (target: >70%)
- Track action items to completion

---

## Scoring Logic

- ✅ Fully addressed = 1 point
- ⚠️ Present but weak = 0.5 points
- ❌ Missing = 0 points

**Overall Score:** Total points / 23 questions

**Quality Threshold:**
- **70%+** — Good quality, ready for approval
- **40-70%** — Needs improvement, RCA working session recommended
- **<40%** — Significant gaps, requires substantial work

---
```

### Step 4: Provide guiding questions for gaps

For each ❌ or ⚠️ question, provide specific guiding questions to help the team address the gap. Use the detailed questions from the RCA Framework Pillars document.

## Framework Reference

### Pillar 1: Detection 🕵️

1. **How was the incident initially detected?**
   - Customer report, internal alert, monitoring system, manual discovery?

2. **Did detection happen before customer impact?**
   - Proactive vs reactive detection
   - Customer-detected vs system-detected

3. **How effective was the alert's clarity/actionability?**
   - Was the alert clear about what was wrong?
   - Did it provide enough context for rapid response?
   - Did it suggest actionable next steps?

4. **Was the Error Budget of a System-wide SLO affected?**
   - Track impact on system-wide SLOs
   - Error budget consumption

5. **Was the Error Budget of a Service-specific SLO affected?**
   - Track impact on service-specific SLOs
   - Identify services most affected

6. **What can be improved in detection?**
   - New alerts needed?
   - Alert tuning required?
   - Monitoring gaps identified?
   - SLO coverage improvements?

7. **Was incident declaration timely after detection?**
   - How long between issue detection and formal incident creation?
   - If delayed, what caused the delay?
   - Was escalation appropriate and timely?

### Pillar 2: Troubleshooting and Recovery 🩹

1. **Was MTTR adequate?**
   - Was recovery time acceptable?
   - How does it compare to historical MTTR for similar incidents?

2. **Were troubleshooting steps effective?**
   - Did the team know where to look?
   - Were troubleshooting tools adequate?
   - Were logs/metrics/traces helpful?

3. **What slowed down recovery?**
   - Missing information or context?
   - Tooling gaps?
   - Knowledge gaps?
   - Coordination issues?

4. **What was the primary method of mitigation?**
   - Rollback of change
   - Fix-forward (new deployment/patch)
   - Configuration change (feature flag, scaling)
   - Manual intervention/workaround

5. **Did the incident management process work?**
   - Was incident declaration clear?
   - Were roles assigned effectively?
   - Was the Incident Commander effective?
   - Were escalation paths followed?

6. **Was communication effective?**
   - Internal communication (team, leadership)
   - External communication (customers, stakeholders)
   - Timely and clear updates?

7. **Were runbooks or documentation used? Were they accurate and helpful?**
   - Did relevant runbooks exist?
   - Were they used during recovery?
   - Were they accurate and complete?
   - Do runbooks need to be created or updated?

8. **Did dependencies or cascading failures significantly delay recovery?**
   - Impact of upstream/downstream dependencies
   - Cascading failures that amplified impact
   - Cross-team coordination challenges

9. **Was customer impact quantified?**
   - How many customers were affected?
   - What was the duration and severity of impact per customer?
   - Was the business impact assessed and communicated?

### Pillar 3: Learning & Improvement 🧠

1. **Is the technical root cause clear?**
   - Root cause identified and documented?
   - Evidence-based analysis?
   - Avoid surface-level symptoms

2. **Are there architectural issues to address?**
   - Design weaknesses exposed?
   - Scalability issues?
   - Single points of failure?
   - Technical debt contributing to incident?

3. **Was the incident caused by a recent change?**
   - Direct link to deployment, configuration change, or code change?
   - Change Failure Rate (CFR) implications
   - Deployment process gaps?

4. **What action items prevent recurrence?**
   - Specific, actionable items defined?
   - Short-term fixes vs long-term improvements?
   - Address root cause, not just symptoms

5. **Were follow-up actions immediately owned and tracked?**
   - Clear ownership assigned for each action item?
   - Tracking mechanism in place (Jira, Problem Management)?
   - Timeline/priority defined?

6. **Did the team gain a significant new insight about the system?**
   - New understanding of system behavior?
   - Previously unknown risk or vulnerability discovered?
   - Learning value beyond fixing this specific issue?

7. **Is this a recurring issue?**
   - Were there previous incidents with the same root cause?
   - Were action items from previous retrospectives completed?
   - What systemic issues were not addressed that allowed recurrence?
   - Is there a pattern indicating band-aids instead of systemic fixes?

## Quality Signals Reference

### Good Retrospective (✅)
- Detection method clearly identified
- MTTR documented and assessed
- Root cause clearly documented with evidence
- Specific, actionable prevention items defined
- Action items have clear owners and tracking
- Evidence of learning beyond immediate fix

### Red Flags (❌)
- Detection method unclear
- MTTR not mentioned
- Root cause vague or missing
- Action items generic ("improve monitoring")
- No clear ownership for action items
- No evidence of learning

### Present but Weak (⚠️)
- Mentions root cause but as "human error" without deeper analysis
- Lists action items but they're vague or generic
- Mentions MTTR but doesn't assess if adequate
- Identifies gaps but no concrete improvement plans

## Tips

- **Be objective** — base assessment on what's written, not what you assume
- **Look for evidence** — good retrospectives have data, metrics, logs, evidence
- **Check depth** — does analysis go beyond surface level?
- **Prevent AI theater** — flag when text exists but is superficial
- **Context matters** — not every question applies to every incident, note "N/A" when appropriate
- **Score conservatively** — only mark ✅ if genuinely well-addressed with depth

## Example Usage

```
/assess-retrospective https://outsystemsrd.atlassian.net/wiki/spaces/EEO/pages/123456789
```

or

```
/assess-retrospective
[then paste retrospective text or provide file path]
```
