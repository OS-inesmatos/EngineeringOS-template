# RCA Framework — Quality Pillars

**Version:** 1.3
**Last Updated:** 2026-04-08
**Purpose:** Define quality criteria for retrospective auditing (AI/Koda-assisted + sampling-based review)

---

## Overview

The RCA framework evaluates retrospective quality across six core pillars. These pillars guide both the retrospective writing process and the quality auditing process.

**Not a rigid checklist** — It's a guidance-based framework. Teams should address relevant questions based on incident context.

---

## Pillar 1: Detection & Monitoring 🕵️

**Focus:** How effectively was the incident detected? Were monitoring and alerting adequate?

### Key Questions

1. **How was the incident initially detected?**
   - Customer report, internal alert, monitoring system, manual discovery, etc.

2. **Did the detection happen before customer impact?**
   - Proactive vs reactive detection
   - Customer-detected vs system-detected

3. **How effective was the alert's clarity/actionability?**
   - Was the alert clear about what was wrong?
   - Did it provide enough context for rapid response?
   - Did it suggest actionable next steps?

4. **Was the Error Budget of a System-wide SLO affected?**
   - Track impact on system-wide SLOs
   - Error budget consumption

5. **Was the Error Budget of a Service-specific SLO affected?**
   - Track impact on service-specific SLOs
   - Identify services most affected

6. **What can be improved in detection?**
   - New alerts needed?
   - Alert tuning required?
   - Monitoring gaps identified?
   - SLO coverage improvements?

### Quality Signals

**Good retrospective addresses:**
- Detection method clearly identified
- Customer impact timing documented
- Alert effectiveness assessed
- SLO impact quantified
- Specific detection improvements proposed

**Red flags:**
- Detection method unclear
- No assessment of alert quality
- SLO impact not mentioned
- No detection improvements identified

---

## Pillar 2: Response & Communication 📣

**Focus:** How timely and effective was the response? Was communication clear and adequate?

### Key Questions

1. **Was incident declaration timely after detection?**
   - How long between issue detection and formal incident creation?
   - If delayed, what caused the delay?
   - Was escalation appropriate and timely?

2. **Was communication effective?**
   - Internal communication (team, leadership)
   - External communication (customers, stakeholders)
   - Timely and clear updates?

3. **Was MTTA (Mean Time to Acknowledge) documented and adequate?**
   - How long to acknowledge and start working on the incident?
   - Was the response time acceptable?
   - How does it compare to historical MTTA?

4. **Was status page communication timely and clear?**
   - Was the public status page updated promptly?
   - Were customer-facing updates clear and accurate?
   - Was Public MTTA documented?

### Quality Signals

**Good retrospective addresses:**
- Incident declaration timing analyzed
- Communication effectiveness assessed
- MTTA documented and evaluated
- Status page updates documented

**Red flags:**
- Incident declaration delays not explained
- Communication effectiveness not discussed
- MTTA not mentioned
- No status page communication analysis

---

## Pillar 3: Troubleshooting & Root Cause 🔍

**Focus:** How effective was troubleshooting? Is the root cause clearly understood?

### Key Questions

1. **Were troubleshooting steps effective?**
   - Did the team know where to look?
   - Were troubleshooting tools adequate?
   - Were logs/metrics/traces helpful?

2. **Is the technical root cause clear?**
   - Root cause identified and documented?
   - Evidence-based analysis?
   - Avoid surface-level symptoms

3. **Are there architectural issues to address?**
   - Design weaknesses exposed?
   - Scalability issues?
   - Single points of failure?
   - Technical debt contributing to incident?

### Quality Signals

**Good retrospective addresses:**
- Troubleshooting effectiveness analyzed
- Root cause clearly documented with evidence
- Architectural issues identified (if applicable)

**Red flags:**
- Troubleshooting process not evaluated
- Root cause vague or missing
- No architectural analysis

---

## Pillar 4: Recovery & Resolution 🩹

**Focus:** How quickly was the incident resolved? What blocked or delayed recovery?

### Key Questions

1. **Was MTTR adequate?**
   - Was recovery time acceptable?
   - How does it compare to historical MTTR for similar incidents?

2. **What was the primary method of mitigation?**
   - Rollback of change
   - Fix-forward (new deployment/patch)
   - Configuration change (feature flag, scaling)
   - Manual intervention/workaround

3. **What slowed down recovery?**
   - Missing information or context?
   - Tooling gaps?
   - Knowledge gaps?
   - Coordination issues?

4. **Were runbooks or documentation used? Were they accurate and helpful?**
   - Did relevant runbooks exist?
   - Were they used during recovery?
   - Were they accurate and complete?
   - Do runbooks need to be created or updated?

5. **Did dependencies or cascading failures significantly delay recovery?**
   - Impact of upstream/downstream dependencies
   - Cascading failures that amplified impact
   - Cross-team coordination challenges

6. **Was customer impact quantified?**
   - How many customers were affected?
   - What was the duration and severity of impact per customer?
   - Was the business impact assessed and communicated?

### Quality Signals

**Good retrospective addresses:**
- MTTR documented and assessed
- Mitigation method documented
- Recovery blockers clearly identified
- Runbook usage and quality documented
- Dependency impact analyzed
- Customer impact quantified with numbers

**Red flags:**
- MTTR not mentioned
- Mitigation method unclear
- No analysis of what slowed recovery
- Runbook usage not mentioned
- Dependency impact ignored
- Customer impact stated generically without quantification

---

## Pillar 5: Prevention & Learning 🧠

**Focus:** What did we learn? How do we prevent recurrence? What systemic improvements are needed?

### Key Questions

1. **Was the incident caused by a recent change?**
   - Direct link to deployment, configuration change, or code change?
   - Change Failure Rate (CFR) implications
   - Deployment process gaps?

2. **Is this a recurring issue?**
   - Were there previous incidents with the same root cause?
   - Were action items from previous retrospectives completed?
   - What systemic issues were not addressed that allowed recurrence?
   - Is there a pattern indicating band-aids instead of systemic fixes?

3. **What action items prevent recurrence?**
   - Specific, actionable items defined?
   - Short-term fixes vs long-term improvements?
   - Address root cause, not just symptoms

4. **Were the follow-up actions immediately owned and tracked?**
   - Clear ownership assigned for each action item?
   - Tracking mechanism in place (Jira, Problem Management)?
   - Timeline/priority defined?

5. **Did the team gain a significant new insight about the system?**
   - New understanding of system behavior?
   - Previously unknown risk or vulnerability discovered?
   - Learning value beyond fixing this specific issue?

### Quality Signals

**Good retrospective addresses:**
- Change correlation analyzed
- Recurrence analysis performed (checked for similar past incidents)
- Specific, actionable prevention items defined
- Action items have clear owners and tracking
- Learning insights documented

**Red flags:**
- Change correlation not investigated
- No check for previous similar incidents or recurring patterns
- Action items generic or vague ("improve monitoring")
- No clear ownership for action items
- No evidence of learning beyond immediate fix

---

## Pillar 6: Process Compliance ✅

**Focus:** Was the incident management and retrospective process followed correctly?

### Key Questions

1. **Did the incident management process work?**
   - Was incident declaration clear?
   - Were roles assigned effectively?
   - Was the Incident Commander effective?
   - Were escalation paths followed?

2. **Was the retrospective completed within SLA (<14 days)?**
   - Time from incident closure to retrospective completion
   - If delayed, what caused the delay?
   - Was the timeline acceptable?

3. **Is the retrospective documentation clear, complete, and actionable?**
   - Is the document well-structured and readable?
   - Are all required sections present?
   - Are action items specific and trackable?

4. **Was the retrospective process followed correctly?**
   - Was retro commander assigned promptly?
   - Was RCA session booked and conducted?
   - Was sign-off obtained (EM review + VS Leader approval)?

### Quality Signals

**Good retrospective addresses:**
- Incident management process evaluated
- Retrospective SLA adherence documented
- Documentation quality is high
- Process steps followed and documented

**Red flags:**
- No assessment of incident management process
- Retrospective SLA not mentioned or significantly delayed
- Documentation is incomplete or unclear
- Process steps skipped or not followed

---

## Integration with Auditing

### AI/Koda-Assisted Auditing

The AI audit framework will:
1. **Scan retrospectives** against these pillars
2. **Flag gaps** — missing sections, incomplete analysis, weak action items
3. **Generate quality score** — % of questions addressed per pillar
4. **Identify patterns** — teams consistently missing specific areas
5. **Report to Process Engineering** — for governance and enablement decisions

### Sampling-Based Manager Review

Engineering Managers or designated reviewers will:
1. **Sample retrospectives** — focus on critical incidents (>12h MTTR, high customer impact)
2. **Validate AI findings** — ensure AI audit is accurate
3. **Provide feedback** — when quality gaps identified
4. **Pattern detection** — if same team repeatedly produces low-quality work, trigger support/training

### Value Stream Leader Approval

VSLs maintain final approval authority and can:
1. **Request deeper review** for high-impact incidents
2. **Escalate quality concerns** if patterns emerge
3. **Approve retrospective closure** based on quality threshold

---

## Using This Framework

### For Retrospective Writers (EM/TL/Commanders)

Use this framework as a **guide**, not a rigid checklist:
- Address questions relevant to your incident
- Not every question applies to every incident
- Focus on depth over breadth — thorough analysis of key areas beats superficial coverage of all areas

### For Auditors (AI + Sampling)

Use this framework to assess quality:
- **Completeness:** Were relevant questions addressed?
- **Depth:** Was analysis thorough or superficial?
- **Actionability:** Are improvements specific and trackable?
- **Learning:** Is there evidence of real insight, not just compliance?

---

## Reference Materials

- [PROPOSAL-NEW-MODEL.md](./PROPOSAL-NEW-MODEL.md) — Full retrospective transformation proposal
- [Confluence: Retrospective Transformation Solution](https://outsystemsrd.atlassian.net/wiki/spaces/EEO/pages/6118113287/Retrospective+Transformation+Solution+Proposed) — Process documentation
- Production Readiness Checklist — Internal reference (link TBD)
- SRE Guidance Deck — Internal reference (link TBD)

---

## Changelog

**Version 1.3 (2026-04-08)**
- Restructured framework from 3 pillars to 6 pillars
- Framework expanded from 23 to 28 questions
- New pillars: Response & Communication (4 questions), Process Compliance (4 questions)
- Redistributed existing questions across 6 pillars for better alignment
- Rationale: Working session with Vera (2026-04-07) identified need for Response & Communication and Process Compliance pillars. Framework structure now aligns with incident management lifecycle.

**Pillar distribution:**
- Detection & Monitoring: 6 questions
- Response & Communication: 4 questions (1 redistributed + 3 new)
- Troubleshooting & Root Cause: 3 questions
- Recovery & Resolution: 6 questions
- Prevention & Learning: 5 questions
- Process Compliance: 4 questions (1 redistributed + 3 new)

**Version 1.2 (2026-04-08)**
- Added Q7 to Pillar 3 (Learning & Improvement): "Is this a recurring issue?"
- Framework expanded from 22 to 23 questions (7 + 9 + 7)
- Rationale: Critical requirement from working session with Vera (2026-04-07) — framework must measure incident recurrence and validate effectiveness of previous action items

**Version 1.1 (2026-04-08)**
- Added Q7 to Pillar 1 (Detection): "Was incident declaration timely after detection?"
- Added Q9 to Pillar 2 (Troubleshooting & Recovery): "Was customer impact quantified?"
- Framework expanded from 20 to 22 questions (7 + 9 + 6)
- Rationale: Based on analysis of 5 retrospectives, these questions address recurring gaps (declaration timing delays, lack of customer impact quantification)

**Version 1.0 (2026-03-27)**
- Initial framework definition
- 20 questions across 3 pillars (6 + 8 + 6)

---

**Document Owner:** Inês Matos, Vera Branco
**Status:** Active — Use for auditing starting June 2026 pilot
