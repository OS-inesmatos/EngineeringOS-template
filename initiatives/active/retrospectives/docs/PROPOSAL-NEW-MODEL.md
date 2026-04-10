# Proposal: New Retrospective Model
## Ownership Shift - From SRE-led to Team-led

**Date:** 2026-03-13
**Presentation:** 2026-04-13 (Value Stream Leaders + Engineering Managers)
**Authors:** Vera Branco, Pedro Charola Alves, João Brandão, João Rodrigues

---

## Executive Summary

The current retrospective process is in operational gridlock. SRE leads all retrospectives for incidents with system-wide impact, exceeding operational capacity and generating critical delays.

**2025 Data:**
- Average lead time: **72 days** (incident resolution to final closure)
- Assignment latency: **11 days** just to assign a Retrospective Commander
- 63% of retrospectives are reviewed by only 2 people

**Proposal:** Ownership shift - Engineering Managers/Team Leaders of incident-causing teams are assigned as Retrospective Commanders (accountable, can delegate execution), with Value Stream Leaders as approvers. Reviewer role eliminated - quality ensured through Koda skill-based pre-assessment and collaborative RCA working sessions. SRE transitions to advisory role.

**How it works:**
- Teams run Koda skill before working sessions to self-assess retrospective quality (0-100% score)
- Working sessions replace presentation readouts - collaborative RCA execution guided by skill output
- Progressive autonomy: Process Eng facilitates initially, teams gradually self-lead as maturity grows

**Expected Impact:**
- Significant reduction in lead time
- Decongestion of SRE bottleneck
- Elimination of reviewer bottleneck (no more dependency on shrinking volunteer pool)
- Greater team ownership and accountability
- Learning by doing through collaborative working sessions
- Less bureaucracy, more autonomy

---

## Current Problem

### Metrics (2025)

| Metric | Value | Problem |
|--------|-------|---------|
| **Average Lead Time** | 72 days | 🔴 2.4 months from incident resolution to closure |
| **Assignment Latency** | 11 days | 🔴 Just to assign Retrospective Commander |
| **Execution & Approval Cycle** | 64 days | 🔴 Writing, presentation, review/approval |
| **Reviewer Concentration** | 63% by 2 people | 🔴 Critical bottleneck |

### Detailed Analysis (last 6 months, 18 system-wide issues)

| Phase                         | Average Time  | % of Total |
| ----------------------------- | ------------- | ---------- |
| "Solved" State                | 15.8 days     | 17%        |
| **Retrospective In Progress** | **63.7 days** | **69%**    |
| Retrospective Completed       | 13.4 days     | 14%        |
| **TOTAL**                     | **92.9 days** | **100%**   |

**Critical details:**
- Time to assign Commander: 28.5 days (almost double the time in "Solved")
- 22% of issues never had a commander assigned
- 39% of issues exceed 80 days in "Retrospective In Progress"
- Massive variation: from 0.01 to 134 days total

### Root Causes

1. **Centralization & Capacity Overload**
   - SRE leads all system-wide incident retrospectives
   - Operational capacity exceeded
   - Growing backlog, impossible to manage

2. **Reviewer Bottleneck**
   - Diminishing reviewer pool
   - Quality Team transitioning to decentralized model
   - 63% of reviews concentrated in 2 people

3. **Approval Latency**
   - Value Stream Leaders with competing priorities
   - Difficulty closing review cycles
   - Process stalled waiting for approvals

4. **Volunteer-Dependent Process**
   - Depends on volunteers without clear accountability
   - No defined ownership
   - No SLAs or checkpoints

### Impact

- **Stale action items** - Context lost, improvements no longer relevant
- **Operational gridlock** - SRE engineers juggling growing backlog
- **Process degradation** - Inconsistent retrospective quality
- **Delayed risk mitigation** - Exposure to same failure patterns

---

## Proposed New Model

To tackle the described problems, we are proposing a shift in accountability - not only in who drives the retrospectives (from SRE to the teams that caused the incident) but also in who reviews the retrospective document (from the existing volunteer "pool of reviewers" to Engineering Managers). This addresses the root causes: SRE does not have the capacity to lead all system-wide retrospectives, and the volunteer reviewer pool is shrinking.

**What changes:**
- **EM/TL assigned as Retrospective Commander** - Engineering Manager or Team Leader of incident-causing team is accountable (can delegate execution to team members)
- **Reviewer role eliminated** - no more dependency on volunteer reviewers
- **Presentation readouts transformed into collaborative working sessions** - teams execute RCA together, guided by Koda skill output, not present finished work
- **Koda skill enables self-assessment** - teams run skill before sessions to identify gaps, iterate on quality, measure improvement
- **Progressive autonomy path** - Process Eng facilitates initially, teams graduate to self-facilitation as maturity improves
- **SRE becomes a support function** - providing guidance and consultancy rather than executing all the work

**Why this works:**
- EM/TL have the deepest context about their teams' incidents, systems, technical debt, and ongoing challenges
- EM/TL already accountable for their teams' quality and reliability - retrospectives become part of that accountability
- Eliminates reviewer bottleneck - no more dependency on shrinking volunteer pool
- Quality maintained through framework-based auditing (AI/Koda-assisted + sampling)
- SRE can focus on strategic work (patterns, tooling, guidance) instead of execution bottleneck
- Shorter feedback loops - no waiting for SRE or reviewer availability
- EM/TL can delegate execution to team members while maintaining accountability

**What stays the same:**
- Value Stream Leaders maintain strategic oversight and approval authority
- Quality expectations remain high - framework-based auditing maintains standards without review bottleneck
- The goal is still learning and improvement, not blame
- Focus on high-impact incidents that matter

### Ownership Structure

| Role                     | Responsibility                                       | Current                       | New                                  |
| ------------------------ | ---------------------------------------------------- | ----------------------------- | ------------------------------------ |
| **Retrospective Commander** | Accountable for retrospective completion - lead RCA meeting, ensure retrospective document is written, create action items | SRE                           | **Engineering Manager / Team Leader** of incident-causing team            |
| **Approver**                | Approve retrospective, strategic oversight                     | Value Stream Leaders          | **Value Stream Leaders** (maintains) |
| **SRE Role**             | Lead execution                                       | SRE leads everything          | **Advisory/consultancy** (support)   |

**Important:**
- The **Engineering Manager or Team Leader** of the incident-causing team is **always assigned** as Retrospective Commander and is **accountable** for the retrospective's completion and quality.
- They **can delegate execution** to someone in their team (writing the document, leading RCA discussions), but **accountability remains with the EM/TL**.
- The faulty asset must be identified during troubleshooting to determine which team owns the retrospective.

**Note:** The Reviewer role (previously Engineering Managers or volunteer reviewers) is being eliminated. Retrospectives will be audited against a defined framework instead of requiring explicit reviewer approval.

### Principles

1. **Team Ownership** - Teams that caused the incident lead the retrospective. Encourage accountability and alignment between teams when multiple teams are involved.

2. **Manager Accountability** - Engineering Managers / Team Leaders are accountable for the quality of the retrospective. They can delegate execution to team members.

3. **Framework-Based Quality** - Quality ensured through RCA framework and Koda skill-based auditing, not manual review. Eliminates reviewer bottleneck while maintaining standards.

4. **Collaborative Learning** - Working sessions drive RCA execution with progressive autonomy. Process Eng facilitates initially, teams graduate to self-led sessions as maturity grows. Learning by doing, not presenting finished work.

5. **Autonomy + Support** - Autonomous teams, with the support of SRE, Quality, and Process Engineering teams when needed.

### Multi-Team Incidents

When multiple teams are involved:
- Engineering Managers/Team Leaders collaborate to decide which team leads the retrospective
- The EM/TL of the leading team is assigned as Retrospective Commander
- Encourage accountability and alignment between teams
- EM/TL of leading team coordinates with other EMs/TLs
- Escalate to Value Stream Leaders if unable to resolve ownership

---

## Scope

**Retrospectives will be performed for all system-wide incidents.**

The ownership model changes (EM/TL of incident-causing team assigned as Retrospective Commander instead of SRE).

**Current Criteria:**
- All incidents declared with system-wide impact
- Faulty asset must be identified during troubleshooting by the Incident Commander

**Future:** Once the Service Incidents vs Customer Incidents classification is implemented, scope will be refined to Service Incidents SEV1 and SEV2.

**Note:** During discussions, there was consideration of SRE continuing to lead only incidents with MTTR > X days (high-complexity incidents), while teams would lead lower-complexity incidents. **This approach was discussed but is not being implemented.** All system-wide incidents will follow the new model (EM/TL assigned as Retrospective Commander, VSLs approve).

---

## Process Flow

### Retrospective Execution

1. **Incident Resolution & Assignment**
   - Faulty asset identified during troubleshooting by Incident Commander. Use "Impacted Assets" field for that purpose, or create a new one for the team responsible.
   - Engineering Manager or Team Leader of team owning the faulty asset assigned as Retrospective Commander
   - Idea: Automatically create the Retrospective document, using Koda skill, based on all information available (incident slack channel, rootly, grafana)
   - EM/TL is accountable for retrospective completion (can delegate execution to team members)
   - Challenge: Initially relying on Internal Communication motion to identify RCA Commander
   - Future: Need solution when Internal Communication motion is dropped
   - Idea: Create a Jira field that represents the team that owns the faulty asset and, in consequence, the retrospective

2. **Document Creation**
   - EM/TL drafts initial retrospective document (or delegates to team member)
   - **Timeline:** Within 3 days of incident resolution (see Process SLAs below)
   - **Template:** Use standard retrospective template (published in Confluence)
   - **Minimum content for skill assessment:**
     - Incident timeline
     - Initial impact assessment
     - Initial root cause hypothesis
     - Detection method
   - **Output:** Draft retrospective document ready for skill assessment

3. **Pre-RCA Assessment (Skill-Assisted)**
   - Before the working session, team runs Koda skill to assess retrospective document
   - Skill compares document against quality framework (6 pillars)
   - Output: Score 0-100% based on % of questions addressed
   - Three-level assessment for each question:
     - ✅ **Fully addressed** — present with sufficient depth
     - ⚠️  **Present but weak** — exists but needs depth (e.g., "human error" as root cause without deeper analysis)
     - ❌ **Missing** — not addressed
   - Skill output lists exactly what was answered and what wasn't, with guiding questions for gaps
   - Teams can iterate on document before working session to improve score

4. **RCA Working Session**
   - Replaces mandatory readouts — collaborative sessions to execute RCA
   - EM/TL (or delegate) leads session with Process Eng facilitation (initially)
   - Skill output drives the agenda: focus on ❌ and ⚠️ questions
   - Purpose: Answer missing questions, deepen weak analysis, ensure all pillars covered
   - Collaborative learning: SRE (Incident Commanders), Quality, Process, and Dev Teams participate
   - Focus on covering all pillars: detection, troubleshooting and recovery, learning & improvement
   - Session targets teams with worst analytics initially (low detection ratio, higher MTTR)
   - Incident channel serves as coordination channel until retrospective is completed

5. **Post-Session Validation**
   - After working session, skill re-runs on updated document
   - Before/After score comparison shows value added (e.g., 45% → 85%)
   - Helps teams see delta between "what we thought was complete" and "what actually was"
   - Quality score tracked per team over time to measure learning and maturity

6. **Action Items**
   - Determined offline between teams after RCA working session
   - Tracked through Problem Management process
   - Monitored via Problem Record indicators

7. **Final Quality Check & Approval**
   - Final skill run confirms quality threshold met (target: >70% for approval)
   - Sampling-based review for critical incidents (>12h MTTR)
   - Value Stream Leader approves retrospective
   - Retrospective closed when all steps complete

### Coordination

- **Incident channel remains active** as the coordination point until retrospective is completed
- Teams collaborate across SRE, Quality, Process, and Development
- Offline collaboration for action item definition and follow-up

### Process SLAs / OLAs

Process Engineering monitors the following control points to ensure retrospectives complete within target lead time (<45 days):

| **Control Point** | **SLA/OLA** | **Measurement** | **Owner** |
|-------------------|-------------|-----------------|-----------|
| **Time to Draft** | < 3 days | Incident resolution → draft created in Confluence | EM/TL |
| **Time to Skill Assessment** | < 1 day | Draft created → skill run completed | EM/TL |
| **Time to RCA Session** | < 7 days | Draft created → RCA working session held | Process Eng + EM/TL |
| **Time to Document Update** | < 2 days | Session completed → document updated with session outcomes | EM/TL |
| **Time to VSL Approval** | < 5 days | Document finalized → VSL approval | VSL |
| **Total Lead Time** | < 45 days | Incident resolution → retrospective closed | End-to-end |

**Monitoring:**
- Process Engineering tracks all control points via PowerBI dashboard
- Weekly report to leadership showing retrospectives by status and age
- Alerts when SLAs at risk (e.g., draft not created after 2 days)

**Accountability:**
- EM/TL accountable for draft, assessment, update (Steps 1-4)
- Process Eng accountable for facilitating session on time (Step 4)
- VSL accountable for timely approval (Step 7)

---

## Quality Framework

### RCA Framework

The retrospective framework analyzes outcomes from the RCA exercise to ensure teams covered all critical pillars:

1. **Detection & Monitoring**
    - How was the incident initially detected?
    - Did the detection happen before customer impact?
    - How effective was the alert's clarity/actionability?
    - Was the Error Budget of a System-wide SLO affected?
    - Was the Error Budget of a Service-specific SLO affected?
    - What can be improved in detection?

2. **Response & Communication**
    - Was incident declaration timely after detection?
    - Was communication effective?
    - Was MTTA (Mean Time to Acknowledge) documented and adequate?
    - Was status page communication timely and clear?

3. **Troubleshooting & Root Cause**
    - Were troubleshooting steps effective?
    - Is the technical root cause clear?
    - Are there architectural issues to address?

4. **Recovery & Resolution**
    - Was MTTR adequate?
    - What slowed down recovery?
    - What was the primary method of mitigation?
    - Were runbooks or documentation used? Were they accurate and helpful?
    - Did dependencies or cascading failures significantly delay recovery?
    - Was customer impact quantified?

5. **Prevention & Learning**
    - Was the incident caused by a recent change?
    - Is this a recurring issue?
    - What action items prevent recurrence?
    - Were the follow-up actions immediately owned and tracked?
    - Did the team gain a significant new insight about the system?

6. **Process Compliance**
    - Did the incident management process work?

**Future Integration:**
- DORA Metrics (Change Failure Rate, Deployment frequency, Lead time for changes, Time to restore service)

### Auditing Approach

**Not a rigid checklist** - It's a guidance-based framework.

**Auditing Methods:**

1. **Koda Skill-Based Pre-Assessment**
   - Teams run skill before working session to self-assess document
   - Skill compares against quality framework (6 pillars)
   - Output: 0-100% score based on % of questions addressed
   - Three-level evaluation per question:
     - ✅ Fully addressed (sufficient depth, evidence-based)
     - ⚠️  Present but weak (needs deeper analysis)
     - ❌ Missing (not addressed)
   - Skill lists exactly what's answered and what's missing
   - Includes guiding questions for each gap to support working session
   - **Prevents AI theater:** Skill evaluates depth, not just presence of text

2. **Working Session Facilitation**
   - Process Eng uses skill output to drive RCA working session
   - Focus discussion on ❌ and ⚠️ questions
   - Collaborative problem-solving to fill gaps
   - Post-session re-run shows improvement (before/after score)
   - Progressive autonomy: Process Eng → Team leads facilitate over time

3. **Sampling-based manager review**
   - Engineering Managers do spot checks
   - Feedback sessions with teams when quality gaps identified
   - Focus on critical incidents (>12h MTTR)
   - Validates skill accuracy and team maturity

4. **Integration with Service Reviews**
   - Correlate Service Review indicators (detection, TTR, slow coverage) with retrospective quality
   - Identify teams needing additional support
   - Automate correlation where possible (Capitão/Juan working on this)

### Reference Materials

- **Guidance framework** based on RCA pillars (detection, troubleshooting and recovery, learning & improvement)
- **Production Readiness Checklist** as reference point
- **Best practice examples** from teams already operating autonomously (e.g., Identity team)
- **SRE guidance deck** with key questions to address

---

## Enablement Plan

### Quality Assurance Without Traditional Review

Previously, we relied on external reviewers to ensure retrospective quality. The new model eliminates the reviewer role entirely, replacing it with framework-based auditing. This addresses the core problem (shrinking reviewer pool, bottleneck) while maintaining quality standards.

### How Quality is Maintained

1. **Koda Skill-Based Assessment** (Objective, Automated, Team Self-Service)
   - Teams run skill before and after working sessions
   - Automatically scans retrospectives against quality criteria (6 pillars)
   - Three-level evaluation: ✅ Fully addressed, ⚠️ Present but weak, ❌ Missing
   - Flags gaps objectively (missing root cause, weak action items, incomplete RCA pillars)
   - Generates actionable session agenda: guiding questions for each gap
   - Before/after score shows learning and improvement
   - Ensures consistency across all teams
   - No human review bottleneck
   - **Evaluates depth, not just presence** — prevents gaming with superficial answers

2. **Sampling-Based Independent Review** (External Check)
   - João (or designated person) samples retrospectives, focusing on critical incidents (>12h MTTR)
   - Feedback sessions with teams when quality gaps identified
   - Pattern detection - if same team repeatedly produces low-quality work, it's visible
   - Creates accountability without review bottleneck

3. **Quality Framework with Clear Criteria** (RCA Pillars)
   - Based on defined pillars: detection, troubleshooting and recovery, learning & improvement
   - Reference examples from high-performing teams
   - Teams self-assess against documented criteria
   - Calibration through Brown Bags and working sessions ensures consistency

4. **Value Stream Leader Approval** (Strategic Oversight)
   - VSLs maintain final approval authority
   - Can request independent review for high-impact incidents
   - Preserves strategic oversight without day-to-day review bottleneck

5. **Metrics Track Quality Over Time** (Accountability Through Data)
   - Retrospective quality score by team tracked over time
   - Pattern detection (same team repeatedly produces low-quality retrospectives triggers support)
   - Data-driven conversations with teams about quality gaps
   - Evidence of learning tracked through MTTR improvements, detection ratio, action item completion

### Enablement & Support

6. **RCA Training & Framework**
   - Define RCA framework and create enabling materials
   - Train teams on how to conduct Root Cause Analysis
   - Audit teams on training outcomes to ensure capability
   - Establish framework to audit quality of RCA execution

7. **Working Sessions (Transformed Readouts)**
   - Initial readouts transformed into collaborative working sessions to execute RCA
   - **Pre-session:** Teams run Koda skill to assess document, identify gaps
   - **During session:** Process Eng facilitates discussion of ❌ and ⚠️ questions from skill output
   - **Post-session:** Skill re-runs to show improvement (before/after score)
   - Focus on teams with worst analytics (low detection ratio, higher MTTR)
   - Practical, hands-on learning through real retrospective execution
   - Calibrate expectations and build RCA capability

   **Progressive Autonomy Model:**
   - **Tier 1 (Score 0-40%):** Process Eng fully facilitates working sessions
   - **Tier 2 (Score 40-70%):** Team leads co-facilitate with Process Eng observing
   - **Tier 3 (Score 70-100%):** Team leads self-facilitate, Process Eng consults skill output only
   - Teams graduate to higher tiers based on consistent quality score improvements

8. **Brown Bag Sessions**
   - Teach retrospective and RCA best practices
   - Practical, actionable guidance
   - Calibrate expectations across teams
   - Led by SRE/Process Engineering/experienced teams

9. **Reference Examples**
   - Identity team and other teams already doing autonomous retrospectives
   - High-quality retrospective templates
   - What good looks like

10. **SRE/Product Operations Embeds**
    - Provide consultancy and support
    - Especially for teams without dedicated SRE
    - Advisory role, not execution role
    - Support RCA execution when needed

### Messaging

**Core message:** Less bureaucracy, more autonomy, outcomes over outputs.

**Key points:**
- Empower teams to own their quality and reliability
- Managers are accountable for supporting their teams
- SRE remains available for consultancy and guidance
- Focus on learning and improvement, not blame

---

## Metrics & Accountability

### Primary Metrics

1. **Retrospective Lead Time**
   - Current: 72 days (2025 average)
   - Target: < 45 days
   - Measure: Time from incident resolution to retrospective closure
   - **Leading indicator** for process health

2. **Assignment Latency**
   - Current: 11 days
   - Target: < 3 days
   - Measure: Time to assign Retrospective Commander to team

3. **Retrospective Quality Score**
   - New metric
   - Based on quality framework pillars (detection, troubleshooting and recovery, learning & improvement)
   - Audited via AI/Koda + manager sampling

### Control Mechanisms & OLAs

Process Engineering monitors the following control points:

1. **Time to Start Retrospective**
   - From incident resolution to retrospective kickoff
   - OLA: < 3 days

2. **Time to RCA Exercise**
   - From retrospective start to RCA meeting completion
   - OLA: < 7 days

3. **Time to Approve**
   - From RCA completion to final approval
   - OLA: < 5 days

4. **Time to Action Item Completion**
   - Tracked via Problem Management process
   - Problem Management serves as leading indicator
   - Process Engineering monitors Problem Record indicators

### Secondary Metrics

4. **Number of Incidents per Area**
   - Track incident trends by team/service
   - Identify hot spots requiring additional support

5. **Detection Ratio**
   - How quickly incidents are detected
   - Correlate with retrospective quality

6. **Mean Time to Recovery (MTTR)**
   - Track MTTR trends
   - Correlate with action item completion

7. **Change Failure Rate (CFR)**
   - % of deployments causing incidents
   - Integrate with DORA metrics (future)

### Evidence of Learning

**Challenge:** How do we ensure we are actually learning from retrospectives?

**Approach:**
- Check evidence of improvement in **MTTR of that value stream**
- Monitor **detection ratio** trends over time
- Track **retrospective quality** improvements
- Measure **action item completion** rates via Problem Management

**Long-term:**
- Analytics showing teams are learning from incidents
- Correlation between retrospective quality and operational improvements
- Reduction in repeat incidents in same areas
- Improved MTTR and detection ratios for teams with high-quality retrospectives

### Reporting Cadence

- **Weekly:** Automatically updated dashboard
- **Monthly:** Report to leadership with trends and outliers
- **Quarterly:** Model review, adjustments based on data

### Accountability

- **Engineering Managers / Team Leaders:** Accountable for completing high-quality retrospectives within timelines (can delegate execution to team members)
- **Value Stream Leaders:** Strategic oversight, approve retrospectives
- **Process Engineering:** Monitor control mechanisms, track quality metrics, provide support and training
- **SRE:** Consultancy and guidance when requested

---

## Timeline & Rollout

### Key Milestones

**April 13, 2026: Presentation to VS Leaders + Engineering Managers**
- Communicate new model and rationale
- Emphasize reduction in bureaucracy and increase in autonomy
- Highlight positive examples from teams already operating autonomously
- Q&A and gather feedback

**April - May 2026: Preparation Phase**
- Finalize retrospective quality framework
- Develop guidance materials
- Setup AI/Koda auditing capability
- Organize Brown Bag sessions

**June 2026: Pilot Phase**
- Start with mature teams (e.g., Identity, teams with dedicated SRE)
- 5-10 incidents as pilot
- Gather feedback and iterate

**July 2026: Expanded Rollout**
- Roll out to all teams
- EM/TL assume full retrospective accountability (with delegation capability)
- SRE transitions to advisory role
- AI/Koda auditing fully operational
- Monitor metrics closely

**August 2026+: Iterate & Optimize**
- Adjust quality framework based on data
- Scale enablement where gaps identified
- Continuous improvement based on feedback

### Stakeholder Alignment

**Critical for success:**
- João to bring this to Product Leadership
- Ensure messaging is clear and consistent
- Communicate early and often
- Address concerns proactively

---

## Risks & Mitigations

| Risk                                                | Probability | Impact | Mitigation                                                                                                                                                                                    |
| --------------------------------------------------- | ----------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Difficulty identifying faulty asset and responsible team | High    | High   | Initially rely on Internal Communication motion to identify RCA Commander. Define long-term solution before dropping Internal Communication motion. Clear criteria for asset ownership.       |
| Teams lack retrospective and RCA skills             | High        | High   | RCA training framework, working sessions (transformed readouts), Brown Bags, guidance framework, SRE consultancy                                                                              |
| Retrospective quality degrades without explicit review | Medium   | High   | AI-assisted auditing flags gaps automatically, quality framework provides clear criteria, sampling-based independent review, VSL approval maintains oversight, quality metrics track patterns |
| Multi-team incidents without clear ownership        | Medium      | Medium | Teams collaborate to decide who leads, document ownership decision in retrospective, escalate to VSL if ownership unclear                                                                     |
| Not learning from retrospectives (theater)          | Medium      | High   | Track evidence of learning: MTTR improvements, detection ratio, action item completion via Problem Management, correlation between retro quality and operational metrics                     |
| Resistance to ownership shift                       | Medium      | Medium | Clear communication, emphasize benefits (less bureaucracy, more autonomy), pilot first                                                                                                        |
| Teams game the system (superficial retrospectives)  | Low         | Medium | AI auditing detects patterns, sampling-based review catches issues, quality metrics visible to leadership, VSL approval gates closure                                                        |

---

## Success Criteria

### Must-Have (6 months)
- [ ] retrospective lead time reduced to < 45 days (from 72 days)
- [ ] Assignment latency < 3 days (from 11 days)
- [ ] 90% of mandatory incidents have complete retrospective
- [ ] 0 issues without assigned Retrospective Commander

### Should-Have (12 months)
- [ ] Retrospective quality score > 80% (based on framework)
- [ ] AI/Koda auditing effectively identifies quality gaps
- [ ] SRE capacity reallocated to strategic work
- [ ] Teams report higher autonomy and lower bureaucracy

### Nice-to-Have (18 months)
- [ ] Full integration with Service Reviews
- [ ] DORA metrics correlated with retrospective quality
- [ ] Continuous improvement loop established
- [ ] Model exported to other areas (not just incidents)

---

## Next Steps

### Immediate (Next 2 Weeks)

**[Vera, Inês]** Finalize retrospective quality framework
   - Define concrete quality criteria based on RCA pillars (detection, troubleshooting and recovery, learning & improvement)
   - Prepare guidance document
   - Create reference examples

**[Vera, Inês]** Define RCA framework
   - Establish RCA framework structure
   - Create enabling materials and templates
   - Define how to audit teams on RCA execution quality

**[Vera, Inês]** Define control mechanisms and OLAs
   - Document control points (time to start, time to RCA, time to approve, time to action completion)
   - Define OLAs for Process Engineering to monitor
   - Establish how Problem Management indicators will be tracked

**[João]** Communicate to Product Leadership
   - Align on messaging
   - Get buy-in on accountability shift
   - Address concerns

**[All]** Prepare presentation deck for April 13
   - Problem statement with data
   - Proposed solution
   - Enablement plan (including RCA training)
   - Metrics and timeline

### Short-Term (April - May)

**[Vera, Inês, Pedro, João]** Launch RCA training program
   - Prepare RCA enabling sessions
   - Train teams on Root Cause Analysis execution
   - Audit teams on training outcomes
   - Target teams with worst analytics first (low detection ratio, higher MTTR)

**[Inês, Vera]** Transform readouts into working sessions
   - Convert initial readouts into hands-on RCA execution sessions
   - Focus on teams needing additional support
   - Use real retrospectives as learning opportunities
   - Build practical RCA capability through doing

 **[Inês, Vera]** Organize Brown Bag sessions
   - Schedule sessions for teams
   - Prepare content on retrospective and RCA best practices
   - Record for async consumption

**[Vera, Inês]** Build Koda/AI-assisted auditing capability
   - Train models on quality framework and RCA pillars
   - Generate sample reports
   - Iterate based on feedback

### Medium-Term (June - July)

**[Pedro, Capitão]** Advance automation of Service Review indicators
   - Correlate detection, TTR, CFR with retrospective quality
   - Integrate with Koda
   - Setup automated dashboards

**[Brandão]** Define how Service Review metrics relate to retrospective quality
   - Prepare approach for future Service Reviews
   - Identify leading/lagging indicators

**[Inês, Vera]** Implement sampling-based retrospective audits
   - Focus on critical incidents
   - Conduct feedback sessions with teams when gaps identified
   - Pattern detection and quality trends reporting

### Long-Term (August+)

**[Pedro, João, Vera]** Execute phased rollout
    - Start with mature teams
    - Monitor metrics closely
    - Adjust approach based on data

 **[João]** Lead ongoing Product Leadership engagement
    - Update leaders on progress
    - Share positive examples
    - Address concerns proactively

**[All Engineering Managers / Team Leaders]** Adopt retrospective accountability
    - Accept assignment as Retrospective Commander when team causes incident
    - Ensure RCA meetings happen and retrospectives complete within timelines
    - Can delegate execution to team members while maintaining accountability
    - Request SRE consultancy when needed
    - Report difficulties or process gaps to Process Engineering

---

## Appendices

### A. Data Sources
- [Current Retrospective Process](https://outsystemsrd.atlassian.net/wiki/spaces/RKB/pages/4696212894)
- [Retrospective Transformation Problem Statement](https://outsystemsrd.atlassian.net/wiki/spaces/EEO/pages/6055493751/Retrospective+Transformation)
- [COMPLETE-METRICS-SUMMARY.md](./COMPLETE-METRICS-SUMMARY.md) - Detailed analysis of last 6 months
- [FINAL-ANALYSIS-SUMMARY.md](./FINAL-ANALYSIS-SUMMARY.md) - Identified bottlenecks

### B. Meeting Notes
- [2026-03-12 Review Retrospective Process](../../../meetings/2026-03/2026-03-12-review-retrospective-process.md)
- [2026-03-24 M3.3 Retrospective Transformation](../../../meetings/2026-03/2026-03-24-m3.3-retrospective-transformation.md)

### C. Reference Teams
- **Identity Team** - Already operating autonomous retrospectives
- [Add other teams here as examples emerge]

---

## Summary for Slack/Email

**Key Decisions:**

New ownership model:
- Engineering Managers/Team Leaders of incident-causing teams assigned as Retrospective Commanders (accountable, can delegate execution)
- Reviewer role eliminated - retrospectives audited against framework instead
- Value Stream Leaders remain Approvers
- SRE transitions to advisory/consultancy role

Process changes:
- **Koda skill pre-assessment** before working sessions (teams self-identify gaps, iterate on quality)
- **Collaborative working sessions replace presentation readouts** - teams execute RCA together, guided by skill output
- **Progressive autonomy model** - Process Eng facilitates → teams co-facilitate → teams self-lead (based on maturity tiers)
- **Before/after scoring** - skill re-runs post-session to measure learning and improvement
- Focus on all system-wide incidents (future: Service Incidents SEV1/SEV2 once classification is implemented)
- Quality framework based on RCA pillars: detection, troubleshooting and recovery, learning & improvement

Core messaging: **Less bureaucracy, more autonomy, outcomes over outputs.**

**Next Steps:**
- April 13: Present new model to VS Leaders and Engineering Managers
- João will bring this to Product Leadership for alignment
- Develop retrospective quality framework and guidance
- Launch Brown Bag sessions to teach retrospective best practices
- Track metrics: incident counts, detection ratio, retrospective lead time, CFR, MTTR

---

**Document Owner:** Vera Branco, Pedro Charola Alves, João Brandão, João Rodrigues, Inês Matos
**Last Updated:** 2026-04-09
**Status:** Draft for April 13 presentation - Updated with Koda skill-based pre-assessment, collaborative working sessions, progressive autonomy model, Process SLAs/OLAs, and 7-step process flow
