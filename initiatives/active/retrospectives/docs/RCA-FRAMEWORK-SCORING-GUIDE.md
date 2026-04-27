# RCA Framework — Scoring Guide

**Version:** 2.3
**Last Updated:** 2026-04-27
**Purpose:** Detailed scoring criteria for evaluating retrospective quality against RCA Framework (30 questions: 26 for pre-assessment, 29 for post-assessment)

---

## Scoring Scale

Each question is scored using a **3-point scale**:

| Score | Symbol | Meaning | Criteria |
|-------|--------|---------|----------|
| **1.0** | ✅ | **Fully Addressed** | Question explicitly answered with depth, evidence, and analysis |
| **0.5** | ⚠️ | **Present but Weak** | Mentioned but lacks depth, analysis, or evidence |
| **0.0** | ❌ | **Missing** | Not addressed in the retrospective document |
| **N/A** | 🚫 | **Not Applicable** | Question not relevant to this specific incident |

---

## How to Score

### Step 1: Read the Question
Understand what the question is asking for.

### Step 2: Search the Retrospective
Look for evidence in the retrospective document that addresses this question.

### Step 3: Evaluate Depth
Assess whether the answer provides:
- **Data/Evidence:** Specific numbers, timestamps, names, logs, links
- **Analysis:** Explanation of why/how, not just what happened
- **Context:** Enough detail to understand the situation

### Step 4: Assign Score
Use the criteria below for each question.

### Step 5: Validate Action Items (Pillar 5, Q3)

**For action items tracked in Jira, validate mandatory fields:**

When evaluating "Are prevention action items defined with clear ownership and tracking?" (Pillar 5, Q3):

1. **Extract Jira IDs** from the retrospective (e.g., RPLAT-3819, RDICE-5047)
2. **Use `mcp__claude_ai_Atlassian__getJiraIssue`** to retrieve ticket details (⚠️ do NOT use `acli` — it does not return the `duedate` field reliably)
3. **Verify mandatory fields** in each Jira ticket:
   - **Assignee (Jira field)** — Owner assigned (not blank)? ⚠️ **MANDATORY**
   - **Due Date (Jira field)** — Due Date populated? ⚠️ **MANDATORY**
     - ⚠️ **RPOR project exception:** For RPOR tickets, Due Date is stored as **"Target end"** (`customfield_15486`), not `duedate`. Request both fields when calling `getJiraIssue`.
   - **RDINC Link** — Ticket must have a Jira link of type **"reviews"** pointing to the RDINC issue of this retrospective ⚠️ **MANDATORY**
     - Check the `issuelinks` field in the `getJiraIssue` response (include `issuelinks` in `fields` param)
4. **Red flags — flag but do not auto-fail:**
   - **Discarded status** — action item may not be executed; requires explanation of replacement or rationale
5. **Score based on completeness:**
   - ✅ **1.0**: All action items have Jira IDs + all mandatory fields complete (Assignee + Due Date + RDINC link) + no Discarded tickets without documented explanation
   - ⚠️ **0.5**: Jira IDs present but 1+ mandatory fields missing OR any ticket Discarded without documented replacement/rationale
   - ❌ **0.0**: No Jira IDs OR Jira tickets don't exist

**Why these fields are mandatory:**
- **Assignee**: Without a named owner, accountability is unclear
- **Due Date**: Without a Due Date, completion commitment is unclear; delays cannot be detected
- **RDINC Link ("reviews")**: Without the link, action items are disconnected from the incident; traceability is broken
- **Discarded**: A Discarded action item that isn't replaced leaves the root cause unaddressed

**Validation method:**
- Use `mcp__claude_ai_Atlassian__getJiraIssue` with `fields: ["duedate", "assignee", "status", "summary", "issuelinks", "customfield_15486"]`
- If Jira access unavailable, mark as "Inconclusive — manual verification required"

---

## Pillar 1: Detection & Monitoring 🕵️ (6 questions, 6 points max)

### Q1: How was the incident initially detected?

**What we're looking for:**
- How was the incident first detected?
- Who detected it?
- When was it detected?

**Scoring:**

| Score | Criteria | Example |
|-------|----------|---------|
| ✅ **1.0** | Detection method explicitly stated with context (source, time, who detected) | "Customer reported via support ticket #12345 at 14:03 UTC. SLO alert RDINC-72522 triggered at 10:16 UTC." |
| ⚠️ **0.5** | Detection method mentioned but lacks detail (no time, no source details) | "Detected by customer report." |
| ❌ **0.0** | Detection method not mentioned or unclear | No mention of how incident was discovered |

---

### Q2: Was the incident detected before customer impact?

**What we're looking for:**
- Was detection proactive (alert/monitoring) or reactive (customer report)?
- Did we detect it before customers noticed?

**Scoring:**

| Score | Criteria | Example |
|-------|----------|---------|
| ✅ **1.0** | Clear statement about detection timing vs customer impact, with analysis | "SLO alert triggered at 10:16, incident declared at 15:09 (~5h delay). Customer impact started at 10:00. Detection was reactive, customer-reported." |
| ⚠️ **0.5** | Detection timing mentioned but no analysis of proactive vs reactive | "Customer reported the issue." |
| ❌ **0.0** | No information about detection timing relative to customer impact | No mention of when detection happened vs impact |

---

### Q3: Were alerts clear and actionable?

**What we're looking for:**
- Was the alert clear about what was wrong?
- Did it provide enough context for rapid response?
- Did it suggest actionable next steps?

**Scoring:**

| Score | Criteria | Example |
|-------|----------|---------|
| ✅ **1.0** | Alert effectiveness explicitly assessed with specific analysis | "SLO alert RDINC-72522 was unclear. Alert message: 'High error rate' without context about which service or customer impact. Team spent 30min identifying root cause location." |
| ⚠️ **0.5** | Alert mentioned but effectiveness not analyzed | "SLO alert triggered." |
| ❌ **0.0** | No assessment of alert quality/actionability | No mention of alert clarity |
| 🚫 **N/A** | No alert involved (e.g., customer-detected only) | "Customer reported directly to support, no alert." |

---

### Q4: Was the Error Budget of a System-wide SLO affected?

**What we're looking for:**
- Which system-wide SLOs were affected?
- How much error budget was consumed?

**Scoring:**

| Score | Criteria | Example |
|-------|----------|---------|
| ✅ **1.0** | System-wide SLO impact quantified with error budget consumption | "System-wide 'Deployment Success Rate' SLO dropped to 85% (target: 95%). Consumed 15% of monthly error budget." |
| ⚠️ **0.5** | System-wide SLO impact mentioned but not quantified | "System-wide SLO was affected." |
| ❌ **0.0** | No mention of system-wide SLO impact | No SLO impact documented |
| 🚫 **N/A** | No system-wide SLO affected (only service-specific) | "Only 'DUV Deployment Success' (service-specific) affected." |

---

### Q5: Was the Error Budget of a Service-specific SLO affected?

**What we're looking for:**
- Which service-specific SLOs were affected?
- How much error budget was consumed?

**Scoring:**

| Score | Criteria | Example |
|-------|----------|---------|
| ✅ **1.0** | Service-specific SLO impact quantified with error budget consumption | "DUV 'Deployment Success Rate' SLO dropped to 75% (target: 98%). Consumed 40% of monthly error budget." |
| ⚠️ **0.5** | Service-specific SLO impact mentioned but not quantified | "DUV SLO was impacted." |
| ❌ **0.0** | No mention of service-specific SLO impact | No SLO impact documented |
| 🚫 **N/A** | No service-specific SLO affected | "Only system-wide SLOs affected." |

---

### Q6: What can be improved in detection?

**What we're looking for:**
- Specific proposals for detection improvements
- New alerts needed?
- Alert tuning required?
- Monitoring gaps identified?

**Scoring:**

| Score | Criteria | Example |
|-------|----------|---------|
| ✅ **1.0** | Specific, actionable detection improvements proposed with rationale | "Add alert for NATS permission violations (currently no alert). Alert should trigger when >5% of deployments fail with 'permission denied' error. Target: <1min detection." |
| ⚠️ **0.5** | Detection improvements mentioned but vague or generic | "Improve monitoring." |
| ❌ **0.0** | No detection improvements proposed | No mention of how to improve detection |
| 🚫 **N/A** | Detection was adequate, no improvements needed | "Detection was immediate and effective, no improvements needed." |

---

## Pillar 2: Response & Communication 📣 (4 questions, 4 points max)

### Q1: Was incident declaration timely?

**What we're looking for:**
- How long between detection and formal incident declaration?
- If delayed, what caused the delay?
- Was escalation appropriate and timely?

**Scoring:**

| Score | Criteria | Example |
|-------|----------|---------|
| ✅ **1.0** | Incident declaration timing documented and analyzed (with delay explanation if applicable) | "Alert at 10:16, incident declared at 15:09 (~5h delay). Delay due to initial misclassification as non-system-wide. Escalation to SRE at 14:50 after multiple customer reports." |
| ⚠️ **0.5** | Timing mentioned but no analysis of delays or escalation | "Incident declared at 15:09." |
| ❌ **0.0** | No information about incident declaration timing | No mention of when incident was declared |

---

### Q2: Was internal communication effective?

**What we're looking for:**
- Was internal communication timely and clear?
- Were stakeholders properly informed?
- Was Slack/incident channel communication effective?

**Scoring:**

| Score      | Criteria                                                                         | Example                                                                                                                                             |
| ---------- | -------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| ✅ **1.0**  | Internal communication effectiveness explicitly assessed with specific analysis  | "Slack channel created immediately. IC provided updates every 30min. RDM and ICE teams added to channel within 15min. Communication was effective." |
| ⚠️ **0.5** | Internal communication described with some detail, but no effectiveness judgment | "Slack channel created at 02:06. Cross-team coordination involved SRE and Identity Core."                                                           |
| ❌ **0.0**  | No mention of internal communication                                             | No mention of internal communication                                                                                                                |

**Decision rule:** ✅ requires either (a) an explicit effectiveness judgment ("communication was effective/ineffective") OR (b) assessment of at least two aspects (e.g., update frequency + stakeholder coverage + gap analysis). Describing *what happened* without evaluating *whether it was sufficient* = ⚠️.

---

### Q3: Was external communication effective?

**What we're looking for:**
- Was the public status page updated promptly?
- Were customer-facing updates clear and accurate?
- Was Public MTTA documented?

**Scoring:**

| Score | Criteria | Example |
|-------|----------|---------|
| ✅ **1.0** | External communication assessed with status page update timing and Public MTTA | "Status page updated at 15:20 (11min after declaration). Public MTTA: 20min. Customer-facing updates clear: 'Deployment issues affecting 10% of production environments.' Communication was timely." |
| ⚠️ **0.5** | External communication mentioned but not assessed for effectiveness/timing | "Status page was updated." |
| ❌ **0.0** | No assessment of external communication | No mention of customer communication |
| 🚫 **N/A** | No external customer impact (internal-only incident) | "Internal infrastructure issue, no customer-facing communication needed." |

---

### Q4: Was MTTA (Mean Time to Acknowledge) adequate?

**What we're looking for:**
- How long to acknowledge and start working on the incident?
- Was the response time acceptable?
- How does it compare to historical MTTA?

**Scoring:**

| Score | Criteria | Example |
|-------|----------|---------|
| ✅ **1.0** | MTTA documented with assessment of adequacy | "MTTA: 25min (alert at 10:16, team started troubleshooting at 10:41). Acceptable given initial misclassification. Historical MTTA for SEV2: 15min." |
| ⚠️ **0.5** | MTTA value mentioned but not assessed | "MTTA: 25min." |
| ❌ **0.0** | MTTA not mentioned | No mention of response time |

---

## Pillar 3: Troubleshooting & Root Cause 🔍 (3 questions, 3 points max)

### Q1: Were troubleshooting steps effective?

**What we're looking for:**
- Did the team know where to look?
- Were troubleshooting tools adequate?
- Were logs/metrics/traces helpful?

**Scoring:**

| Score | Criteria | Example |
|-------|----------|---------|
| ✅ **1.0** | Troubleshooting effectiveness explicitly assessed with specific details | "Team reviewed Grafana traces and identified NATS permission errors in logs within 30min. Traces were helpful. However, no runbook existed for NATS permission issues, requiring RDM team consultation." |
| ⚠️ **0.5** | Troubleshooting steps listed but effectiveness not assessed | "Team checked logs and contacted RDM team." |
| ❌ **0.0** | No assessment of troubleshooting effectiveness | No mention of troubleshooting process |

---

### Q2: What is the technical root cause?

**What we're looking for:**
- Root cause clearly identified with evidence?
- Evidence-based analysis (5 Whys, logs, traces)?
- Goes beyond surface-level symptoms?

**Scoring:**

| Score | Criteria | Example |
|-------|----------|---------|
| ✅ **1.0** | Root cause clearly identified with evidence and 5-Whys or equivalent analysis | "Root cause: NATS consumer renaming in DUV 1.0.170 (PR #858) caused permission race condition during deployment. Evidence: stack traces show 'permission denied' errors. 5-Whys analysis included." |
| ⚠️ **0.5** | Root cause mentioned but lacks depth or evidence | "NATS permissions issue." |
| ❌ **0.0** | No root cause identified or only surface symptoms described | "Deployments failed." (symptom, not root cause) |

---

### Q3: Are there architectural issues to address?

**What we're looking for:**
- Design weaknesses exposed?
- Scalability issues?
- Single points of failure?
- Technical debt contributing to incident?

**Scoring:**

| Score | Criteria | Example |
|-------|----------|---------|
| ✅ **1.0** | Architectural issues explicitly identified with systemic analysis | "NATS Operator has inherent concurrency limitations. No automated infrastructure-level constraints possible. Systemic issue: relies on developer discipline for backward-compatible changes." |
| ⚠️ **0.5** | Architectural issues mentioned but not analyzed | "Infrastructure has limitations." |
| ❌ **0.0** | No architectural analysis | No mention of architectural issues |
| 🚫 **N/A** | No architectural issues identified (isolated bug fix) | "Bug in code logic, no architectural implications." |

---

## Pillar 4: Recovery & Resolution 🩹 (7 questions, 7 points max)

### Q1: What was the recovery time (MTTR) and was it acceptable?

**What we're looking for:**
- How long did recovery take?
- Was the recovery time acceptable given severity, complexity, and blockers?
- How does it compare to historical MTTR for similar incidents?

**Scoring:**

| Score      | Criteria                                                                                                              | Example                                                                                                                                                                                                                          |
| ---------- | --------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ✅ **1.0**  | MTTR quantified with analysis of acceptability (considering severity, complexity, blockers, or historical comparison) | "MTTR: OSALL 6.8h, EA 1h. OSALL longer than typical (4h) due to race condition complexity requiring manual intervention across 24 stamps. EA faster due to fix-forward strategy already developed. Acceptable given complexity." |
| ⚠️ **0.5** | MTTR value mentioned and delay cause analyzed, BUT no explicit acceptability judgment                                 | "MTTR: ~2h. Detection gap caused 1h32min delay due to SEV3 misclassification." (explains why but doesn't assess if acceptable)                                                                                                   |
| ❌ **0.0**  | MTTR not mentioned                                                                                                    | No mention of recovery time                                                                                                                                                                                                      |

**Decision rule:** Analyzing the *cause* of delay is not sufficient for ✅. The retrospective must also make an explicit acceptability judgment — either comparing to the SEV target (e.g., "SEV1 target <30min; actual 2h — unacceptable") or explaining why the duration was acceptable given circumstances. Cause without judgment = ⚠️.

---

### Q2: What was the primary method of mitigation?

**What we're looking for:**
- Rollback, fix-forward, configuration change, or manual intervention?
- Method clearly documented?

**Scoring:**

| Score | Criteria | Example |
|-------|----------|---------|
| ✅ **1.0** | Mitigation method explicitly documented with details | "Fix-forward: RFC-4388 deployed DUV 1.0.171 with traces disabled. Manual intervention: RFC-4375 reconciled NATS permissions in OSALL (24 stamps affected)." |
| ⚠️ **0.5** | Mitigation method mentioned but lacks details | "Fix deployed." |
| ❌ **0.0** | Mitigation method not documented | No mention of how incident was resolved |

---

### Q3: Was rollback considered as a recovery option?

**What we're looking for:**
- Was rollback evaluated as the fastest recovery path?
- If rollback was not used, was the decision documented with clear justification?

**Scoring:**

| Score | Criteria | Example |
|-------|----------|---------|
| ✅ **1.0** | Rollback consideration explicitly documented (used, or clear justification why not) | "Rollback not feasible: NATS v0.2.467 already auto-promoted to EA. Rollback would trigger same permission race condition. Fix-forward chosen: deploy v0.2.468 with traces disabled." |
| ⚠️ **0.5** | Rollback mentioned but justification weak or unclear | "Rollback not possible." (no explanation why) |
| ❌ **0.0** | No mention of rollback consideration | No evidence rollback was evaluated |
| 🚫 **N/A** | Incident not change-related (infrastructure failure, external dependency) | "AWS EKS control plane failure, not deployment-related." |

---

### Q4: Are recovery blockers identified?

**What we're looking for:**
- What slowed down the recovery?
- Missing information, tooling gaps, knowledge gaps, coordination issues?
- Did the team lack confidence or capability in any area?

**Scoring:**

| Score      | Criteria                                                      | Example                                                                                                                                                                                                                                                                             |
| ---------- | ------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ✅ **1.0**  | Recovery blockers explicitly identified with specific details | "Blockers: (1) Race condition complexity required RDM team expertise (30min to engage). Team lacked confidence troubleshooting NATS permission issues. (2) Manual RFC needed for each affected stamp (15min per stamp × 24 stamps = 6h). (3) Time to identify all affected stamps." |
| ⚠️ **0.5** | Recovery blockers mentioned but not specific                  | "Recovery was slow."                                                                                                                                                                                                                                                                |
| ❌ **0.0**  | No recovery blockers identified                               | No analysis of what slowed recovery                                                                                                                                                                                                                                                 |
| 🚫 **N/A** | Recovery was fast with no blockers                            | "Fix deployed in 10min, no blockers."                                                                                                                                                                                                                                               |

---

### Q5: Were runbooks or documentation used and assessed?

**What we're looking for:**
- Did relevant runbooks exist?
- Were they used during recovery?
- Were they accurate and complete?
- Do runbooks need to be created or updated?

**Scoring:**

| Score | Criteria | Example |
|-------|----------|---------|
| ✅ **1.0** | Runbook usage explicitly documented and assessed | "No runbook existed for NATS permission troubleshooting. Team consulted RDM engineers. Action item: create runbook for deployment-induced permission race conditions." |
| ⚠️ **0.5** | Runbook mentioned but not assessed for accuracy/completeness | "Runbook was used." |
| ❌ **0.0** | No mention of runbook usage | No assessment of documentation |

---

### Q6: Did dependencies or cascading failures significantly delay recovery?

**What we're looking for:**
- Impact of upstream/downstream dependencies?
- Cascading failures that amplified impact?
- Cross-team coordination challenges?

**Scoring:**

| Score | Criteria | Example |
|-------|----------|---------|
| ✅ **1.0** | Dependency impact explicitly documented with analysis | "Dependencies impacted recovery: (1) NATS Operator concurrency limitations prevented parallel fixes. (2) Deployment auto-promotion to EA bypassed OSALL validation. (3) Cross-team coordination: RDM + ICE collaboration required 45min to align." |
| ⚠️ **0.5** | Dependencies mentioned but not analyzed for impact | "Dependencies were involved." |
| ❌ **0.0** | No mention of dependency impact | No analysis of dependencies |
| 🚫 **N/A** | No dependencies involved (isolated service) | "Single-service incident, no dependencies." |

---

### Q7: Was customer impact quantified?

**What we're looking for:**
- How many customers were affected?
- What was the duration and severity of impact per customer?
- Was the business impact assessed?

**Scoring:**

| Score | Criteria | Example |
|-------|----------|---------|
| ✅ **1.0** | Customer impact quantified with specific numbers | "100+ incidents triggered (Nobl9 metric ingestion gap). No end-user customer impact observed. Duration: 1-2h gap in SLO data. Business impact: internal monitoring gap only." |
| ⚠️ **0.5** | Customer impact mentioned but not quantified | "Customers were impacted." |
| ❌ **0.0** | Customer impact not mentioned or only stated generically | "Some impact observed." |
| 🚫 **N/A** | No customer impact (internal-only incident) | "Internal tooling incident, no customer impact." |

---

## Pillar 5: Prevention & Learning 🧠 (4 questions, 4 points max)

### Q1: Was the incident caused by a recent change?

**What we're looking for:**
- Direct link to deployment, configuration change, or code change?
- Change Failure Rate (CFR) implications?
- Deployment process gaps?

**Scoring:**

| Score | Criteria | Example |
|-------|----------|---------|
| ✅ **1.0** | Change correlation explicitly documented with evidence | "Caused by DUV 1.0.170 deployment (PR #858) which renamed NATS consumer. Deployment completed at 09:45, incident started at 10:00. Change Failure Rate: 1/50 deployments this week." |
| ⚠️ **0.5** | Change mentioned but correlation not clearly established | "Related to recent deployment." |
| ❌ **0.0** | No analysis of change correlation | No mention of recent changes |
| 🚫 **N/A** | Incident not change-related | "Infrastructure failure, not deployment-related." |

---

### Q2: Was recurrence analysis performed?

**What we're looking for:**
- Were there previous incidents with the same root cause?
- Were action items from previous retrospectives completed?
- What systemic issues were not addressed that allowed recurrence?

**Scoring:**

| Score | Criteria | Example |
|-------|----------|---------|
| ✅ **1.0** | Recurrence analysis explicitly performed with search for similar incidents | "Searched retrospectives for NATS-related incidents. Found RDINC-68234 (March 2026): similar permission issue but different root cause (IAM config). No recurrence of this specific race condition. Previous action items completed." |
| ⚠️ **0.5** | Recurrence mentioned but not thoroughly analyzed | "No previous similar incidents found." (no evidence of search) |
| ❌ **0.0** | No recurrence analysis performed | No mention of checking for previous incidents |

---

### Q3: Are prevention action items defined with clear ownership and tracking?

**What we're looking for:**
- Specific, actionable items defined?
- Short-term fixes vs long-term improvements?
- Address root cause, not just symptoms?
- Clear ownership assigned for each action item?
- Tracking mechanism in place (Jira, Problem Management)?
- **Due Date defined?** ⚠️ **MANDATORY**

**Mandatory Jira Fields (when action items tracked in Jira):**
1. **Assignee** — Owner assigned (Jira field, not blank) ⚠️ **MANDATORY**
2. **Due Date** — Target completion date populated (Jira field) ⚠️ **MANDATORY**
3. **RDINC Link** — Jira link of type **"reviews"** pointing to the RDINC issue ⚠️ **MANDATORY**

**Red flags (flag, do not auto-fail):**
- **Discarded status** — action item may not be executed; requires explanation of replacement or rationale

**Scoring:**

| Score      | Criteria                                                                                                                              | Example                                                                                                                                        |
| ---------- | ------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| ✅ **1.0**  | All action items have Jira IDs + Assignee + Due Date + RDINC link ("reviews") populated, and no Discarded tickets without explanation | "RDICE-5047 (owner: ICE team, due: 2026-04-30, reviews RDINC-78746). RDMOT-2129 (owner: Observability, due: 2026-06-30, reviews RDINC-78746)." |
| ⚠️ **0.5** | Jira IDs present but any mandatory field missing on 1+ tickets, OR any ticket Discarded without documented replacement/rationale      | "RDICE-5047 — no assignee." OR "RDMOT-2129 — Due Date blank." OR "RDICE-5047 — no RDINC link." OR ticket Discarded with no explanation.        |
| ❌ **0.0**  | No action items defined or only generic mentions                                                                                      | No prevention measures proposed                                                                                                                |

**Note:** Acceptance Criteria format is a team decision — do not validate or score it.

---

### Q4: Were existing automated tests sufficient to prevent or detect this issue? If not, are new tests defined as action items?

**What we're looking for:**
- Did existing tests (unit, integration, end-to-end) catch the issue before production?
- If not, why? What gap existed in test coverage?
- Are new tests or test improvements defined as tracked action items?

**Scoring:**

| Score      | Criteria                                                                                                                                                                 | Example                                                                                                                                                                                                   |
| ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ✅ **1.0**  | Test coverage explicitly assessed — identifies which tests existed and why they failed (or confirms no tests applied), AND new tests are defined as tracked action items | "No tests covered the NATS consumer rename scenario. Existing integration tests mocked the NATS layer. Action item RCQA-6580 created to add end-to-end deployment tests with consumer rename validation." |
| ⚠️ **0.5** | Test gap mentioned but not analyzed, OR new tests referenced without explaining why existing tests failed                                                                | "Tests did not catch this. New tests to be added."                                                                                                                                                        |
| ❌ **0.0**  | No mention of test coverage or whether new tests are needed                                                                                                              | No analysis of test coverage or testing improvements                                                                                                                                                      |
| 🚫 **N/A** | Incident not caused by a code/deployment change where automated tests would apply                                                                                        | "Infrastructure failure: EKS node crash — automated tests would not have prevented this."                                                                                                                 |

---

## Pillar 6: Process Compliance ✅ (5 questions, 5 points max)

**Note:** Questions 3, 4, and 5 are **post-assessment only** — they evaluate the completed retrospective and can only be scored after VSL approval.

### Q1: Did the incident management process work as expected, and were any gaps identified?

**What we're looking for:**
- Were roles assigned (Incident Commander, engineers, stakeholders)?
- Was incident management tooling used (e.g. Rootly)?
- Were escalation paths followed?
- If gaps occurred: were they identified and analyzed?

**Scoring logic:** Inverted burden of proof — assume the process worked unless evidence of failure exists. Structural evidence (roles documented, tooling used) is sufficient for ✅. Only penalise when gaps are present but unacknowledged, or when there is no evidence of process at all.

| Score      | Criteria                                                                        | Example                                                                                                                                                                                                          |
| ---------- | ------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ✅ **1.0**  | Roles assigned + tooling used + any gaps identified AND analyzed                | "Roles assigned: Incident Commander (Juan de Miguel), Stakeholder, Engineers. Rootly used. Declaration delayed 1h48m — root cause analyzed (SEV3 classification prevented on-call paging). Action item created." |
| ⚠️ **0.5** | Roles assigned + tooling used, BUT gaps present and not analyzed                | "Roles documented. Declaration was delayed but no explanation provided."                                                                                                                                         |
| ❌ **0.0**  | No evidence of incident management process (no roles, no tooling, no structure) | No mention of roles, tooling, or incident process                                                                                                                                                                |

---

### Q2: If the mitigation required a change (RFC), did it follow Change Management policy?

**What we're looking for:**
- Was Emergency RFC usage appropriate (system-wide impact declared)?
- Did the change follow ring progression (OSALL → EA → GA)?
- Was risk classification accurate?
- Was Fast Track usage justified?

**See:** [CHANGE-MANAGEMENT-PATTERNS.md](./CHANGE-MANAGEMENT-PATTERNS.md) for detailed scoring guidance

**Scoring:**

| Score | Criteria | Example |
|-------|----------|---------|
| ✅ **1.0** | Change Management policy compliance explicitly assessed with all criteria evaluated | "RFC-4388 (Emergency): System-wide impact declared correctly. Followed ring progression OSALL → EA → GA. Risk classification: High (accurate). Fast Track not used. Policy compliant." |
| ⚠️ **0.5** | Partial compliance assessed or some gaps identified with justification | "RFC-4388 used Recovery Bypass (directly to GA) due to SEV1 urgency. Approved by SRE Lead. Partial compliance." |
| ❌ **0.0** | RFC used but compliance not assessed, or clear policy violations | "RFC-4388 used Emergency for non-system-wide incident. Policy violation." |
| 🚫 **N/A** | No RFC needed for mitigation | "Mitigation: service restart, no RFC required." |

---

### Q3: Was the retrospective completed within SLA (<14 days)? 📊 *Post-Assessment Only*

**What we're looking for:**
- Time from incident closure to retrospective completion?
- If delayed, what caused the delay?
- Was the timeline acceptable?

**Scoring:**

| Score | Criteria | Example |
|-------|----------|---------|
| ✅ **1.0** | Retrospective SLA documented and assessed (with delay explanation if applicable) | "Incident closed: Nov 3. Retrospective completed: Nov 10 (7 days). Within SLA (<14 days). No delays." |
| ⚠️ **0.5** | SLA mentioned but not assessed or delay not explained | "Retrospective completed 20 days after incident closure." (no explanation) |
| ❌ **0.0** | No mention of retrospective timeline | No information about SLA compliance |

---

### Q4: Is the retrospective documentation clear, complete, and actionable? 📊 *Post-Assessment Only*

**What we're looking for:**
- Is the document well-structured and readable?
- Are all required sections present?
- Are action items specific and trackable?

**Scoring:**

| Score | Criteria | Example |
|-------|----------|---------|
| ✅ **1.0** | Retrospective is well-structured, complete, and actionable | "Document includes: Executive Summary, Timeline, Root Cause (5-Whys), Recovery Actions, Action Items (with owners and Jira links). Clear structure, actionable items." |
| ⚠️ **0.5** | Retrospective is present but incomplete or unclear | "Document has root cause but missing action items or timeline unclear." |
| ❌ **0.0** | Retrospective is poorly structured or missing key sections | "Retrospective is minimal, no root cause analysis, no action items." |

**Note:** This is a meta-question about the retrospective document itself.

---

### Q5: Was the retrospective process followed correctly? 📊 *Post-Assessment Only*

**What we're looking for:**
- Was retro commander assigned promptly?
- Was RCA session booked and conducted?
- Was sign-off obtained (EM review + VS Leader approval)?

**Scoring:**

| Score | Criteria | Example |
|-------|----------|---------|
| ✅ **1.0** | Retrospective process explicitly documented and followed | "Commander assigned: Nov 4 (1 day after closure). RCA session: Nov 7 (3 attendees). Sign-off: EM review (Nov 9), VSL approval (Nov 10). Process followed." |
| ⚠️ **0.5** | Process mentioned but not complete or delays not explained | "Commander assigned Nov 10 (7 days after closure)." (delay not explained) |
| ❌ **0.0** | No evidence of retrospective process being followed | No information about commander assignment, RCA session, or sign-off |

---

## Overall Score Calculation

### Per-Pillar Score

**Formula:**
```
Pillar Score (%) = (Points Earned / Points Possible) × 100
```

**Example — Pillar 1: Detection & Monitoring**
- Q1: 1.0 ✅
- Q2: 0.5 ⚠️
- Q3: 0.0 ❌
- Q4: N/A 🚫 (not counted)
- Q5: 0.5 ⚠️
- Q6: 0.5 ⚠️

**Calculation:**
- Points Earned: 1.0 + 0.5 + 0.0 + 0.5 + 0.5 = 2.5
- Points Possible: 5 (Q4 is N/A, so 6 - 1 = 5)
- Pillar Score: 2.5 / 5 = 50%

---

### Overall Quality Score

**Formula:**
```
Overall Score (%) = (Total Points Earned / Total Points Possible) × 100
```

**Pre-Assessment vs Post-Assessment:**
- **Pre-Assessment:** Evaluates 26 questions (Pillars 1-5 full + Pillar 6 Q1-Q2 only)
  - Maximum possible: 26 points
- **Post-Assessment:** Evaluates all 29 questions (includes Pillar 6 Q3-Q5)
  - Maximum possible: 29 points

**Example — Post-Assessment (Full Framework)**
- Pillar 1: 2.5 / 5 points
- Pillar 2: 3.0 / 4 points
- Pillar 3: 2.5 / 3 points
- Pillar 4: 4.0 / 7 points
- Pillar 5: 3.5 / 4 points
- Pillar 6: 3.5 / 5 points

**Calculation:**
- Total Earned: 2.5 + 3.0 + 2.5 + 4.0 + 3.5 + 3.5 = 19.0
- Total Possible: 5 + 4 + 3 + 7 + 4 + 5 = 28
- Overall Score: 19.0 / 28 = 67.9% → **68/100**

**Example — Pre-Assessment (Excludes Pillar 6 Q3-Q5)**
- Pillar 1-5: Same as above = 16.5 points
- Pillar 6: 1.5 / 2 points (only Q1, Q2 scored)

**Calculation:**
- Total Earned: 16.5 + 1.5 = 18.0
- Total Possible: 5 + 4 + 3 + 7 + 4 + 2 = 26
- Pre-Assessment Score: 18.0 / 26 = 69.2% → **69/100**

---

### Quality Thresholds

| Threshold | Symbol | Status | Interpretation |
|-----------|--------|--------|----------------|
| **70%+** | 🟢 | **Good Quality** | Ready for approval, meets quality standards |
| **40-70%** | 🟡 | **Needs Improvement** | RCA working session recommended to address gaps |
| **<40%** | 🔴 | **Significant Gaps** | Requires substantial work before approval |

---

## N/A Handling

**When a question is marked N/A:**
- It is **excluded** from the denominator (points possible)
- It does **not** penalize the score
- Rationale: Some questions don't apply to every incident type

**Example:**
- Total questions: 29
- N/A questions: 3
- Scoring basis: 26 questions (29 - 3)

---

## Edge Cases & Guidance

### Case 1: Implicit Information

**Question:** "Was MTTR assessed?"
**Document says:** "Incident lasted 6 hours."

**How to score:**
- ⚠️ **0.5** — MTTR value is present (6h) but not assessed (no analysis of adequacy)
- Not ✅ **1.0** — no assessment of whether 6h was acceptable

---

### Case 2: Partial Evidence

**Question:** "Are prevention action items defined with clear ownership and tracking?"
**Document says:** "RDICE-5047 created, assigned to ICE team."

**How to score:**
- ⚠️ **0.5** — Owner mentioned but no timeline or tracking mechanism
- Not ✅ **1.0** — incomplete (missing timeline and tracking)

---

### Case 3: Multiple Sub-Questions

**Question:** "Were alerts clear and actionable?"
**Sub-questions:**
- Was the alert clear about what was wrong?
- Did it provide enough context for rapid response?
- Did it suggest actionable next steps?

**How to score:**
- ✅ **1.0** — All sub-questions addressed with depth
- ⚠️ **0.5** — Some sub-questions addressed but not all, or superficial coverage
- ❌ **0.0** — No sub-questions addressed

---

### Case 4: Data Without Analysis

**Question:** "Was MTTR assessed?"
**Document says:** "MTTR: 6.8 hours."

**How to score:**
- ⚠️ **0.5** — Data present but no analysis (was it acceptable? why that duration?)
- Not ✅ **1.0** — analysis missing

**Better example for 1.0:**
> "MTTR: 6.8 hours. This was longer than typical (historical: 4h) due to race condition complexity requiring manual intervention across 24 stamps. Acceptable given circumstances."

---

## Reviewer Calibration

To ensure consistency across reviewers:

1. **Start with sample retrospectives** — Score 2-3 known retrospectives
2. **Compare scores** — Discuss differences in interpretation
3. **Refine criteria** — Adjust scoring guide based on edge cases
4. **Re-score periodically** — Validate consistency over time

---

## Version History

**Version 2.3 (2026-04-27)**
- **Pillar 5, Q4 added (tests)** — "Were existing automated tests sufficient to prevent or detect this issue? If not, are new tests defined as action items?" added to force explicit test coverage analysis
- **Pre-assessment: 26 questions (was 25); Post-assessment: 29 questions (was 28)**
- Replaces the previously removed "learnings" Q4 with a more actionable test coverage question

**Version 2.2 (2026-04-27)**
- **Pillar 5, Q4 removed** — "What learnings did the team gain?" eliminated; learnings are already captured through P3 Q2 (root cause), P3 Q3 (architectural issues), P5 Q2 (recurrence), and P5 Q3 (action items)
- **Pre-assessment: 25 questions (was 26); Post-assessment: 28 questions (was 29)**
- **P4 Q1 decision rule added** — Cause analysis without acceptability judgment = ⚠️, not ✅
- **P2 Q2 decision rule added** — Describing what happened without effectiveness judgment = ⚠️, not ✅

**Version 2.1 (2026-04-24)**
- **Pillar 5, Q3: Due Date now mandatory** — Action items must have Due Date populated to score ✅ 1.0
- Added "Step 5: Validate Action Items" in "How to Score" section with Jira validation instructions
- Updated Q3 scoring criteria to include mandatory Jira fields: Description, Acceptance Criteria, Assignee, **Due Date**
- Added rationale: Due Date is mandatory for tracking commitment and detecting delays
- Validation method: Use `acli jira workitem view <ISSUE-KEY>` to verify fields

**Version 2.0 (2026-04-23)**
- **Pillar 6, Q3-Q5 marked as "Post-Assessment Only"** — These questions evaluate the completed retrospective process
- Added note at Pillar 6 header explaining post-assessment only questions
- Updated Overall Score Calculation with Pre-Assessment vs Post-Assessment examples
- Pre-assessment: 26 questions (max 26 points), Post-assessment: 29 questions (max 29 points)
- Aligns with RCA Framework v2.0

**Version 1.4 (2026-04-23)**
- Updated Pillar 4, Q4 scoring criteria to include team confidence and capability gaps
- Added "Did the team lack confidence or capability in any area?" to "What we're looking for"
- Updated scoring example to reflect confidence/capability gaps as recovery blockers
- Aligns with RCA Framework v1.9

**Version 1.3 (2026-04-20)**
- Updated to match RCA Framework v1.8 (29 questions)
- Condensed Pillar 5, Q3 and Q4 into single question: "Are prevention action items defined with clear ownership and tracking?"
- Framework reduced from 30 to 29 questions
- Updated overall score calculation example to reflect 28 points possible (29 questions, assuming 1 N/A)
- Updated edge case examples

**Version 1.2 (2026-04-20)**
- Updated Pillar 4, Q1 to match RCA Framework v1.7: "What was the recovery time (MTTR) and was it acceptable?"
- Scoring now emphasizes analysis of acceptability considering severity, complexity, blockers, and historical comparison

**Version 1.1 (2026-04-20)**
- Updated question formulations to match RCA Framework v1.6
- Questions now ask directly about the incident (e.g., "How was the incident initially detected?" instead of "Is the detection method clearly documented?")
- Scoring criteria unchanged: evaluate whether and how well these questions are answered in the retrospective

**Version 1.0 (2026-04-20)**
- Initial scoring guide created
- Based on RCA Framework v1.5 (30 questions)
- 3-point scale: 1.0 (Fully Addressed), 0.5 (Present but Weak), 0.0 (Missing), N/A
- Detailed scoring criteria for all questions across 6 pillars

---

**Document Owner:** Inês Matos
**Status:** Active — Use for retrospective auditing
**Related Documents:**
- [RCA-FRAMEWORK-PILLARS.md](./RCA-FRAMEWORK-PILLARS.md) — Framework questions
- [CHANGE-MANAGEMENT-PATTERNS.md](./CHANGE-MANAGEMENT-PATTERNS.md) — Pillar 6, Q2 detailed guidance
