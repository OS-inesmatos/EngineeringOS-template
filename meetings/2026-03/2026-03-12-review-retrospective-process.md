# Review Retrospective Process
*March 12, 2026*

## Attendees
- Vera Branco (Process Engineering)
- Pedro Charola Alves (Process Engineering)
- João Brandão (Process Engineering)
- João Rodrigues (Process Engineering)
- Inês (mentioned in discussion)

## Context & Problem Statement

### Current Process Issues
The current retrospective process ([Retrospective Process](https://outsystemsrd.atlassian.net/wiki/spaces/RKB/pages/4696212894)) is facing critical bottlenecks:

**Key Metrics (2025):**
- **Average Lead Time:** 72 days (from incident resolution to final closure)
- **Assignment Latency:** 11 days (just to assign a Retrospective Commander)
- **Execution & Approval Cycle:** 64 days (writing, presentation, review/approval)
- **Reviewer Concentration:** 63% of all retrospectives reviewed by only 2 individuals

**Root Causes:**
1. **Centralization & Capacity Overload:** SRE leads all system-wide incident retrospectives, exceeding operational capacity
2. **Reviewer Bottleneck:** Diminishing pool of active reviewers; Quality Team transitioning to decentralized model
3. **Approval Latency:** Value Stream Leaders struggle to close review cycles due to competing priorities
4. **Volunteer-Dependent:** Process relies heavily on volunteers without clear accountability

**Impact:**
- Stale action items (context lost, improvements no longer relevant)
- Operational gridlock (SRE engineers juggling growing backlog)
- Process degradation (inconsistent RCA quality)
- Delayed risk mitigation (exposure to same failure patterns)

Full problem statement: [Retrospective Transformation](https://outsystemsrd.atlassian.net/wiki/spaces/EEO/pages/6055493751/Retrospective+Transformation)

---

## Meeting Discussion

### 1. Process Optimization Goals
**Objective:** Reduce lead time, bureaucracy, meeting time, and reliance on volunteers.

**Key Changes Discussed:**
- Retrospectives should be **offline-first**, eliminating formal readouts
- Focus on **self-service** and **team autonomy**
- Reduce the volume of retrospectives by refining criteria (currently: all system-wide incidents regardless of severity)

**Proposal:**
- Prioritize retrospectives for incidents that took **>12 hours to resolve** (exceeding MTTR targets)
- Remove incidents resolved within normal timeframes from SRE scope

### 2. Accountability & Ownership Model

**Current State:**
- SRE leads all system-wide retrospectives as "Retrospective Commanders"
- Process lacks clear ownership and accountability
- Delays in assigning commanders (11 days average)

**Proposed Model:**
- **Incident-causing teams lead retrospectives** (ownership shifts from SRE to the team that generated the incident)
- **Engineering Managers become Reviewers** (replacing the shrinking volunteer pool)
- **Value Stream Leaders become Approvers** (maintaining strategic oversight)
- **SRE transitions to advisory/support role** (not leading execution)

**Multi-Team Incidents:**
- When multiple teams are involved, teams must collaborate to decide which team leads
- Encourage accountability and alignment between teams
- Escalate to Level 4/5 leaders if teams cannot resolve ownership

### 3. Quality Framework & Auditing

**Challenge:**
- Current RCA quality is inconsistent
- Need to ensure retrospectives address key questions (based on SRE guidance deck)

**Proposed Approach:**
- **Pillars:** Reliability, process, code quality, and (future) DORA metrics
- **Auditing:** Use Koda/AI to audit retrospective quality against defined criteria. Quality Criteria (to be defined).
- **Feedback loops:** Engage with teams not meeting quality standards

### 4. Enablement & Communication

**Concern:**
- Teams may lack skills or confidence to lead retrospectives autonomously
- Risk of quality degradation without proper support

**Proposed Solutions:**
- **Brown Bag sessions** led by managers to teach RCA best practices
- **Reference examples** from teams already doing autonomous retrospectives (e.g., Identity team)
- **Guidance framework** (not a rigid checklist) based on reliability and process pillars
- **SRE/Product Operations embeds** provide consultancy and support where no dedicated SRE exists
- **Production Readiness Checklist** as a reference point

**Messaging:**
- **Less bureaucracy, more autonomy**
- **Focus on outcomes, not outputs**
- **Empower teams to own their quality and reliability**
- **Managers are accountable for supporting their teams**

### 5. Metrics & Continuous Improvement

**Tracking Metrics:**
- Number of incidents per area
- Detection ratio (how quickly incidents are detected)
- Lead time for RCAs (72 days → target reduction)
- Change Failure Rate (CFR)
- Mean Time to Recovery (MTTR)

**Integration with Service Reviews:**
- Correlate Service Review indicators (detection, TTR, slow coverage) with RCA quality
- Automate correlation where possible (Capitão/Juan working on automation)
- Use metrics to identify teams needing additional support

**Continuous Improvement:**
- Iterate on the new model based on data
- Adjust quality framework as teams mature
- Scale enablement based on observed gaps

### 6. Timeline & Rollout

**Key Milestones:**
- **April 13, 2026:** Presentation to Value Stream Leaders and Engineering Managers
  - Communicate new model and rationale
  - Emphasize reduction in bureaucracy and increase in autonomy
  - Highlight positive examples from teams already operating autonomously

**Stakeholder Alignment:**
- João to bring this to Product Leadership
- Ensure messaging is clear and consistent across all communication

---

## Proposed Solution Summary

### New Retrospective Model

**Responsibility Structure:**
- **Incident-Causing Teams:** Lead retrospectives (no longer SRE-led)
- **Engineering Managers:** Review retrospectives (replacing volunteer reviewers)
- **Value Stream Leaders:** Approve retrospectives (maintain strategic oversight)
- **SRE:** Transition to advisory/consultancy role (support, not execution)

**Process Changes:**
- **Offline-first:** No mandatory readouts (reduce meeting overhead)
- **Quality framework:** Guidance-based (not rigid checklist)
- **Auditing:** AI/Koda-assisted quality checks, sampling-based manager feedback
- **Enablement:** Brown bags, reference examples, SRE consultancy support

**Scope Refinement:**
- Focus on incidents >12h MTTR (exceeding targets)
- Remove incidents resolved within normal timeframes from mandatory retrospective scope

**Metrics & Accountability:**
- Track incident counts, detection ratio, RCA lead time, CFR, MTTR
- Integrate with Service Reviews
- Managers accountable for team RCA quality

---

## Next Steps & Action Items

### Immediate Actions
1. **[Vera, Inês, João, Pedro, Brandão]** Develop and finalize the RCA quality framework
   - Define concrete quality criteria based on reliability, process, code quality pillars
   - Prepare guidance (not checklist) for teams to reference

2. **[João]** Communicate to Product Leadership and align messaging
   - Emphasize: less bureaucracy, more autonomy, outcomes over outputs
   - Ensure buy-in from leadership on accountability shift

3. **[Vera, Inês, João, Pedro]** Schedule presentation for April 13, 2026
   - Prepare deck for Value Stream Leaders and Engineering Managers
   - Include problem statement, proposed solution, enablement plan, metrics

### Enablement & Support
4. **[Pedro, João, Vera]** Organize Brown Bag sessions
   - Teach RCA best practices for managers and teams
   - Use examples from Identity and other high-performing teams
   - Focus on practical, actionable guidance

5. **[Vera, Inês]** Coordinate with Product Operations and SRE embeds
   - Ensure support is available for teams without dedicated SRE
   - Reference Production Readiness Checklist

### Automation & Metrics
6. **[Pedro, Capitão/Juan]** Advance automation of Service Review indicators
   - Correlate detection, TTR, slow coverage, CFR with RCA quality
   - Integrate with Koda for easier auditing and tracking

7. **[Brandão]** Define how Service Review metrics relate to RCA quality
   - Prepare approach for future Service Reviews
   - Identify leading/lagging indicators

### Quality Auditing
8. **[João]** Implement sampling-based RCA audits
   - Focus on critical incidents (>12h MTTR)
   - Conduct feedback sessions with Engineering Managers when quality gaps are identified

9. **[Vera, Inês]** Build Koda/AI-assisted auditing capability
   - Train models to assess RCA quality against framework criteria
   - Generate reports highlighting gaps and best practices

### Communication & Rollout
10. **[Pedro, João, Vera]** Prepare rollout timeline
    - Plan phased implementation (start with mature teams)
    - Define success criteria and checkpoints
    - Communicate progress regularly to stakeholders

11. **[João]** Lead ongoing Product Leadership engagement
    - Update leaders on progress
    - Share positive examples from teams adopting new model
    - Address concerns and adjust approach as needed

12. **[All Engineering Managers]** Adopt RCA review and approval responsibility
    - Ensure quality and alignment with defined criteria
    - Support teams in developing RCA capabilities
    - Report difficulties or capacity gaps to Process Engineering

13. **[Pedro, João]** Finalize and cascade organizational messaging
    - Reinforce: less bureaucracy, more autonomy, outcomes over outputs
    - Ensure all teams understand the shift in accountability

---

## Key Takeaways
- **Ownership shift:** From SRE-led to team-led retrospectives
- **Accountability:** Engineering Managers review, Value Stream Leaders approve
- **Quality over volume:** Focus on high-impact incidents (>12h MTTR)
- **Enablement:** Support teams through training, guidance, and SRE consultancy
- **Metrics-driven:** Track lead time, detection, MTTR, CFR to measure improvement
- **Messaging:** Emphasize autonomy, reduced bureaucracy, and outcomes

---

## References
- [Current Retrospective Process](https://outsystemsrd.atlassian.net/wiki/spaces/RKB/pages/4696212894)
- [Retrospective Transformation Problem Statement](https://outsystemsrd.atlassian.net/wiki/spaces/EEO/pages/6055493751/Retrospective+Transformation)

---
## Meeting Notes to share in slack


  Key Decisions:

  New ownership model:
  - Incident-causing teams will lead retrospectives (no longer SRE-led)
  - Engineering Managers become Reviewers
  - Value Stream Leaders remain Approvers
  - SRE transitions to advisory/consultancy role

  Process changes:
  - Offline-first approach (no mandatory readouts)
  - Focus on high-impact incidents (>12h MTTR)
  - Quality framework based on reliability, process, and code quality pillars
  - AI/Koda-assisted auditing to ensure RCA quality

  Core messaging: Less bureaucracy, more autonomy, outcomes over outputs.

  Next Steps:
  - April 13: Present new model to VS Leaders and Engineering Managers
  - João will bring this to Product Leadership for alignment.
  - Develop RCA quality framework and guidance
  - Launch Brown Bag sessions to teach RCA best practices
  - Track metrics: incident counts, detection ratio, RCA lead time, CFR, MTTR

  