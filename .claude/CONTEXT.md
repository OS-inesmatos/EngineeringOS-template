# EngineeringOS Context

## Active Initiatives

### Retrospective Process Transformation (March 2026)

**Owner:** Process Engineering Team (Inês, Vera, Pedro, João Brandão, João Rodrigues)

**Objective:** Transform the incident retrospective process to reduce lead time, bureaucracy, and reliance on volunteers while improving RCA quality and team autonomy.

#### Current State Problems (2025 Metrics)
- **Average Lead Time:** 72 days (incident resolution → final closure)
- **Assignment Latency:** 11 days (to assign Retrospective Commander)
- **Execution & Approval:** 64 days (write, present, review, approve)
- **Reviewer Concentration:** 63% of retrospectives reviewed by only 2 people
- **Root Cause:** SRE-led centralized model exceeding capacity, volunteer-dependent, approval bottlenecks

**Impact:** Stale action items, operational gridlock, inconsistent RCA quality, delayed risk mitigation

#### New Model (Approved March 12, 2026)

**Ownership Structure:**
- **Incident-causing teams** lead retrospectives (no longer SRE-led)
- **Engineering Managers** review retrospectives
- **Value Stream Leaders** approve retrospectives
- **SRE** transitions to advisory/consultancy role

**Process Changes:**
- Offline-first (no mandatory readouts)
- Focus on high-impact incidents (>12h MTTR)
- Quality framework: reliability, process, code quality, DORA metrics
- AI/Koda-assisted auditing for RCA quality
- Brown Bag enablement sessions for teams

**Core Message:** Less bureaucracy, more autonomy, outcomes over outputs.

#### Timeline
- **March 12, 2026:** Initial planning meeting
- **April 13, 2026:** Presentation to VS Leaders and Engineering Managers
- **Post-April:** Phased rollout with enablement support

#### Key Metrics to Track
- Number of incidents per area
- Detection ratio
- RCA lead time (target: reduce from 72 days)
- Change Failure Rate (CFR)
- Mean Time to Recovery (MTTR)

#### References
- [Meeting Notes](../meetings/2026-03/2026-03-12-review-retrospective-process.md)
- [Current Process](https://outsystemsrd.atlassian.net/wiki/spaces/RKB/pages/4696212894)
- [Problem Statement](https://outsystemsrd.atlassian.net/wiki/spaces/EEO/pages/6055493751/Retrospective+Transformation)

---

*Last updated: March 12, 2026*
