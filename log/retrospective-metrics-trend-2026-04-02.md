# Retrospective Process Metrics - Trend Analysis
*Analysis period: February 5 - April 2, 2026*

## Data Summary

| Date | Active Retrospectives | Lead Time (days) | Change in Retros | Change in Lead Time |
|------|----------------------|------------------|------------------|---------------------|
| Feb 5, 2026 | 59 | 71 | - | - |
| Feb 19, 2026 | 56 | 73 | -3 (-5.1%) | +2 (+2.8%) |
| Mar 5, 2026 | 42 | 85 | -14 (-25.0%) | +12 (+16.4%) |
| Mar 19, 2026 | 35 | 89 | -7 (-16.7%) | +4 (+4.7%) |
| Apr 2, 2026 | 27 | 90 | -8 (-22.9%) | +1 (+1.1%) |

**Overall Change (Feb 5 → Apr 2):**
- Active Retrospectives: 59 → 27 **(-54.2%)**
- Lead Time: 71 → 90 days **(+26.8%)**

---

## Key Insights

### Positive Trend
✅ **Volume is decreasing** - Successfully reducing the backlog of active retrospectives by more than half in 2 months.

### Concerning Trend
⚠️ **Lead Time is increasing** - Time to complete each retrospective has grown from 71 to 90 days (+19 days).

### The Paradox
**We're closing retrospectives faster than we're creating new ones, BUT each one is taking longer to complete.**

Possible explanations:
1. **Resource constraint** - Fewer people available to drive retrospectives
2. **Complexity increase** - Remaining retrospectives are more complex incidents
3. **Process bottleneck** - Commander assignment delays, review cycles taking longer
4. **Priority shift** - Focus on older, more complex retrospectives first

---

## Connection to Current Data

Today's snapshot (April 2, 2026):
- **17 incidents without Retrospective Commander** (down from 18 on March 25)
- 2 Sev1 incidents waiting for assignment
- 2 incidents in "Retrospective In Progress" status but no commander assigned

**Hypothesis:** The 90-day lead time correlates with incidents sitting without commanders for extended periods before work begins.

---

## Recommendations

### 1. Investigate Lead Time Root Causes
- Break down lead time by phase: assignment delay, investigation time, documentation time, review cycles
- Identify which phase is growing (likely assignment delay based on 17 unassigned incidents)

### 2. Commander Assignment Process
- Implement SLA for commander assignment (e.g., within 5 days of incident closure)
- Create rotation or dedicated pool of commanders to reduce assignment delays

### 3. Cluster Related Retrospectives
- Group similar incidents (e.g., tenant-provisioning, GA ring stability) into single retrospectives
- Reduces total count AND improves lead time efficiency

### 4. Set Lead Time Target
- Current: 90 days (increasing)
- Target: 60 days (based on Feb baseline + buffer)
- Track weekly to prevent further degradation

---

## For Ops Review Presentation

### Slide 1: The Trend
**Chart:** Dual-axis line chart
- Blue line (left axis): Active Retrospectives (59 → 27, descending)
- Red line (right axis): Lead Time in days (71 → 90, ascending)

**Key message:** "We're reducing volume but losing speed"

### Slide 2: Current State
- 17 incidents without commander (including 2 Sev1)
- 2 in progress without commander
- Oldest incident: ~87 days old

### Slide 3: Action Plan
1. Root cause analysis on lead time increase
2. Commander assignment SLA implementation
3. Clustering strategy for related incidents
4. Lead time target: 60 days by end of Q2

---

*Data source: Retrospective dashboard snapshot 2026-04-02*
*Supporting analysis: incidents-without-retrospective-commander-2026-04-02.md*
