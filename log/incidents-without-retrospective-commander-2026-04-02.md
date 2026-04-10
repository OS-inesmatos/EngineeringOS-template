# Incidents Without Retrospective Commander
*Analysis date: 2026-04-02*

## Summary

**Total incidents:** 17

**Change from last analysis (2026-03-25):** -1 incident (18 → 17)

---

## Status Distribution

| Status | Count | % of Total |
|--------|-------|------------|
| Solved | 15 | 88.2% |
| Retrospective In Progress | 2 | 11.8% |

---

## Priority Distribution

| Priority | Count | % of Total |
|----------|-------|------------|
| High | 14 | 82.4% |
| Urgent | 3 | 17.6% |

---

## Severity Distribution

| Severity | Count | % of Total |
|----------|-------|------------|
| Sev2 | 15 | 88.2% |
| Sev1 | 2 | 11.8% |

**Sev1 incidents** (highest severity - require immediate attention):
- 2 incidents at Sev1 level waiting for Retrospective Commander assignment

---

## Key Insights

### Comparison with Previous Analysis (2026-03-25)

**Incidents resolved (no longer in list):**
- RDINC-68135 (PaaS) - 69 days old on last analysis
- ✅ Progress: 1 of 3 priority incidents from last analysis was resolved

**Still pending (from previous analysis):**
- RDINC-67563 - Was 79 days old, now ~87 days (oldest incident)
- RDINC-68402 - Was 64 days old, now ~72 days

**New incidents added since last analysis:**
- 14 new incidents entered Solved status without Retrospective Commander assigned
- Most are High priority (14 incidents)
- 3 are Urgent priority

### Oldest Incidents (by key number - approximation)

The oldest incidents still waiting for Retrospective Commander:

| Key | Priority | Status | Summary |
|-----|----------|--------|---------|
| RDINC-67563 | High | Solved | System-wide - ga - prometheus-availability |
| RDINC-68402 | High | Solved | ODC - 1CP of Apps and Agents Timing out in EA, EU-Central-1 region |
| RDINC-68929 | High | Retrospective In Progress | Username attribute from the User entity was missing intermittently |
| RDINC-68947 | High | Solved | Icon re-size properties does not work as expected |
| RDINC-69224 | High | Solved | System-wide - ga - morpheus_ai_llm_gw_error_rate_nonga |

---

## Retrospective In Progress Status

2 incidents are in "Retrospective In Progress" status but still have no Retrospective Commander assigned:

| Key | Priority | Summary |
|-----|----------|---------|
| RDINC-74666 | High | System-wide - osall - tenant-provisioning-success-rate |
| RDINC-68929 | High | Username attribute from the User entity was missing intermittently |

**⚠️ Red flag:** These incidents have started the retrospective process but lack a commander to drive completion.

---

## Patterns & Trends

### System-wide Incidents
Multiple incidents affecting system-wide metrics:
- tenant-provisioning-success-rate (3 incidents: RDINC-76734, RDINC-74666, RDINC-73538)
- Multiple GA ring incidents (prometheus, gateway-proxy, runtime success)

### Recurring Themes
- **Tenant provisioning issues** - recurring pattern across osall ring
- **GA ring stability** - multiple incidents affecting GA environment
- **ODC Portal/Studio issues** - several customer-facing incidents

---

## Recommendations for Ops Review

1. **Priority action:** Assign Retrospective Commanders to the 3 oldest incidents (RDINC-67563, RDINC-68402, RDINC-68929)
2. **Process improvement:** Investigate why 2 incidents moved to "Retrospective In Progress" without a commander assigned
3. **Pattern analysis:** Consider clustering retrospectives for related incidents (tenant-provisioning, GA ring stability)
4. **Trend:** Despite 1 incident resolved, 14 new incidents entered the backlog - net increase in workload

---

*Source: Jira query executed 2026-04-02*
*Query:* `project = RDINC AND "Retrospective Needed[Dropdown]" = Yes AND status IN (Solved, "Retrospective In Progress") AND "RCA Request Date/Time[Time stamp]" > now() AND "Retrospective Commander[Short text]" IS empty`
