# RCA Framework — Quality Pillars

**Version:** 2.0
**Last Updated:** 2026-04-23
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

2. **Was the incident detected before customer impact?**
   - Proactive vs reactive detection
   - Customer-detected vs system-detected

3. **Were alerts clear and actionable?**
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
- Detection method clearly identified (how, when, who detected)
- Customer impact timing analyzed (proactive vs reactive)
- Alert effectiveness assessed
- SLO impact quantified (system-wide and service-specific)
- Specific detection improvements proposed

**Red flags:**
- Detection method unclear or missing
- No assessment of alert quality
- SLO impact not mentioned
- No detection improvements identified

---

## Pillar 2: Response & Communication 📣

**Focus:** How timely and effective was the response? Was communication clear and adequate?

### Key Questions

1. **Was incident declaration timely?**
   - How long between issue detection and formal incident creation?
   - If delayed, what caused the delay?
   - Was escalation appropriate and timely?

2. **Was internal communication effective?**
   - Internal communication (team, leadership)
   - Timely and clear updates?

3. **Was external communication effective?**
   - Was the public status page updated promptly?
   - Were customer-facing updates clear and accurate?
   - Was Public MTTA documented?

4. **Was MTTA (Mean Time to Acknowledge) adequate?**
   - How long to acknowledge and start working on the incident?
   - Was the response time acceptable?
   - How does it compare to historical MTTA?

5. **Was status page communication timely and clear?**
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

2. **What is the technical root cause?**
   - Root cause clearly identified with evidence?
   - Evidence-based analysis (logs, traces, 5-Whys)?
   - Goes beyond surface-level symptoms?

3. **Are there architectural issues to address?**
   - Design weaknesses exposed?
   - Scalability issues?
   - Single points of failure?
   - Technical debt contributing to incident?

### Quality Signals

**Good retrospective addresses:**
- Troubleshooting effectiveness analyzed
- Root cause clearly identified with evidence (logs, traces, 5-Whys)
- Architectural issues identified (if applicable)

**Red flags:**
- Troubleshooting process not evaluated
- Root cause vague or missing
- No architectural analysis

---

## Pillar 4: Recovery & Resolution 🩹

**Focus:** How quickly was the incident resolved? What blocked or delayed recovery?

### Key Questions

1. **What was the recovery time (MTTR) and was it acceptable?**
   - How long did recovery take?
   - Was the recovery time acceptable given severity, complexity, and blockers?
   - How does it compare to historical MTTR for similar incidents?

2. **What was the primary method of mitigation?**
   - Rollback of change
   - Fix-forward (new deployment/patch)
   - Configuration change (feature flag, scaling)
   - Manual intervention/workaround

3. **Was rollback considered as a recovery option?**
   - Was rollback evaluated as the fastest recovery path?
   - If rollback was not used, was the decision documented with clear justification?
   - Why was fix-forward chosen over rollback (if applicable)?
   - Was the decision rationale explicit and documented?

4. **Are recovery blockers identified?**
   - What slowed down the recovery?
   - Missing information or context?
   - Tooling gaps?
   - Knowledge gaps? Did the team lack confidence or capability in any area?
   - Coordination issues?

5. **Were runbooks or documentation used and assessed?**
   - Did relevant runbooks exist?
   - Were they used during recovery?
   - Were they accurate and complete?
   - Do runbooks need to be created or updated?

6. **Did dependencies or cascading failures significantly delay recovery?**
   - Impact of upstream/downstream dependencies
   - Cascading failures that amplified impact
   - Cross-team coordination challenges

7. **Was customer impact quantified?**
   - How many customers were affected?
   - What was the duration and severity of impact per customer?
   - Was the business impact assessed and communicated?

### Quality Signals

**Good retrospective addresses:**
- MTTR quantified with analysis of acceptability (severity, complexity, blockers, historical comparison)
- Mitigation method documented
- Rollback consideration documented (used, or justification why not)
- Recovery blockers clearly identified
- Runbook usage and quality documented
- Dependency impact analyzed
- Customer impact quantified with numbers

**Red flags:**
- MTTR not mentioned
- Mitigation method unclear
- Rollback not mentioned (no evidence it was considered)
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

2. **Was recurrence analysis performed?**
   - Were there previous incidents with the same root cause?
   - Were action items from previous retrospectives completed?
   - What systemic issues were not addressed that allowed recurrence?
   - Is there a pattern indicating band-aids instead of systemic fixes?

3. **Are prevention action items defined with clear ownership and tracking?**
   - Specific, actionable items defined?
   - Short-term fixes vs long-term improvements?
   - Address root cause, not just symptoms?
   - Clear ownership assigned for each action item?
   - Tracking mechanism in place (Jira, Problem Management)?
   - Timeline/priority defined?

4. **What learnings did the team gain?**
   - New understanding of system behavior?
   - Previously unknown risk or vulnerability discovered?
   - Learning value beyond fixing this specific issue?

### Quality Signals

**Good retrospective addresses:**
- Change correlation analyzed
- Recurrence analysis performed (checked for similar past incidents)
- Specific, actionable prevention items defined with clear owners, tracking, and timelines
- Learning insights captured (new understanding, broader implications)

**Red flags:**
- Change correlation not investigated
- No check for previous similar incidents or recurring patterns
- Action items generic, vague ("improve monitoring"), or missing ownership/tracking
- No evidence of learning beyond immediate fix

---

## Pillar 6: Process Compliance ✅

**Focus:** Was the incident management and retrospective process followed correctly?

**Note:** Questions 3, 4, and 5 are **post-assessment only** — they evaluate the completed retrospective process and can only be answered after VSL approval.

### Key Questions

1. **Did the incident management process work as expected, and were any gaps identified?**
   - Were roles assigned (Incident Commander, engineers, stakeholders)?
   - Was incident management tooling used (e.g. Rootly)?
   - Were escalation paths followed?
   - If gaps occurred (e.g. delayed declaration, missed escalation): were they identified and analyzed?

2. **If the mitigation required a change (RFC), did it follow Change Management policy?**
   - Was Emergency RFC usage appropriate (system-wide impact declared)?
   - Was risk classification accurate?
   - Was Fast Track usage justified?
   - See [Change Management Patterns](./CHANGE-MANAGEMENT-PATTERNS.md) for detailed analysis guidelines

3. **Was the retrospective completed within SLA (<14 days)?** 📊 *Post-assessment only*
   - Time from incident closure to retrospective completion
   - If delayed, what caused the delay?
   - Was the timeline acceptable?

4. **Is the retrospective documentation clear, complete, and actionable?** 📊 *Post-assessment only*
   - Is the document well-structured and readable?
   - Are all required sections present?
   - Are action items specific and trackable?

5. **Was the retrospective process followed correctly?** 📊 *Post-assessment only*
   - Was retro commander assigned promptly?
   - Was RCA session booked and conducted?
   - Was sign-off obtained (EM review + VS Leader approval)?

### Quality Signals

**Good retrospective addresses:**
- Incident management process evaluated
- Retrospective SLA adherence assessed *(post-assessment)*
- Documentation quality is high (clear, complete, actionable) *(post-assessment)*
- Process steps followed (commander assigned, RCA session, sign-off) *(post-assessment)*
- Change Management policy compliance assessed (if RFC used for mitigation)

**Red flags:**
- No assessment of incident management process
- Retrospective SLA not mentioned or significantly delayed *(post-assessment)*
- Documentation is incomplete or unclear *(post-assessment)*
- Process steps skipped or not followed *(post-assessment)*
- RFC used for mitigation but Change Management compliance not evaluated

**Assessment Timing:**
- **Pre-assessment:** Evaluates Q1-Q2 (incident management, change management)
- **Post-assessment:** Evaluates all Q1-Q5 (includes retrospective process itself)

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

**Version 2.0 (2026-04-23)**
- **Pillar 6, Q3-Q5 marked as "Post-Assessment Only"** — These questions evaluate the completed retrospective process (SLA adherence, documentation quality, process compliance) and can only be answered after VSL approval
- Pre-assessment evaluates 26 questions (Pillar 6 Q1-Q2 only)
- Post-assessment evaluates all 29 questions (includes Pillar 6 Q3-Q5)
- Added assessment timing guidance in Pillar 6 quality signals

**Version 1.9 (2026-04-23)**
- Enhanced Pillar 4, Q4: "Are recovery blockers identified?" to explicitly include team confidence and capability gaps
- Added sub-question: "Did the team lack confidence or capability in any area?"
- Rationale: Lack of confidence is a recovery blocker. Making this explicit helps identify capability-building opportunities and explains recovery delays beyond technical complexity.

**Version 1.8 (2026-04-20)**
- Condensed Pillar 5, Q3 and Q4 into single question: "Are prevention action items defined with clear ownership and tracking?"
- Framework reduced from 30 to 29 questions
- Rationale: Q3 (action items defined) and Q4 (action items owned/tracked) are tightly coupled. Combining them reduces redundancy and emphasizes that action items must have both definition AND ownership/tracking to be effective.

**Pillar distribution:**
- Detection & Monitoring: 6 questions
- Response & Communication: 4 questions
- Troubleshooting & Root Cause: 3 questions
- Recovery & Resolution: 7 questions
- Prevention & Learning: 4 questions (reduced from 5)
- Process Compliance: 5 questions

**Version 1.7 (2026-04-20)**
- Reformulated Pillar 4, Q1: "Was MTTR assessed?" → "What was the recovery time (MTTR) and was it acceptable?"
- Rationale: MTTR is always available (timestamp data). Question should focus on analysis of acceptability considering severity, complexity, blockers, and historical comparison.

**Version 1.6 (2026-04-20)**
- Reformulated questions to be direct inquiries about the incident rather than asking "is X documented?"
- Changed questions:
  - Pillar 1, Q1: "Is the detection method clearly documented?" → "How was the incident initially detected?"
  - Pillar 2, Q4: "Was MTTA documented and adequate?" → "Was MTTA adequate?"
  - Pillar 3, Q2: "Is the technical root cause clearly documented?" → "What is the technical root cause?"
  - Pillar 5, Q5: "Are learnings documented?" → "What learnings did the team gain?"
- Rationale: Questions should guide retrospective writing by asking about the incident itself. Scoring evaluates whether and how well these questions are answered in the document.
- Framework remains at 30 questions, scoring methodology unchanged

**Version 1.5 (2026-04-20)**
- Added Q3 to Pillar 4 (Recovery & Resolution): "Was rollback considered as a recovery option?"
- Framework expanded from 29 to 30 questions
- Rationale: Incident response policy states "your first step should always be to figure out what options you have to mitigate the problem as fast as possible." Rollback is typically the fastest recovery path. Framework must evaluate whether rollback was considered and, if not used, whether the decision was documented with clear justification.
- Reference: [SCENARIO 2 - Incident with system-wide impact - Recovery Measures](https://outsystemsrd.atlassian.net/wiki/spaces/RKB/pages/4977459252/SCENARIO+2+-+Incident+with+system-wide+impact#Recovery-Measures)

**Pillar distribution:**
- Detection & Monitoring: 6 questions
- Response & Communication: 4 questions
- Troubleshooting & Root Cause: 3 questions
- Recovery & Resolution: 7 questions (1 new)
- Prevention & Learning: 5 questions
- Process Compliance: 5 questions

**Version 1.4 (2026-04-20)**
- Added Q2 to Pillar 6 (Process Compliance): "If the mitigation required a change (RFC), did it follow Change Management policy?"
- Framework expanded from 28 to 29 questions
- Question placement: Q2 evaluates incident recovery actions, Q3-5 evaluate retrospective process
- Created companion reference document: CHANGE-MANAGEMENT-PATTERNS.md
- Rationale: Operations Reviews (March-April 2026) identified recurring Change Management compliance gaps during incident recovery (Recovery Bypass, Fast Track misuse, Risk Creep). Framework must evaluate whether recovery actions followed policy.

**Pillar distribution:**
- Detection & Monitoring: 6 questions
- Response & Communication: 4 questions
- Troubleshooting & Root Cause: 3 questions
- Recovery & Resolution: 6 questions
- Prevention & Learning: 5 questions
- Process Compliance: 5 questions (1 new)

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
