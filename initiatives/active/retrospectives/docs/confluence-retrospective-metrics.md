# Retrospective Process Metrics Analysis
## System-wide Impact Incidents (Last 6 Months)

**Analysis Date:** March 11, 2026
**Period:** September 2025 - March 2026
**Issues Analyzed:** 18 incidents with System-wide impact = Yes
**Data Source:** RDINC Jira Project

---

## Executive Summary

The retrospective process for system-wide impact incidents currently takes an average of **92.87 days (~3 months)** from the time an incident is marked as "Solved" until all retrospective activities are completed and the issue is closed.

**Key Findings:**
- 🔴 **"Retrospective In Progress" is the major bottleneck**, consuming **69% of total time** (63.66 days average)
- ⚠️ **Commander assignment is delayed** by ~13 days after the incident moves to "Solved" status
- 📊 **High variability** in process duration: ranges from 1 day to 135 days
- ❌ **22% of issues** (4 out of 18) never had a Retrospective Commander assigned

---

## Key Metrics Overview

### Process Timeline (Average Days)

| Stage | Average Days | Median | Min | Max | % of Total |
|-------|--------------|--------|-----|-----|------------|
| **Time in "Solved" Status** | 15.80 | 10.56 | 0 | 44.77 | 17% |
| **Time to Commander Assignment** | 28.52 | 28.17 | 0 | 57.06 | - |
| **Time to RCA Presentation** | 36.55 | 40.95 | 8.56 | 79.99 | - |
| **Time in "Retro In Progress"** | 63.66 | 68.79 | 0 | 101.13 | **69%** ⚠️ |
| **Time in "Retro Completed"** | 13.41 | 6.80 | 0 | 65.09 | 14% |
| **TOTAL PROCESS** | **92.87** | **98.86** | **0.01** | **134.79** | **100%** |

### Visual Process Flow

```
Incident moved to "Solved"
        ↓
  [15.80 days] ▓▓▓▓ Solved Status
        ↓
  [28.52 days] ▓▓▓▓▓▓▓ Commander Assignment ⚠️ (+13 days delay)
        ↓
  [36.55 days] ▓▓▓▓▓▓▓▓▓ RCA Presentation Scheduled
        ↓
  [63.66 days] ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ Retrospective In Progress 🔴
        ↓
  [13.41 days] ▓▓▓▓ Retrospective Completed
        ↓
Issue Closed

TOTAL: ~93 days (3 months)
```

---

## Detailed Metric Analysis

### 1. Time in "Solved" Status
**Average: 15.80 days** | Median: 10.56 days

This represents the time an incident remains in "Solved" status before transitioning to "Retrospective In Progress".

**Top 5 Longest:**
1. RDINC-61437: 44.77 days
2. RDINC-61911: 40.95 days
3. RDINC-62612: 35.56 days
4. RDINC-67391: 34.61 days
5. RDINC-63322: 30.24 days

---

### 2. Time to Retrospective Commander Assignment
**Average: 28.52 days** | Median: 28.17 days

Time from "Solved" status until a Retrospective Commander is assigned to the incident.

**Distribution:**
- ✅ 14 issues had a commander assigned (78%)
- ❌ 4 issues never had a commander assigned (22%)

**Top 5 Longest Assignments:**
1. RDINC-63322: 57.06 days
2. RDINC-64437: 45.00 days
3. RDINC-64289: 43.99 days
4. RDINC-67391: 34.61 days
5. RDINC-65439: 34.17 days

**Issues Without Commander:**
- RDINC-61437 (134.79 days total)
- RDINC-61911 (130.97 days total)
- RDINC-62612 (125.58 days total)
- RDINC-64612 (test issue)

⚠️ **Critical Finding:** Commander assignment occurs **13 days AFTER** the issue exits "Solved" status on average, indicating a significant gap in the handoff process.

---

### 3. Time to RCA Presentation
**Average: 36.55 days** | Median: 40.95 days

Time from "Solved" status until the RCA Request Date/Time (scheduled presentation date).

**Distribution:**
- ✅ 17 issues had presentations scheduled (94%)
- ❌ 1 issue without presentation scheduled (6%)

**Top 5 Longest to Presentation:**
1. RDINC-63322: 79.99 days
2. RDINC-64289: 63.92 days
3. RDINC-61732: 62.83 days
4. RDINC-64437: 60.06 days
5. RDINC-65439: 54.11 days

**Fastest to Presentation:**
1. RDINC-62612: 8.56 days
2. RDINC-61437: 8.76 days
3. RDINC-63691: 10.84 days
4. RDINC-61899: 10.84 days
5. RDINC-61911: 10.94 days

---

### 4. Time in "Retrospective In Progress"
**Average: 63.66 days** | Median: 68.79 days | **69% of total time** 🔴

This is the **largest bottleneck** in the retrospective process.

**Issues Exceeding 80 Days:**
1. RDINC-64639: 101.13 days
2. RDINC-61943: 91.04 days
3. RDINC-64437: 84.23 days
4. RDINC-63322: 83.95 days
5. RDINC-62612: 83.22 days
6. RDINC-61911: 83.22 days
7. RDINC-61437: 83.22 days

**Pattern Observed:** Multiple issues clustered around **83 days**, suggesting a systemic delay or blocker at this stage.

---

### 5. Time in "Retrospective Completed"
**Average: 13.41 days** | Median: 6.80 days

Time from retrospective completion until all improvement action items are closed.

**Issues Exceeding 60 Days:**
1. RDINC-63691: 65.09 days
2. RDINC-63743: 63.12 days
3. RDINC-61732: 49.02 days

Most issues (75%) complete this stage within **20 days**.

---

## Top Issues Analysis

### Slowest Issues (Total Duration)

| Rank | Issue | Total Days | Solved | To Commander | To RCA Pres | Retro In Prog | Retro Completed |
|------|-------|------------|--------|--------------|-------------|---------------|-----------------|
| 1 | RDINC-61437 | 134.79 | 44.77 | ❌ No | 8.76 | 83.22 | 6.80 |
| 2 | RDINC-61732 | 132.86 | 8.80 | 11.83 | 62.83 | 75.04 | 49.02 |
| 3 | RDINC-61911 | 130.97 | 40.95 | ❌ No | 10.94 | 83.22 | 6.80 |
| 4 | RDINC-62612 | 125.58 | 35.56 | ❌ No | 8.56 | 83.22 | 6.80 |
| 5 | RDINC-63322 | 120.03 | 30.24 | 57.06 | 79.99 | 83.95 | 5.84 |

**Common Pattern:** 3 of the 5 slowest issues had **no Retrospective Commander assigned**.

---

### Fastest Issues (Total Duration)

| Rank | Issue | Total Days | Summary | Key Success Factor |
|------|-------|------------|---------|-------------------|
| 1 | RDINC-64612 | 0.01 | Test issue | N/A (test) |
| 2 | RDINC-72566 | 34.99 | Cannot publish web apps | Quick commander assignment (13 days) |
| 3 | RDINC-65439 | 61.40 | NATS degradation | Relatively fast RCA presentation |
| 4 | RDINC-65898 | 62.37 | Static entities build failure | Standard process timeline |
| 5 | RDINC-67391 | 65.96 | GET portfolios API 500 errors | Consistent progress |

---

## Critical Findings

### 🔴 Finding #1: Commander Assignment Delay

**Problem:** Retrospective Commander is assigned **13 days AFTER** the issue exits "Solved" status.

**Impact:**
- Delays the start of retrospective work
- Creates ambiguity about ownership
- 22% of issues never get a commander assigned

**Recommendation:**
- ✅ Automate commander assignment when incident moves to "Solved"
- ✅ Create a rotation schedule for commanders
- ✅ Make the field mandatory with validation
- ✅ Target: < 2 days for commander assignment

---

### 🔴 Finding #2: "Retrospective In Progress" Bottleneck

**Problem:** This stage consumes **69% of total time** (average 63.66 days).

**Impact:**
- Incidents remain open for 2+ months in retro phase
- 39% of issues exceed 80 days in this state
- Clear pattern of ~83 days suggests systemic blocker

**Recommendation:**
- ✅ Implement 30-day SLA for this stage
- ✅ Mandatory weekly status check-ins
- ✅ Identify and remove common blockers
- ✅ Create templates to accelerate preparation
- ✅ Escalation path for blocked retrospectives

---

### 🟡 Finding #3: High Variability in RCA Presentation Timing

**Problem:** RCA presentations range from 8.56 to 79.99 days (9x difference).

**Impact:**
- Inconsistent process timing
- Difficult to set expectations
- Some retrospectives delayed significantly

**Recommendation:**
- ✅ Standard SLA: Schedule RCA presentation within 30 days of "Solved"
- ✅ Create fixed calendar of presentation slots
- ✅ Prioritize by incident severity
- ✅ Reserve emergency slots for critical incidents

---

### 🟡 Finding #4: Action Item Closure Delays

**Problem:** Some issues take 60+ days to close improvement action items after retro completion.

**Impact:**
- Delays final closure of incidents
- Action items may lose priority over time
- Difficulty tracking follow-through

**Recommendation:**
- ✅ Set 14-day SLA for action item closure
- ✅ Automated weekly follow-up reminders
- ✅ Escalate blocked action items to leadership
- ✅ Track action item completion as a team metric

---

## Improvement Targets

### Current vs. Target Performance

| Metric | Current | Target | Improvement | Impact |
|--------|---------|--------|-------------|--------|
| Time to Commander Assignment | 28.52 days | **2 days** | -93% | High priority |
| Time to RCA Presentation | 36.55 days | **30 days** | -18% | Medium priority |
| Time in Retro In Progress | 63.66 days | **30 days** | -53% | **Critical** |
| Time in Retro Completed | 13.41 days | **10 days** | -25% | Low priority |
| **TOTAL PROCESS** | **92.87 days** | **45 days** | **-52%** | **Overall Goal** |

**Goal:** Reduce overall retrospective process from **~3 months** to **~1.5 months**.

---

## Issue Breakdown

### By Status Category

| Current Status | Count | % |
|----------------|-------|---|
| Closed | 10 | 56% |
| Retrospective Completed | 7 | 39% |
| Cancelled | 1 | 5% |

### By Commander Assignment

| Assignment Status | Count | % |
|-------------------|-------|---|
| Commander Assigned | 14 | 78% |
| No Commander | 4 | 22% |

### By RCA Presentation

| Presentation Status | Count | % |
|---------------------|-------|---|
| Presentation Scheduled | 17 | 94% |
| No Presentation | 1 | 6% |

---

## Complete Issue List

### All 18 System-wide Impact Issues

| Issue | Summary | Current Status | Total Days | Solved Days | Commander Days | RCA Days | Retro In Progress | Retro Completed |
|-------|---------|----------------|------------|-------------|----------------|----------|-------------------|-----------------|
| RDINC-72566 | Cannot publish web apps | Retro Completed | 34.99 | 7.01 | 13.10 | 40.95 | 16.18 | 11.81 |
| RDINC-67391 | GET portfolios API 500 errors | Closed | 65.96 | 34.61 | 34.61 | 43.72 | 31.33 | 0.02 |
| RDINC-65898 | Static entities build failure | Closed | 62.37 | 5.11 | 28.17 | 51.11 | 57.25 | 0.01 |
| RDINC-65652 | Cannot publish OS-DPL-40802 | Retro Completed | 92.10 | 2.32 | 27.11 | 42.07 | 68.79 | 20.99 |
| RDINC-65439 | NATS degradation | Closed | 61.40 | 7.36 | 34.17 | 54.11 | 54.04 | 0.00 |
| RDINC-64639 | End-users password reset | Retro Completed | 103.11 | 0.00 | 0.00 | 19.09 | 101.13 | 1.98 |
| RDINC-64612 | Test issue | Cancelled | 0.01 | 0.00 | No | No | 0.00 | 0.01 |
| RDINC-64437 | PE users login failure | Retro Completed | 105.76 | 19.73 | 45.00 | 60.06 | 84.23 | 1.80 |
| RDINC-64289 | Deployment timeouts | Closed | 98.86 | 17.16 | 43.99 | 63.92 | 81.68 | 0.02 |
| RDINC-63743 | PE login failure | Retro Completed | 112.99 | 8.09 | 8.09 | 13.97 | 41.80 | 63.12 |
| RDINC-63691 | Tenant provisioning bug | Retro Completed | 109.86 | 0.00 | 0.00 | 10.84 | 44.77 | 65.09 |
| RDINC-63322 | NATS deployment issues | Retro Completed | 120.03 | 30.24 | 57.06 | 79.99 | 83.95 | 5.84 |
| RDINC-62612 | Tenant provision stuck | Retro Completed | 125.58 | 35.56 | No | 8.56 | 83.22 | 6.80 |
| RDINC-61943 | Build timeout spike | Closed | 101.60 | 10.56 | 10.56 | 39.57 | 91.04 | 0.00 |
| RDINC-61911 | Tenant provisioning stuck | Retro Completed | 130.97 | 40.95 | No | 10.94 | 83.22 | 6.80 |
| RDINC-61899 | SAP connections broken | Closed | 78.42 | 12.22 | -0.16 | 10.84 | 65.02 | 1.18 |
| RDINC-61732 | OSALL 1CP timeout | Retro Completed | 132.86 | 8.80 | 11.83 | 62.83 | 75.04 | 49.02 |
| RDINC-61437 | Tenant provision stuck | Retro Completed | 134.79 | 44.77 | No | 8.76 | 83.22 | 6.80 |

---

## Methodology

### Data Collection
- **Source:** RDINC Jira Project via REST API
- **Filter Criteria:**
  - System-wide impact? = Yes
  - Status changed to "Retrospective Completed" in last 6 months
- **Analysis Period:** September 2025 - March 2026
- **Sample Size:** 18 incidents

### Metrics Calculated
1. **Time in "Solved"**: Duration in Solved status before transitioning
2. **Time to Commander**: Days from Solved to Retrospective Commander assignment
3. **Time to RCA Presentation**: Days from Solved to RCA Request Date/Time
4. **Time in "Retro In Progress"**: Duration in active retrospective status
5. **Time in "Retro Completed"**: Duration closing improvement action items

### Tools Used
- PowerShell scripts for API interaction
- Jira REST API for data extraction
- Changelog analysis for state transitions
- Custom field tracking (customfield_16516, customfield_17788, customfield_16357)

---

## Data Files

All raw data and analysis scripts are available:

**CSV Data Files:**
- `retrospective-metrics-system-wide.csv` - Full metrics by state
- `time-to-commander-assignment.csv` - Commander assignment timeline
- `time-to-rca-presentation.csv` - RCA presentation timeline

**PowerShell Scripts:**
- `Get-RetroMetrics.ps1` - Calculate metrics by state
- `Calculate-TimeToCommanderAssignment.ps1` - Commander assignment analysis
- `Calculate-TimeToRCAPresentation.ps1` - RCA presentation analysis
- `Filter-BySystemWideImpact.ps1` - Filter issues by impact field

---

## Next Steps

### Immediate Actions (Week 1-2)
1. ✅ Present findings to retrospective stakeholders
2. ✅ Implement mandatory commander assignment automation
3. ✅ Establish 30-day SLA for "Retro In Progress"
4. ✅ Create weekly check-in process for in-progress retrospectives

### Short-term Actions (Month 1-2)
1. ✅ Develop retrospective templates to accelerate preparation
2. ✅ Create fixed calendar for RCA presentations
3. ✅ Implement automated reminder system for action items
4. ✅ Track and analyze blocker patterns in "Retro In Progress"

### Long-term Actions (Month 3-6)
1. ✅ Re-measure metrics after process improvements
2. ✅ Compare before/after performance
3. ✅ Adjust targets based on observed improvements
4. ✅ Standardize best practices across all retrospectives

---

## Contact & Questions

For questions about this analysis or to request additional metrics:
- **Analysis Date:** March 11, 2026
- **Data Owner:** Ines Matos (ines.matos@outsystems.com)
- **Jira Project:** RDINC

---

*This analysis was generated using automated scripts and Jira REST API data. All metrics are based on actual incident timelines from the RDINC project.*
