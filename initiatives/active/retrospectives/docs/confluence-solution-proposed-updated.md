# Retrospective Transformation [Solution Proposed]

---

## High-Level Solution Proposed

To tackle the described problems, we are proposing a shift in accountability: not only by transferring **retrospective ownership from SRE to the teams responsible for the incident**, but also by **eliminating the Reviewer role**. This change directly addresses our main bottlenecks: SRE's limited capacity to lead all retrospectives and the ongoing difficulty in finding available reviewers. Furthermore, we will **transform mandatory readouts into collaborative RCA working sessions**.

By removing the Reviewer role and transforming readouts, we do not expect the quality of retrospectives to decrease. Instead, we will ensure robust outcomes through a more collaborative and automated approach. This includes:
- **Koda skill-based pre-assessment** — teams self-assess retrospective quality before working sessions
- **RCA working sessions** — collaborative sessions to discuss findings and execute root cause analysis
- **AI-assisted framework** — audits retrospective outputs to ensure all critical pillars are addressed
- **Progressive autonomy** — Process Eng facilitates initially, teams graduate to self-led sessions as maturity grows

---

## What's Changing

| **Aspect** | **Current Process** | **New Model** | **Why?** |
|------------|---------------------|---------------|----------|
| **Scope** | All system-wide incidents | **All system-wide incidents** | **Future**: Focus on Service Incidents SEV1, SEV2 |
| **Retrospective Commander** | SRE Team<br/>(centralized) | **Eng. Manager / Team Leader** of the Incident-causing team<br/>(Can delegate execution to team members) | **Deep Context:** The team owning the code has more context and gains autonomy. |
| **Reviewer** | Volunteer from pool<br/>(Limited capacity / Manual assignment) | **Abolished**<br/>(Replaced by Koda Skill + AI-Assisted Framework) | **Speed:** Eliminates the bottleneck of waiting for an available reviewer. |
| **Approver** | Value Stream Leaders | **Value Stream Leaders** | Maintains **strategic oversight** and accountability. |
| **Readouts** | Mandatory online presentation session | **Collaborative RCA Working Sessions**<br/>(Pre-assessment via Koda skill) | **Efficiency:** Less presentation overhead, more hands-on root cause execution.<br/>**Learning by doing:** Focus on gaps identified by skill output.<br/>Prioritize sessions for teams requiring additional support based on their analytics. |
| **Quality Control** | Manual & Subjective | **Koda Skill Pre-Assessment + AI-Assisted Framework** | **Consistency:** Quality ensured via skill-based auditing, before/after scoring, and Value Stream metrics. |

**Previous Process:**

![Previous Process Diagram]

**New Process:**

![New Process Diagram]

---

## Expected Impact

- Significant reduction in **lead time** (target: <45 days from 72 days)
- Decongestion of SRE and Reviewers **bottleneck**
- Greater team **ownership** and **accountability**
- **Learning by doing** through collaborative working sessions
- Less **bureaucracy**, more **autonomy**

---

## Principles

1. **Team Ownership** - Teams that caused the incident lead the retrospective. Encourage accountability and alignment between teams when multiple teams are involved.

2. **Manager Accountability** - Engineering Managers / Team Leaders are accountable for the quality of the retrospective. They can delegate execution to team members.

3. **Framework-Based Quality** - Quality ensured through RCA framework and Koda skill-based auditing, not manual review. Eliminates reviewer bottleneck while maintaining standards.

4. **Collaborative Learning** - Working sessions drive RCA execution with progressive autonomy. Process Eng facilitates initially, teams graduate to self-led sessions as maturity grows. Learning by doing, not presenting finished work.

5. **Autonomy + Support** - Autonomous teams, with the support of SRE, Quality, and Process Engineering teams when needed.

---

## Why do we believe this is the best solution?

- **Deep Context:** Teams have the deepest context about their incidents, and become more autonomous.

- **Manager Accountability:** Engineering Managers know their team's history, systems, technical debt, ongoing challenges, so they can connect the dots between this incident and broader quality patterns. Retrospectives become part of their existing accountability for quality and reliability.

- **Self-Service Quality Assessment:** Koda skill enables teams to self-assess before working sessions, iterate on quality, and measure improvement through before/after scoring.

- **Collaborative Learning:** Working sessions replace presentation readouts — teams execute RCA together, guided by skill output, focusing on gaps rather than presenting finished work.

- **Progressive Autonomy:** Process Eng facilitates initially, teams graduate to self-facilitation as maturity improves, creating sustainable long-term capability.

- **Quality Maintained:** Framework-based auditing (Koda skill + sampling + VSL approval) maintains standards without reviewer bottleneck.

- **SRE Strategic Focus:** SRE can focus on strategic work (patterns, tooling, guidance) instead of execution bottleneck.

- **Shorter Feedback Loops:** No need to wait for SRE or Reviewers availability.

---

## Process Flow

### Retrospective Execution

1. **Incident Resolution & Assignment**
   - Faulty asset identified during troubleshooting by Incident Commander
   - Engineering Manager or Team Leader of team owning the faulty asset assigned as Retrospective Commander
   - EM/TL is accountable for retrospective completion (can delegate execution to team members)
   - Idea: Create a Jira field that represents the team that owns the faulty asset and, in consequence, the retrospective.

2. **Pre-RCA Assessment (Skill-Assisted)**
   - Before the _RCA Working Session_, team runs Koda skill to assess retrospective document
   - Skill compares document against quality framework (3 pillars: Detection, Troubleshooting & Recovery, Learning & Improvement)
   - Output: Score 0-100% based on % of questions addressed
   - Three-level assessment for each question:
     - ✅ **Fully addressed** — present with sufficient depth
     - ⚠️ **Present but weak** — exists but needs depth (e.g., "human error" as root cause without deeper analysis)
     - ❌ **Missing** — not addressed
   - Skill output lists exactly what was answered and what wasn't, with guiding questions for gaps
   - Teams can iterate on document before working session to improve completeness
   - **See example output:** [RCA Quality Skill — Example Output](https://outsystemsrd.atlassian.net/wiki/spaces/EEO/pages/6174146640)

3. **RCA Working Session**
   - Replaces mandatory presentation readouts — collaborative sessions to execute RCA
   - EM/TL (or delegate) leads session with facilitation support based on team maturity (see Progressive Autonomy Model below)
   - Skill output drives the agenda: focus on ❌ and ⚠️ questions
   - Purpose: Answer missing questions, deepen weak analysis, ensure all pillars covered, elaborate root cause analysis
   - Collaborative learning: SRE (Incident Commanders), Quality, Process, and Dev Teams participate
   - Session targets teams with worst analytics initially (low detection ratio, higher MTTR, lower retrospective quality)
   - Incident channel serves as coordination channel until retrospective is completed

4. **Post-Session Validation**
   - After working session, skill re-runs on updated document
   - Before/After score comparison shows value added (e.g., 45% → 85%)
   - Helps teams see delta between "what we thought was complete" and "what actually was"
   - Quality score tracked per team over time to measure learning and maturity

5. **Action Items**
   - Determined offline between teams after RCA meeting
   - Tracked through Problem Management process (Problem as aggregator and leading indicator of action item completion)

6. **Final Quality Check & Approval**
   - Final skill run confirms quality threshold met (target: >70% for approval)
   - Sampling-based review for critical incidents (>12h MTTR)
   - Value Stream Leader approves retrospective
   - Retrospective closed when all steps complete

---

## Progressive Autonomy Model

Teams graduate to higher autonomy levels based on consistent quality scores:

| **Maturity Tier** | **Quality Score Range** | **Facilitation Model** | **Graduation Criteria** |
|-------------------|-------------------------|------------------------|-------------------------|
| **Tier 1: Learning** | 0-40% | **Process Eng fully facilitates** working sessions<br/>Hands-on teaching, deep involvement in RCA execution | 3 consecutive retrospectives with score >40% |
| **Tier 2: Developing** | 40-70% | **Team leads co-facilitate** with Process Eng observing<br/>Process Eng provides guidance but team drives | 3 consecutive retrospectives with score >70% |
| **Tier 3: Autonomous** | 70-100% | **Team leads self-facilitate**<br/>Process Eng consults skill output only, available for questions | Maintain autonomous status |

**Tier movement:**
- Teams can move up when consistently meeting score thresholds
- Teams can move down if quality degrades (e.g., 2 consecutive scores dropping below tier threshold)
- Process Eng tracks tier status per team to allocate facilitation resources effectively

---

## Quality Framework & Auditing Approach

**Not a rigid checklist** - It's a guidance-based framework.

### Auditing Methods

1. **Koda Skill-Based Pre-Assessment**
   - Koda skill runs before working session to assess document
   - Skill compares against quality framework (3 pillars)
   - Output: 0-100% score based on % of questions addressed
   - Three-level evaluation per question:
     - ✅ Fully addressed (sufficient depth, evidence-based)
     - ⚠️ Present but weak (needs deeper analysis)
     - ❌ Missing (not addressed)
   - Skill lists exactly what's answered and what's missing
   - Includes guiding questions for each gap to support working session
   - **Prevents AI theater:** Skill evaluates depth, not just presence of text
   - **Example output:** [RCA Quality Skill — Example Output](https://outsystemsrd.atlassian.net/wiki/spaces/EEO/pages/6174146640)

2. **Working Session Facilitation**
   - Process Eng uses skill output to drive RCA working session
   - Focus discussion on ❌ and ⚠️ questions
   - Collaborative problem-solving to fill gaps
   - Post-session re-run shows improvement (before/after score)
   - Progressive autonomy: Process Eng → Team leads facilitate over time

3. **Sampling-based Manager Review**
   - Engineering Managers do spot checks
   - Feedback sessions with teams when quality gaps identified
   - Focus on critical incidents (>12h MTTR)
   - Validates skill accuracy and team maturity

4. **Integration with Service Reviews**
   - Correlate Service Review indicators (detection, TTR, slow coverage) with retrospective quality
   - Identify teams needing additional support
   - Automate correlation where possible (Capitão/Juan working on this)

### RCA Framework Pillars

**1. Detection**
- How was the incident initially detected?
- Did the detection happen before customer impact?
- How effective was the alert's clarity/actionability?
- Was the Error Budget of a System-wide SLO affected?
- Was the Error Budget of a Service-specific SLO affected?
- What can be improved in detection?

**2. Troubleshooting and Recovery**
- Was MTTR adequate?
- Were troubleshooting steps effective?
- What slowed down recovery?
- What was the primary method of mitigation?
- Did the incident management process work?
- Was communication effective?
- Were runbooks or documentation used? Were they accurate and helpful?
- Did dependencies or cascading failures significantly delay recovery?

**3. Learning & Improvement**
- Is the technical root cause clear?
- Are there architectural issues to address?
- Was the incident caused by a recent change?
- What action items prevent recurrence?
- Were the follow-up actions immediately owned and tracked?
- Did the team gain a significant new insight about the system?

**Reference:** [RCA Framework — Quality Pillars (detailed)](link-to-pillars-doc)

---

## Metrics & Accountability

### Primary Metrics

1. **Retrospective Lead Time**
   - Current: 72 days (2025 average)
   - Target: < 45 days
   - Measure: Time from incident resolution to retrospective closure
   - **Leading indicator** for process health

2. **Retrospective Commander Assignment Latency**
   - Current: 11 days
   - Target: < 3 days
   - Measure: Time to assign Retrospective Commander to team

3. **Retrospective Quality Score**
   - New metric
   - Based on quality framework pillars (detection, troubleshooting and recovery, learning & improvement)
   - Audited via Koda skill + manager sampling
   - Target: >80% average across all retrospectives

### Secondary Metrics

4. **Number of Incidents per Value Stream**
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

8. **Problem Management as aggregator and leading indicator of action item completion**

### Accountability

- **Engineering Managers / Team Leaders:** Accountable for completing high-quality retrospectives within timelines (can delegate execution to team members)
- **Value Stream Leaders:** Strategic oversight, approve retrospectives
- **Process Engineering:** Monitor control mechanisms, track quality metrics, provide facilitation support and training
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
- Build Koda skill auditing capability
- Organize Brown Bag sessions

**June 2026: Pilot Phase**
- Start with mature teams (e.g., Identity, teams with dedicated SRE)
- 5-10 incidents as pilot
- Gather feedback and iterate on skill + working session format

**July 2026: Expanded Rollout**
- Roll out to all teams
- EM/TL assume full retrospective accountability (with delegation capability)
- SRE transitions to advisory role
- Koda skill auditing fully operational
- Monitor metrics closely

**August 2026+: Iterate & Optimize**
- Adjust quality framework based on data
- Scale enablement where gaps identified
- Continuous improvement based on feedback

---

## Success Criteria

### Must-Have (6 months)
- ✅ Retrospective lead time reduced to < 45 days (from 72 days)
- ✅ Assignment latency < 3 days (from 11 days)
- ✅ 90% of mandatory incidents have complete retrospective
- ✅ 0 issues without assigned Retrospective Commander
- ✅ Koda skill operational and used by all teams

### Should-Have (12 months)
- ✅ Retrospective quality score > 80% (based on framework)
- ✅ Koda skill effectively identifies quality gaps
- ✅ 50% of teams operating at Tier 3 (autonomous)
- ✅ SRE capacity reallocated to strategic work
- ✅ Teams report higher autonomy and lower bureaucracy

### Nice-to-Have (18 months)
- ✅ Full integration with Service Reviews
- ✅ DORA metrics correlated with retrospective quality
- ✅ Continuous improvement loop established
- ✅ Model exported to other areas (not just incidents)

---

## Concerns and Risks

| **Risk**                                                                                                                                                                                                                                                                                                                                          | **Mitigation**                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Previously, we advocated for **external reviewers** to avoid bias and ensure independence. Now we're removing that role and the retrospective is conducted and approved inside the same team/Value Stream.<br/><br/>Could we have the risk of accepting superficial analysis, or overlook quality gaps due to personal investment in their teams. | The combination of structural safeguards (**Koda Skill-Based Pre-Assessment with depth evaluation, Quality Framework with Clear Criteria, Sampling-Based Independent Review, Value Stream Leader Approval, Metrics Track Quality Over Time**) effectively mitigates bias while preserving the benefits of internal context and accountability.<br/><br/>**Key prevention:** Skill evaluates depth, not just presence — prevents teams from gaming with superficial answers. |
| Teams lack retrospective and RCA skills                                                                                                                                                                                                                                                                                                           | **RCA Training & Framework:**<br/>- Brown Bags to train teams on Root Cause Analysis execution<br/>- Guidance framework with clear criteria<br/>- Working sessions provide hands-on learning (learning by doing)<br/>- Progressive autonomy ensures teams build capability before going solo                                                                                                                                                                                |
| Engineering Managers overwhelmed                                                                                                                                                                                                                                                                                                                  | - They are accountable (Retrospective Commander) but **can delegate execution** to team members<br/>- Koda skill reduces ambiguity (clear quality criteria)<br/>- Brown Bags calibrate expectations so facilitation is efficient<br/>- Progressive autonomy means Process Eng supports until ready                                                                                                                                                                          |
| Hard to identify the faulty asset and assign the responsible team                                                                                                                                                                                                                                                                                 | - Initially rely on Internal Communication motion<br/>- Define long-term solution before dropping Internal Communication motion<br/>- Clear criteria for asset ownership<br/>- Idea: Create Jira field for team ownership                                                                                                                                                                                                                                                   |
| Multi-team incidents without clear ownership                                                                                                                                                                                                                                                                                                      | - Teams collaborate to decide who leads<br/>- EM of leading team coordinates with other EMs<br/>- Document ownership decision in retrospective<br/>- Escalate to VSL if ownership unclear                                                                                                                                                                                                                                                                                   |
| Retrospective quality degrades without explicit review                                                                                                                                                                                                                                                                                            | **Multi-layered quality assurance:**<br/>- Koda skill flags gaps automatically (prevents superficial work)<br/>- Working sessions fill gaps collaboratively<br/>- Sampling-based review for critical incidents<br/>- VSL approval maintains oversight<br/>- Quality metrics track patterns over time                                                                                                                                                                        |
| Resistance to ownership shift                                                                                                                                                                                                                                                                                                                     | - Clear communication emphasizing benefits (less bureaucracy, more autonomy)<br/>- Pilot first with mature teams<br/>- Share positive examples early<br/>- Address concerns proactively                                                                                                                                                                                                                                                                                     |
| How to ensure teams are actually learning from retrospectives? (Theater risk)                                                                                                                                                                                                                                                                     | **Evidence of learning tracked through:**<br/>- MTTR improvements by Value Stream<br/>- Detection ratio trends<br/>- Retrospective quality score improvements over time<br/>- Action item completion rates via Problem Management<br/>- Correlation between retro quality and operational metrics<br/>- Before/after skill scores show concrete improvement                                                                                                                 |
| Teams game the system (superficial retrospectives to hit score)                                                                                                                                                                                                                                                                                   | - Koda skill evaluates **depth**, not just presence of text<br/>- Sampling-based review catches gaming patterns<br/>- Quality metrics visible to leadership<br/>- VSL approval gates closure<br/>- Teams with declining quality move down in maturity tiers                                                                                                                                                                                                                 |

---

## Enablement & Support

**Brown Bag Sessions**
- Teach retrospective/root cause analysis best practices
- Practical, actionable guidance
- Calibrate expectations across teams
- Led by SRE/Process Engineering/experienced teams

**Reference Examples**
- Identity team and other teams already doing autonomous retrospectives
- High-quality retrospective templates
- What good looks like
- [RCA Quality Skill — Example Output](https://outsystemsrd.atlassian.net/wiki/spaces/EEO/pages/6174146640)

**RCA Training & Framework**
- Define RCA framework and create enabling materials
- Train teams on how to conduct Root Cause Analysis
- Audit teams on training outcomes to ensure capability
- Establish framework to audit quality of RCA execution

**SRE/Product Operations Embeds**
- Provide consultancy and support
- Especially for teams without dedicated SRE
- Advisory role, not execution role
- Support RCA execution when needed

---

## Next Steps and Action Items

- [ ] **João Rodrigues** to bring this to Product Leadership
- [ ] Prepare presentation to teams (April 13th)
- [ ] Prepare training to Teams
- [ ] Work on the quality framework
- [ ] Build Koda skill to scan retrospectives against quality criteria
- [ ] Define control mechanisms points to the process and internal OLAs for Process Engineering to monitor (e.g. time to start retrospective, time to RCA exercise, time to approve, time to action plan completion)
- [ ] ✅ **Define Success Criteria** (completed above)
- [ ] Define how Service Review metrics relate to retrospective quality
- [ ] ✅ **Define Rollout plan with timeline** (completed above)

---

**Document Owner:** Vera Branco, Pedro Charola Alves, João Brandão, João Rodrigues, Inês Matos
**Last Updated:** 2026-04-06
**Status:** Draft for April 13 presentation
