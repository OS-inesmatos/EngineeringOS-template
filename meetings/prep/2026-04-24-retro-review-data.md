# Retrospective Review Data — 2026-04-24
**Review period:** 2026-04-16 to 2026-04-30

---

## Key findings

- **Backlog nearly eliminated** — Active retrospectives dropped from 27 to 1 (-96.3%), achieving the lowest backlog count on record. Only 1 retro remains (Pending Approval status).
- **Lead time increased slightly** — Average leadtime rose from 90 to 95 days (+5 days, +5.6%). While backlog cleared dramatically, each retro now takes longer to complete, suggesting focus on quality over speed.
- **Commander assignment remains a gap** — 22 retrospectives (17% of total) still lack an assigned Commander, down from 17 in early April but still above target threshold.

---

## Metrics

### Status distribution

| Status | Count | % of Total |
|--------|-------|------------|
| **Active (all statuses)** | **1** | **0.78%** |
| In Progress | 0 | 0% |
| Completed (action items open) | 88 | 68.22% |
| Stalled (no movement > 15 days) | *Data gap* | — |
| In Backlog | 0 | 0% |
| Pending Review | 0 | 0% |
| Pending Approval | 1 | 0.78% |
| **Closed** | **40** | **31.01%** |

### Root cause distribution

| Category | Count | % | Trend |
|----------|-------|---|-------|
| Infrastructure issues | 39 | 30.47% | — |
| Application issues | 36 | 28.13% | — |
| Configuration issues | 26 | 20.31% | — |
| Deployment issues | 13 | 10.16% | — |
| Operational Issues | 8 | 6.25% | — |
| Other (incl. blank, missing feature, tests) | 6 | 4.66% | — |

**Analysis:** Infrastructure and Application issues account for nearly 60% of root causes. No single category dominates (threshold: >50%), indicating diverse failure modes rather than systemic weakness in one area.

### Action item health

| Metric | Count |
|--------|-------|
| Total created (linked to active retros) | 418 |
| Concluded | 374 |
| Completeness % | 86.16% |
| Overdue (past due date) | 17 |
| On due (at risk) | 22 |
| Missing due date (data gap) | 5 |
| Avg time to complete | 39.72 days |

**Alert:** 17 overdue action items exceeds threshold (>5). Breakdown:
- 82.35% in "To Do" status (14 items)
- 17.65% "In Progress" (3 items)

### Commander assignment

| Metric | Count | % |
|--------|-------|---|
| Total retrospectives | 129 | — |
| With Commander | 107 | 82.95% |
| Without Commander (Blank) | 22 | 17.05% |

**Alert:** 17.05% unassigned is below threshold (40%), but still represents a process gap. These retros likely contribute to extended lead times.

### Lead times

| Metric | Days |
|--------|------|
| Avg retrospective leadtime | 95.00 |
| Time to start retro | 19.16 |
| Time to complete retro | *Data gap* |
| Time to complete action items | 39.72 |
| Avg retrospective aging | 192.00 |

**Note:** "Average Retrospective Aging" (192 days) measures how long retrospectives have been open, including older backlog items now in Completed status.

### Throughput

| Metric | Count |
|--------|-------|
| New in period (2026-04-16 to 2026-04-30) | *Data gap — requires Jira query* |
| Closed in period | *Data gap — requires Jira query* |
| Net change | Active: 27 → 1 (-26) |

**Note:** Power BI data shows dramatic backlog reduction, but exact period-specific throughput requires Jira JQL queries not available in this run.

### Trend comparison

| Metric | Previous (2026-04-02) | Current (2026-04-24) | Change |
|--------|----------|---------|--------|
| Active backlog | 27 | 1 | **-26 (-96.3%)** ✅ |
| Unassigned Commanders | 17 | 22 | +5 (+29.4%) ⚠️ |
| Avg lead time (days) | 90 | 95 | +5 (+5.6%) ⚠️ |
| Overdue action items | *Not tracked* | 17 | — |

---

## Stalled retros (no update > 15 days)

*Data gap: Requires Jira query with `updated <= "-15d"` filter. Power BI does not expose last-update timestamps.*

**Workaround for next run:** Use `mcp__claude_ai_Atlassian__searchJiraIssuesUsingJql` with:
```jql
project = RDINC AND "Retrospective Status" in ("In Progress", "Completed") AND updated <= "-15d" ORDER BY updated ASC
```

---

## Overdue action items

*Data gap: Power BI shows **17 overdue** items but does not expose assignee or retro linkage details.*

**Top action items by frequency** (affecting multiple incidents):
- RPM-6546: 19 incidents (Due Date not Available)
- RDPEN-1018: 4 incidents (Completed)
- RDCCP-2204, RDICE-4658, RDICE-5023, RDMAST-2025, RDMOT-2141, RDMOT-2622, RDODCP-60, RDSPT-5282, RDSPT-5320: 2 incidents each

**Workaround for next run:** Use Jira JQL to fetch overdue items with assignee and retro linkage:
```jql
project in (RDEV, RDPIM, RSA, APPSEC) AND issueFunction in linkedIssuesOf("project = RDINC AND 'Retrospective Status' in ('In Progress', 'Completed')") AND duedate < now() AND status not in (Done, Closed, Completed, Discarded) ORDER BY duedate ASC
```

---

## Data gaps

1. **Stalled retrospectives list** — Power BI does not expose `LAST_UPDATE` field for filtering retros with no activity in 15+ days. Requires Jira query.
2. **Overdue action item assignees** — Power BI shows count (17) but not assignee names or specific retro linkage. Requires Jira query.
3. **Period-specific throughput** — New retros and closed retros within 2026-04-16 to 2026-04-30. Power BI filters applied but specific counts not extracted. Requires Jira JQL with date ranges.
4. **Previous root cause distribution** — No baseline from April 2 review for trend comparison. Next review should capture current state for future trends.
5. **Confluence baseline** — MCP tool unavailable; used local file `log/retrospective-metrics-trend-2026-04-02.md` as baseline.

---

## Analysis

### What changed since last review (2026-04-02)?

| Metric | Movement | Interpretation |
|--------|----------|----------------|
| **Active backlog** | 27 → 1 (-96.3%) | **Breakthrough progress.** Backlog nearly cleared. Likely result of M3.5 Retrospective Transformation initiative + focused effort. |
| **Lead time** | 90 → 95 days (+5.6%) | **Trade-off accepted.** Slightly longer per-retro completion time suggests quality focus (thorough investigations, complete action items) over velocity. Still needs monitoring. |
| **Unassigned Commanders** | 17 → 22 (+29.4%) | **Process regression.** More retros without commanders despite lower backlog. Indicates assignment process not keeping pace with closures. |
| **Overdue action items** | Not tracked → 17 | **New visibility.** First time tracked in Ops Review. 17 overdue items suggests action item follow-through is a weak point. |

### Why it matters

1. **Backlog elimination** — Reduces risk of retrospectives becoming stale, losing context, or missing improvement opportunities. Enables real-time learning from incidents.
2. **Lead time increase** — While small (+5 days), trend direction is concerning. If lead time continues growing, retrospectives lose relevance. Target: stabilize at 60 days.
3. **Commander assignment gaps** — Retros without commanders sit idle. 22 unassigned retros (even if "Completed" status) represent incomplete process execution and potential compliance gaps.
4. **Overdue action items** — 17 overdue items means identified improvements aren't being delivered. Risk: recurring incidents due to unaddressed root causes.

### What we're doing about it

**Active initiatives** (from `initiatives/active/retrospectives/`):
1. **M3.5 Retrospective Transformation** — New model to streamline process, reduce bottlenecks. Rollout plan in progress.
2. **RCA Framework v2.0** — Pre/post-assessment split to improve retrospective quality and catch issues earlier.
3. **Commander assignment SLA** (proposed in April 2 review) — Not yet implemented. Recommend prioritizing this to address 22 unassigned retros.

**Next actions:**
- [ ] Root cause analysis on +5 day lead time increase (break down by phase: assignment, investigation, documentation, review)
- [ ] Implement Commander assignment SLA (target: within 5 days of incident resolution)
- [ ] Escalate 17 overdue action items to owning teams (use `initiatives/active/retrospectives/docs/` for tracking)
- [ ] Validate "Completed" status accuracy (88 retros marked Completed — are they truly awaiting only action item delivery?)

### What we need from you

**Ask to Value Stream Leaders:**
1. **Action item prioritization** — 17 overdue items across RDEV, RDPIM, RSA, APPSEC. Can VSLs commit to clearing overdue action items within next sprint?
2. **Commander assignment ownership** — Who owns ensuring every retrospective has a Commander within 5 days? Process Engineering can flag unassigned retros but cannot assign.
3. **M3.5 rollout support** — Retrospective Transformation model ready for pilot. Which value stream can pilot first?

---

## Next actions

- [ ] Review findings with Vera (Process Engineering Lead)
- [ ] Validate trend interpretation (especially lead time increase)
- [ ] Drill down on 22 unassigned Commanders (Jira query for specific retro keys)
- [ ] Drill down on 17 overdue action items (Jira query for assignees and due dates)
- [ ] Prepare narrative for Ops Review presentation (focus on backlog win + action item follow-through gap)
- [ ] Cross-check with Change Management section (partner skill: `/cm-review-prep`)

---

## Reference: Data sources

- **Primary:** Power BI Retrospective Management Dashboard (accessed 2026-04-24, data updated 2026-04-24)
- **Baseline:** `log/retrospective-metrics-trend-2026-04-02.md` (previous Ops Review)
- **Gaps filled by:** None (Atlassian MCP unavailable; Jira queries not executed)

**For next run:** Ensure MCP tools available:
- `mcp__claude_ai_Atlassian__searchJiraIssuesUsingJql` — stalled retros, overdue action items
- `mcp__claude_ai_Atlassian__searchConfluenceUsingCql` — previous Ops Review baseline
- `mcp__fabric__ConnectFabric` + `ExecuteDaxQuery` — drill-down queries (optional fallback)
