# Incidents Without Retrospective Commander
*Analysis date: 2026-03-25*

## Summary

**Total incidents:** 18

---

## Distribution by Value Stream

| Value Stream | Count | % of Total |
|--------------|-------|------------|
| PaaS | 3 | 16.7% |
| Mobile | 3 | 16.7% |
| ALM | 3 | 16.7% |
| Production Engineering | 2 | 11.1% |
| Identity | 2 | 11.1% |
| AI | 2 | 11.1% |
| Agentic Apps & Data | 2 | 11.1% |
| Cloud Platform | 1 | 5.6% |

---

## Distribution by Age

| Age Range | Count | % of Total |
|-----------|-------|------------|
| 0-30 days | 6 | 33.3% |
| 31-60 days | 9 | 50.0% |
| 61-90 days | 3 | 16.7% |
| 90+ days | 0 | 0% |

---

## Detailed Distribution: Value Stream × Age

| Value Stream | 0-30 days | 31-60 days | 61-90 days | **Total** |
|--------------|-----------|------------|------------|-----------|
| PaaS | 2 | 0 | 1 | **3** |
| Mobile | 1 | 2 | 0 | **3** |
| ALM | 2 | 1 | 0 | **3** |
| Production Engineering | 0 | 1 | 1 | **2** |
| Identity | 0 | 2 | 0 | **2** |
| AI | 1 | 1 | 0 | **2** |
| Agentic Apps & Data | 0 | 2 | 0 | **2** |
| Cloud Platform | 0 | 0 | 1 | **1** |
| **TOTAL** | **6** | **10** | **3** | **18** |

---

## Key Insights

1. **50% of incidents are 31-60 days old** - majority in mid-age range
2. **No incidents older than 90 days** - oldest incident is from early January
3. **PaaS, Mobile, and ALM each have 3 incidents** - highest volume Value Streams
4. **3 incidents are 61-90 days old** - these are the oldest and should be prioritized:
   - RDINC-67563 (Production Engineering) - 79 days old
   - RDINC-68135 (PaaS) - 69 days old
   - RDINC-68402 (Cloud Platform) - 64 days old

---

## Oldest Incidents (Priority)

| Key | Value Stream | Created | Age (days) | Summary |
|-----|--------------|---------|------------|---------|
| RDINC-67563 | Production Engineering | 2026-01-05 | 79 | System-wide - ga - prometheus-availability |
| RDINC-68135 | PaaS | 2026-01-15 | 69 | Login Failed via custom domain |
| RDINC-68402 | Cloud Platform | 2026-01-20 | 64 | ODC - 1CP of Apps and Agents Timing out in EA, EU-Central-1 region |

---

*Source: RDINC without Retrospective Commander - Your Jira Issues.csv*
