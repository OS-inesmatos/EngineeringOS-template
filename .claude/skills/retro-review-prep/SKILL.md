---
skill_name: retro-review-prep
title: Retrospective Review Prep
description: Prepare the Retrospective section for the bi-weekly Operations Review — Power BI charts, Jira detail, narrative, and trend comparison
---

# Retrospective Review Prep

Prepares the Retrospective section of Process Engineering's contribution to the bi-weekly Operations Review.

## Instructions

When invoked, follow this workflow:

### Step 1: Determine review period

1. Calculate default period: 15 calendar days ending the day before next Thursday
2. Ask: "Review period is **[START_DATE] to [END_DATE]**. Correct?"
3. Wait for confirmation or adjusted dates

### Step 2: Gather previous context

Read the most recent Ops Review to get baseline metrics for trend comparison.

1. Use `mcp__claude_ai_Atlassian__searchConfluenceUsingCql`:
   - CQL: `ancestor = 5316116528 AND type = page ORDER BY created DESC`
   - Space: `EEO`
   - Limit: 1
2. Read the page with `mcp__claude_ai_Atlassian__getConfluencePage` (format: `view`, to get markdown)
3. Extract previous metrics:
   - Active backlog count
   - Unassigned Commanders count
   - Average lead time (days)
   - Overdue action items count
4. Store these for Step 4 comparison

### Step 3: Collect current data

**Primary: Power BI report via Playwright**

Navigate to the [Retrospective Management Dashboard](https://app.powerbi.com/groups/me/apps/3a45f9da-1b76-4e56-8d53-f5ecca33e50c/reports/51c81030-b36b-4d75-a348-2ab5e4dff49a/e92ea0cac0e60f2d54a8?ctid=1e7930e6-1ca4-40df-ac06-adabc2b139a3&experience=power-bi) and read the charts.

1. `mcp__playwright__browser_navigate` to the report URL
2. `mcp__playwright__browser_wait_for` to ensure charts load (selector: `[role="img"]`, timeout: 10000ms)
3. `mcp__playwright__browser_snapshot` to read chart values
4. Navigate between tabs using `mcp__playwright__browser_click` if needed

Extract from the charts:
- Active retrospective backlog (total and by status)
- Status distribution: In Progress, Completed, Closed, In Backlog, Pending Review, Pending Approval
- Commander assignment overview (assigned vs unassigned)
- Lead time trends: average retrospective leadtime, time to start, time to complete
- Root cause categorization breakdown (top 3 + distribution)
- Action item health: created, concluded, overdue, completeness %
- Incident volume: created vs resolved in period

**Secondary: DAX queries for drill-down**

If Power BI charts don't surface specific numbers (e.g., exact Commander gaps, overdue action item detail), connect to the **Retrospectives** semantic model.

Use `mcp__fabric__ConnectFabric`:
- Workspace: `[Engineering] Process Engineering [BIZ]`
- Semantic model: `Retrospectives`

Connection name will be: `Fabric-%5BEngineering%5D%20Process%20Engineering%20%5BBIZ%5D-Retrospectives`

**Available DAX queries** (use `mcp__fabric__ExecuteDaxQuery`, only if needed):

Status distribution:
```dax
EVALUATE
ROW(
    "Active Retrospectives", [Active Retrospectives],
    "In Progress", [Retrospectives in Progress],
    "Completed", [Retrospectives Completed],
    "Closed", [Retrospectives Closed],
    "In Backlog", [Retrospectives in Backlog],
    "Pending Review", [Retrospectives Pending Review],
    "Pending Approval", [Retrospectives Pending Approval]
)
```

Root cause distribution:
```dax
EVALUATE
SUMMARIZECOLUMNS(
    OTHER_PROPERTIES[RCA_CATEGORY],
    "Count", COUNTROWS(OTHER_PROPERTIES)
)
ORDER BY [Count] DESC
```

Action item health:
```dax
EVALUATE
ROW(
    "Action Items Created", [# Action Items Created],
    "Action Items Concluded", [# Action Items Concluded],
    "Action Items Overdue", [Action Items Overdue],
    "Past Due To Do", [Past Due Action Items (To Do)],
    "Past Due In Progress", [Past Due Action Items (In Progress)],
    "No Due Date", [Action Items Due Date not Available],
    "On Due", [Action Items On Due],
    "Completeness %", [Action Items Completeness (%)]
)
```

Commander assignment gaps:
```dax
EVALUATE
SUMMARIZECOLUMNS(
    "Total Active", CALCULATE(COUNTROWS(OTHER_PROPERTIES), OTHER_PROPERTIES[RETROSPECTIVE_STATUS] IN {"Retrospective In Progress", "Retrospective Completed"}),
    "No Commander", CALCULATE(COUNTROWS(OTHER_PROPERTIES), OTHER_PROPERTIES[RETROSPECTIVE_STATUS] IN {"Retrospective In Progress", "Retrospective Completed"}, ISBLANK(OTHER_PROPERTIES[RETROSPECTIVE_COMMANDER]))
)
```

Lead times:
```dax
EVALUATE
ROW(
    "Avg Retrospective Leadtime (Days)", [Average Retrospective Leadtime (Days)],
    "Time to Complete Retro (Days)", [Time to complete Retrospective (days)],
    "Time to Start Retro (Days)", [Time to start Retrospective (days)],
    "Time to Complete Action Items (Days)", [Time to complete Action Items (days)]
)
```

Incident throughput (replace `__START_DATE` and `__END_DATE` with `DATE(YYYY,M,D)`):
```dax
EVALUATE
ROW(
    "Created Incidents", CALCULATE(COUNTROWS(INCIDENTS_DISTINCT), INCIDENTS_DISTINCT[CREATED_DATE] >= __START_DATE && INCIDENTS_DISTINCT[CREATED_DATE] < __END_DATE),
    "Resolved Incidents", CALCULATE(COUNTROWS(INCIDENTS_DISTINCT), NOT ISBLANK(INCIDENTS_DISTINCT[RESOLUTION_DATE]), INCIDENTS_DISTINCT[RESOLUTION_DATE] >= __START_DATE && INCIDENTS_DISTINCT[RESOLUTION_DATE] < __END_DATE)
)
```

Overdue action items detail:
```dax
EVALUATE
SELECTCOLUMNS(
    FILTER(LINKED_ISSUES, NOT ISBLANK(LINKED_ISSUES[LINKED_ISSUE_DUE_DATE]) && LINKED_ISSUES[Days to Due] < 0),
    "Issue", LINKED_ISSUES[ISSUE_KEY],
    "Linked Issue", LINKED_ISSUES[LINKED_ISSUE],
    "Type", LINKED_ISSUES[LINKED_ISSUE_TYPE],
    "Status", LINKED_ISSUES[LINKED_ISSUE_STATUS],
    "Due Date", LINKED_ISSUES[LINKED_ISSUE_DUE_DATE],
    "Days to Due", LINKED_ISSUES[Days to Due],
    "Assignee", LINKED_ISSUES[LINKED_ISSUE_ASSIGNE]
)
ORDER BY [Due Date] ASC
```

**Tertiary: Jira RDINC for detail**

Use `mcp__claude_ai_Atlassian__searchJiraIssuesUsingJql` to fill gaps Power BI doesn't cover.

Active retros without commander:
```jql
project = RDINC AND "Retrospective Status" in ("In Progress", "Completed") AND "Retrospective Commander" is EMPTY ORDER BY created ASC
```

Stalled retros (no update in 15+ days):
```jql
project = RDINC AND "Retrospective Status" in ("In Progress", "Completed") AND updated <= "-15d" ORDER BY updated ASC
```

Retros closed in period:
```jql
project = RDINC AND "Retrospective Status" = "Closed" AND resolved >= "[START_DATE]" AND resolved <= "[END_DATE]" ORDER BY resolved DESC
```

New retros in period:
```jql
project = RDINC AND created >= "[START_DATE]" AND created <= "[END_DATE]" ORDER BY created DESC
```

Overdue action items (detail beyond Power BI):
```jql
project in (RDEV, RDPIM, RSA, APPSEC) AND issueFunction in linkedIssuesOf("project = RDINC AND 'Retrospective Status' in ('In Progress', 'Completed')") AND duedate < now() AND status not in (Done, Closed, Completed, Discarded) ORDER BY duedate ASC
```

### Step 4: Analyze

Compare current metrics to previous baseline. Analyze these vectors:

| Vector | What to report | Alert threshold |
|--------|---------------|-----------------|
| **Backlog volume** | Active count + trend vs previous | Increase > 10% |
| **Status distribution** | In Progress vs Completed vs stalled (>15 days). "Completed" = approved but action items open. "Closed" = all action items in production. | > 30% stalled |
| **Commander assignment** | Count without Commander + % of total | > 40% unassigned |
| **Lead time** | Average days from creation to close | > 60 days |
| **Root cause distribution** | Breakdown by RCA_CATEGORY. Top 3 + trend. Categories: Infrastructure, Application, Deployment, Security, Operational, Configuration, Missing Feature, Customer Issue, Tests Failed, Self Recovered. | Single category > 50% |
| **Action item health** | Total open, overdue, completed in period, missing due dates | > 5 overdue |
| **Throughput** | Closed in period vs new in period | Net increase |

**Narrative structure for each finding:**

1. **What the data shows** — the metric and its value
2. **How it compares** — trend vs previous (use table format)
3. **Why it matters** — risk, compliance, or operational implication
4. **What we're doing about it** — link to V2MOM initiative or action item (check `initiatives/active/retrospectives/`)
5. **What we need from you** (if applicable) — specific ask to Value Stream Leaders

### Step 5: Generate output

Save to `meetings/prep/YYYY-MM-DD-retro-review-data.md`:

```markdown
# Retrospective Review Data — [DATE]
**Review period:** [START_DATE] to [END_DATE]

---

## Key findings

- [Finding 1 with trend and implication]
- [Finding 2 with trend and implication]
- [Finding 3 with trend and implication]

## Metrics

### Status distribution

| Status | Count | % of Total |
|--------|-------|------------|
| In Progress | X | Y% |
| Completed (action items open) | X | Y% |
| Stalled (no movement > 15 days) | X | Y% |
| In Backlog | X | Y% |
| Pending Review | X | Y% |
| Pending Approval | X | Y% |

### Root cause distribution

| Category | Count | % | Trend |
|----------|-------|---|-------|
| [Top 1] | X | Y% | +/-Z |
| [Top 2] | X | Y% | +/-Z |
| [Top 3] | X | Y% | +/-Z |
| Other | X | Y% | -- |

### Action item health

| Metric | Count |
|--------|-------|
| Total open (linked to active retros) | X |
| Overdue (past due date) | X |
| Completed in period | X |
| Missing due date (data gap) | X |

### Commander assignment

| Metric | Count | % |
|--------|-------|---|
| Active retros | X | -- |
| With Commander | X | Y% |
| Without Commander | X | Y% |

### Lead times

| Metric | Days |
|--------|------|
| Avg retrospective leadtime | X |
| Time to start retro | X |
| Time to complete retro | X |
| Time to complete action items | X |

### Throughput

| Metric | Count |
|--------|-------|
| New in period | X |
| Closed in period | X |
| Net change | +/-X |

### Trend comparison

| Metric | Previous | Current | Change |
|--------|----------|---------|--------|
| Active backlog | X | Y | +/-Z |
| Unassigned Commanders | X | Y | +/-Z |
| Avg lead time (days) | X | Y | +/-Z |
| Overdue action items | X | Y | +/-Z |

## Stalled retros (no update > 15 days)

| Key | Summary | Last Updated | Commander | Age (days) |
|-----|---------|-------------|-----------|------------|
| RDINC-XXXX | ... | YYYY-MM-DD | ... | X |

*If none: "No stalled retrospectives in this period."*

## Overdue action items

| Retro | Action Item | Assignee | Due Date | Days Overdue |
|-------|------------|----------|----------|-------------|
| RDINC-XXXX | RDEV-XXXX | ... | YYYY-MM-DD | X |

*If none: "No overdue action items."*

## Data gaps

- [Any metrics that couldn't be retrieved or had quality issues]

*If none: "All metrics retrieved successfully."*

---

## Next actions

- [ ] Review findings with Vera (Process Engineering Lead)
- [ ] Validate trend interpretation
- [ ] Prepare narrative for Ops Review presentation
- [ ] Cross-check with Change Management section (partner skill: `/cm-review-prep`)
```

After generating the file, output:

```
✓ Retro review data ready at `meetings/prep/YYYY-MM-DD-retro-review-data.md`

**Key findings:**
- [Summary of 3 most important findings]

**Next steps:**
1. Review the data file
2. Run `/ops-review-prep` to combine with CM data into the full prep (when available)
3. Draft narrative for presentation
```

## Reference: Power BI Model Schema

**Retrospectives** semantic model — 36 tables, 61 measures

Key tables:
- `OTHER_PROPERTIES` (38 cols): ISSUE_KEY, SUMMARY, STATUS_NAME, CREATED_DATE, RESOLVED_DATE, CLOSING_DATE, RCA_CATEGORY, RETROSPECTIVE_COMMANDER, INCIDENT_COMMANDER, REVIEWER, APPROVER, IS_REVIEWED, IS_APPROVED, RETROSPECTIVE_STATUS (calculated), Retrospective Leadtime, Actions_Items_Leadtime, SEVERITY, SYSTEM_WIDE_IMPACT, RETROSPECTIVE_NEEDED, RETROSPECTIVE_COMPLETED_DATE, READOUT_DATE, LAST_UPDATE, Retrospective Aging (Days), Incident Aging (Days), Aging Group (calculated)
- `LINKED_ISSUES` (18 cols): ISSUE_KEY, LINKED_ISSUE, LINKED_ISSUE_TYPE, LINKED_ISSUE_STATUS, LINKED_ISSUE_STATUS_CATEGORY, LINKED_ISSUE_DUE_DATE, Days to Due (calculated), LINKED_ISSUE_ASSIGNE, LINKED_ISSUE_SUMMARY, LINKED_ISSUE_CREATED_DATETIME
- `INCIDENTS_DISTINCT` (25 cols): ISSUE_KEY, CREATED_DATE, RESOLUTION_DATE, SEVERITY, INCIDENT_TYPE, RING, STATUS, TEAM_NAME, E2E_FULL_RESOLUTION_TIME, RD_RESOLUTION_TIME, RD_MTTR, INCIDENT_MTTR
- `TEAMS`: ISSUE_KEY, TEAMS
- `Calendar`: shared date dimension
- Pre-built measures in `# Incidents`, `Retrospectives`, `Times Spent` tables

**Measures that fail in DAX queries** (use USERELATIONSHIP internally):
- `# Created Incidents`, `# Solved Incidents` — use direct COUNTROWS on INCIDENTS_DISTINCT with date filters instead

## Reference: Retrospective Process

**Confluence:** [Retrospective Process](https://outsystemsrd.atlassian.net/wiki/spaces/RKB/pages/4696212894/Retrospective+Process)

**Jira project:** RDINC (workflow: In Progress → Completed → Closed)
- "Completed" = retro approved, action items may still be open
- "Closed" = all action items delivered to production
- Roles: Commander, Reviewer, Approver
- RCA method: 5-Whys

**Data source priority:**
1. **Playwright** → Power BI report (same visuals stakeholders see)
2. **DAX queries** → drill into specific numbers when charts aren't enough
3. **Jira RDINC** → fill data gaps (action item details, stalled retros, recent updates)

## Tips

- **Prefer Playwright** reading of the Power BI report — it matches what stakeholders see
- **Use DAX sparingly** for drill-down only (commander gaps by name, overdue action item lists)
- **Use Jira** for what Power BI doesn't have: stalled retro detail, action item assignees, recent comments
- **Always show trend data** — compare to previous Ops Review
- **Flag data gaps explicitly** — missing due dates, unlinked items, blank RCA categories are signals worth surfacing
- The retro process may evolve with M3.5 (Retrospective Transformation) — check `initiatives/active/retrospectives/` for active changes
- If Playwright fails, fall back to DAX queries, then Jira
- Keep narrative concise — Value Stream Leaders get 2 minutes per section in Ops Review
