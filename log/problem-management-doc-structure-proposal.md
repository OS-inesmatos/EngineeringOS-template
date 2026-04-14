# Problem Management Documentation — Proposed Structure

**Date:** 2026-04-13  
**Context:** Restructure existing Confluence documentation for better navigation, onboarding, and strategic alignment

---

## Design Principles

1. **Progressive Disclosure** — Start simple, reveal complexity as needed
2. **User Journey-Based** — Organize by "what I need to do" not "what exists"
3. **Separate Operational from Strategic** — Day-to-day tasks vs governance/metrics
4. **Discoverability First** — Clear entry points, intuitive hierarchy
5. **Integration-Aware** — Show connections to Incident Response, Retrospectives, M3.4

---

## Proposed Structure

```
Problem Management (landing page)
│
├── 📘 Getting Started
│   ├── What is Problem Management?
│   ├── When to create a Problem Record
│   ├── Your First Problem Record (walkthrough)
│   └── FAQ
│
├── 🔧 Operational Guides
│   ├── Creating Problem Records
│   │   ├── Create from Incident
│   │   ├── Create from Support (Zendesk)
│   │   ├── Create from R&D Discovery
│   │   └── Create from Retrospective [NEW]
│   │
│   ├── Managing Problem Records
│   │   ├── Workflow & States
│   │   ├── Investigation Best Practices
│   │   ├── Writing Root Cause Analysis
│   │   └── Release Notes Guidelines
│   │
│   └── Special Scenarios
│       ├── Security Vulnerabilities
│       ├── Duplicated Problems
│       ├── Feature Requests
│       ├── O11 + ODC Issues
│       └── Systemic Problems [NEW]
│
├── 📚 Reference
│   ├── Jira Fields Guide
│   ├── Status & Transitions
│   ├── Templates
│   │   ├── Description Template
│   │   ├── Root Cause Template
│   │   └── Release Note Template
│   ├── Priority Matrix
│   └── Examples Gallery [NEW]
│       ├── Example: Well-documented RPM
│       ├── Example: Effective Release Note
│       └── Anti-patterns to Avoid
│
├── 📊 Metrics & Governance [NEW]
│   ├── Problem Management Metrics
│   │   ├── Lead Time by State
│   │   ├── Quality Metrics
│   │   └── Outcome Metrics
│   ├── Roles & Responsibilities (RACI)
│   ├── Quality Standards
│   └── Governance Model
│
└── 🔗 Process Integration [NEW]
    ├── Incident Response → Problem Management
    ├── Problem Management → Retrospectives
    ├── Retrospectives → Systemic Problems (M3.4)
    └── Relationship with M3.1 (Failure Management Governance)
```

---

## Page-by-Page Breakdown

### 📘 GETTING STARTED

#### 1. **Problem Management (Landing Page)** [REWRITE]
**Current:** Minimal content  
**Proposed:**

```
# Problem Management

[Brief description: 2-3 sentences explaining what Problem Management is]

## Quick Links

- 🚀 [Your First Problem Record] — New to the process? Start here
- 📋 [Creating Problem Records] — Operational guides
- 📖 [Jira Fields Guide] — Reference for all fields
- 📊 [Metrics Dashboard] — Track process health

## I want to...

- Create a Problem Record → [Creating Problem Records]
- Understand workflow states → [Workflow & States]
- Handle a special scenario → [Special Scenarios]
- Find examples → [Examples Gallery]
- Review metrics → [Problem Management Metrics]

## Recent Updates

[Latest changes to documentation or process]

## Need Help?

- FAQ
- Contact: [Problem Coordinator / PSIRT / your team]
```

**Goal:** Clear entry points, no cognitive overload, "I want to..." user journey

---

#### 2. **What is Problem Management?** [NEW]
**Content:**
- Definition: Problem vs Incident vs Support Case
- Scope: When to create RPM (link to M3.3 heuristic)
- Lifecycle: High-level overview (New → Investigation → Resolution → Closed)
- Roles: Who does what (brief, link to RACI)
- Outcomes: What good Problem Management achieves (prevent recurrence, root cause knowledge, customer transparency)

**Format:** 1-page overview, no deep dives

---

#### 3. **When to create a Problem Record** [NEW]
**Content:**
- **Decision tree:**
  - Is it an active incident affecting customers? → Incident Response first, RPM later
  - Is it a Support Case with known workaround? → Keep as Support Case
  - Is it a defect discovered by R&D? → Create RPM
  - Is it a cluster of incidents (retrospective pattern)? → Create RPM
  - Is it a Security Vulnerability? → Create RPM, mark as vulnerability

- **Scenarios:**
  - Post-Incident: After incident closed, if root cause needs tracking
  - Support-detected: Support finds pattern across multiple cases
  - R&D-detected: During development/testing
  - Security-detected: Vulnerability found
  - Retrospective-detected: Systemic issue from clustered incidents [NEW]

**Goal:** Reduce ambiguity, align with M3.3 triage work

---

#### 4. **Your First Problem Record (Walkthrough)** [NEW]
**Content:**
- Step-by-step with screenshots
- Example scenario: "You found a bug during testing. Let's create your first RPM."
- Every mandatory field explained in context
- Links to templates
- "What happens next?" (workflow preview)

**Format:** Tutorial style, beginner-friendly

---

#### 5. **FAQ** [NEW]
**Content:**
- Q: What's the difference between Problem Record and Problem Management?
  - A: RPM = individual issue. Problem Management (M3.4) = systemic patterns, recurrence prevention
- Q: When should I close an RPM?
- Q: What if I don't know the root cause?
- Q: Do I need a workaround to move to "Investigation Completed"?
- Q: Can I reopen a closed RPM?
- Q: How do RPMs relate to Retrospectives?

---

### 🔧 OPERATIONAL GUIDES

#### 6. **Creating Problem Records** [REORGANIZE EXISTING]
**Parent page with 5 child pages:**

##### 6.1. Create from Incident [EXISTING CONTENT]
- When: Post-incident, if root cause needs tracking
- Who: R&D assigned to incident + Eng Manager decision
- How: [existing content from "ODC Problem Records creation"]
- Link: Must link RPM ↔ RDINC

##### 6.2. Create from Support (Zendesk) [EXISTING CONTENT]
- When: Support detects pattern, or security vulnerability
- Who: Support Agent
- How: Create via Zendesk, use "Zendesk Support" comment area
- Special: PSIRT assignment for vulnerabilities

##### 6.3. Create from R&D Discovery [EXISTING CONTENT]
- When: Bug found during development/testing
- Who: R&D team member
- How: Create directly in RPM project
- Use PACA for team assignment

##### 6.4. Create from Retrospective [NEW]
- When: Retrospective identifies systemic issue (e.g., cluster of 3+ incidents with same root cause)
- Who: Retrospective Commander or assigned R&D team
- How: Link RPM to all related RDINCs, indicate "originated from Retrospective"
- Goal: Capture systemic fix, not just individual incident learnings

##### 6.5. Create from Security Team [EXISTING CONTENT]
- When: Security team identifies vulnerability
- Who: PSIRT
- How: Create RPM, mark as vulnerability, assign to owner team

**Goal:** Clear entry point per origin scenario

---

#### 7. **Managing Problem Records** [REORGANIZE EXISTING]

##### 7.1. Workflow & States [EXISTING: "What does an ODC RPM look like?" — extract workflow section]
**Content:**
- Visual: State diagram (New → Under Investigation → Investigation Completed → Release Planned → Closed)
- Per state:
  - **What it means**
  - **Who is responsible**
  - **What to do**
  - **Exit criteria** (what needs to be true to move to next state)
  - **Mandatory fields**

**Format:**
- Expandable sections per state (Confluence Expand macro)
- Quick reference table at top
- Detailed guidance below

##### 7.2. Investigation Best Practices [NEW]
**Content:**
- How deep should root cause analysis go? (depends on impact, recurrence risk)
- Techniques: 5 Whys, Fishbone, Timeline Analysis
- When to involve other teams
- How to validate workarounds
- Documentation quality standards

**Goal:** Consistency across teams, quality improvement

##### 7.3. Writing Root Cause Analysis [NEW]
**Content:**
- Template breakdown (Symptoms, How to reproduce, Findings, Impact, Urgency Reason)
- Good examples (from Examples Gallery)
- What customers see vs internal
- Avoiding blame language
- Linking to evidence (logs, PRs, related issues)

##### 7.4. Release Notes Guidelines [EXISTING: from "Guidelines for ODC Problem Management fields"]
**Content:**
- Scenario 1: RPM ID in commit → auto-publish
- Scenario 2: Child issues used → manual publish
- Writing style: customer-facing, outcome-focused
- Bad examples vs good examples

---

#### 8. **Special Scenarios** [REORGANIZE EXISTING + NEW]

##### 8.1. Security Vulnerabilities [EXISTING: "How to deal with Security Vulnerabilities"]
- Keep existing content
- Clarify PSIRT role, Criticality → Priority escalation
- Link to VUL project

##### 8.2. Duplicated Problems [EXISTING: "How to deal with duplicated Problem Records?"]
- Keep existing content
- Add: How to detect duplicates (search before creating)

##### 8.3. Feature Requests [EXISTING: "How to deal with Problem Records that lead to Feature Requests"]
- Keep existing content
- Add: Criteria for "Not Fixed with Known Error"

##### 8.4. O11 + ODC Issues [EXISTING: "How to deal with issues affecting O11 and ODC products?"]
- Keep existing content

##### 8.5. Systemic Problems [NEW — CRITICAL FOR M3.4]
**Content:**
- **What is a systemic problem?**
  - Multiple incidents with same root cause (recurrence)
  - Architectural weakness affecting multiple components
  - Process gaps enabling repeated failures

- **When to elevate from RPM to Systemic Problem:**
  - 3+ RPMs with same root cause in 90 days
  - Pattern identified in Retrospectives (e.g., your 8 system-wide incidents)
  - Cross-Value-Stream impact

- **How to handle:**
  - Create "parent" RPM representing systemic issue
  - Link all related RPMs as "causes" / "relates to"
  - Investigation scope: not just fix, but prevention mechanism
  - Outcome: Systemic change (architecture, process, tooling)

- **Link to M3.4:** This is the bridge between operational Problem Records and strategic Problem Management

**Goal:** Foundations for M3.4 work

---

### 📚 REFERENCE

#### 9. **Jira Fields Guide** [EXISTING: "Guidelines for ODC Problem Management fields" + extract from "What does an ODC RPM look like?"]
**Reorganize as:**
- **Mandatory fields** (with * in UI)
- **Optional but recommended**
- **Customer-facing fields** (visible in Support Portal)
- **Internal-only fields**

**Per field:**
- Name
- When to fill
- Guidelines
- Examples

**Format:** Sortable table with filter/search

---

#### 10. **Status & Transitions** [EXISTING: extract from "What does an ODC RPM look like?"]
**Content:**
- All statuses (New, Under Investigation, Investigation Completed, Release Planned, Closed)
- All Status Reason List options (Fixed, Duplicated, Rejected, Not Fixed with Known Error, Inconclusive Investigation)
- Transition rules (what's allowed, what's not)

**Format:** Visual diagram + reference table

---

#### 11. **Templates** [EXISTING: extract templates]

##### 11.1. Description Template
- Current template from "Guidelines for ODC Problem Management fields"
- Add: When to deviate from template

##### 11.2. Root Cause Template
- New: Structured template for root cause (5 Whys, Timeline, Contributing Factors)

##### 11.3. Release Note Template
- Good examples
- Customer-facing vs internal

---

#### 12. **Priority Matrix** [EXISTING: link to existing]
- Urgency x Impact → Priority
- Keep existing, ensure it's linked from multiple places

---

#### 13. **Examples Gallery** [NEW — HIGH VALUE]

##### 13.1. Example: Well-documented RPM
- Real RPM (anonymized if needed) showing:
  - Clear Description (Symptoms, How to reproduce, Findings, Impact)
  - Solid Root Cause Analysis
  - Validated Workaround
  - Customer-facing Release Note
  - Proper linking to child issues

**Annotation:** Call out what makes this good

##### 13.2. Example: Effective Release Note
- 3-4 real Release Notes (good ones)
- Show different scenarios: bug fix, workaround only, systemic change

##### 13.3. Anti-patterns to Avoid
- **Bad Description:** Vague, no reproduction steps
- **Bad Root Cause:** "User error" with no context
- **Bad Release Note:** Too technical, not customer-facing

**Goal:** Learning by example, quality consistency

---

### 📊 METRICS & GOVERNANCE [NEW SECTION — STRATEGIC]

#### 14. **Problem Management Metrics** [NEW — FOUNDATION FOR V2MOM REVIEW]
**Content:**

##### Lead Time Metrics
- **New → Under Investigation:** Assignment delay (who's slow?)
- **Under Investigation → Investigation Completed:** Investigation duration (complexity? blockers?)
- **Investigation Completed → Release Planned:** Development backlog (capacity issue?)
- **Release Planned → Closed:** Release cycle time
- **End-to-end:** New → Closed (total lead time)

**Dashboard:** Link to M3.1 Failure Management Governance dashboards

##### Quality Metrics
- **% RPMs with Root Cause:** Quality of investigation
- **% RPMs with Workaround:** Customer support effectiveness
- **% RPMs auto-closed:** Automation effectiveness (vs manual)
- **Reopened RPMs:** Fix effectiveness

##### Outcome Metrics
- **Recurrence rate:** Same root cause within 90 days
- **Customer satisfaction:** Zendesk feedback on linked RPMs
- **Time to workaround:** Speed of customer relief

##### Distribution Metrics
- RPMs by team (capacity, hot spots)
- RPMs by Product Area (quality signals)
- RPMs by origin (Incident, Support, R&D, Retrospective)

**Target audience:** Eng Managers, Process Engineering, Leadership

---

#### 15. **Roles & Responsibilities (RACI)** [NEW — REDUCES AMBIGUITY]
**Content:**

| Activity | R&D Team | Eng Manager | Problem Coordinator | PSIRT | Support | PM |
|----------|----------|-------------|---------------------|-------|---------|-----|
| **Create RPM (post-incident)** | R | A/R | I | - | I | - |
| **Create RPM (support-detected)** | I | I | I | C (if vuln) | R/A | - |
| **Assign RPM to team** | - | A | R | - | - | - |
| **Investigation** | R/A | C | I | C (if vuln) | I | - |
| **Root Cause Analysis** | R/A | C | I | - | - | - |
| **Define workaround** | R/A | C | I | - | C | - |
| **Create dev tasks** | R/A | C | I | - | - | - |
| **Write Release Note** | R/A | C | - | - | - | C |
| **Decide "Not Fixed"** | C | A/R | I | - | - | C |
| **Close RPM** | R/A | C | - | - | - | - |
| **Quality audit** | - | I | R/A | - | - | - |
| **Metrics review** | I | C | R | - | - | I |

**Legend:**  
R = Responsible (does the work)  
A = Accountable (decision maker, single point)  
C = Consulted (input needed)  
I = Informed (kept in loop)

**Notes:**
- **Problem Coordinator:** Role TBD (Process Engineering? Ops Lead? Rotating?)
- **Eng Manager:** Accountable for RPMs in their team
- **PSIRT:** Consulted on all vulnerabilities

---

#### 16. **Quality Standards** [NEW — WHAT IS "GOOD"?]
**Content:**

##### RPM Creation Quality
- ✅ All mandatory fields filled
- ✅ Description follows template (Symptoms, Repro, Findings, Impact)
- ✅ Correct Product Categorization (use PACA)
- ✅ Linked to originating issue (RDINC, Zendesk, VUL)

##### Investigation Quality
- ✅ Root Cause goes beyond symptoms (not "code bug" but why the bug exists)
- ✅ Workaround validated (tested, documented)
- ✅ "How to confirm you're affected" is customer-actionable

##### Resolution Quality
- ✅ Release Note is customer-facing (no jargon)
- ✅ Fix Version is correct (if applicable)
- ✅ Status Reason matches reality (e.g., don't mark "Fixed" if workaround only)

**Audit criteria:** Process Engineering or Problem Coordinator samples 10% of closed RPMs monthly

---

#### 17. **Governance Model** [NEW — CONTROLLING FRAMEWORK FOR M3.1]
**Content:**

##### KPI Review Cadence
- **Weekly:** Lead time alerts (RPMs stuck >X days)
- **Monthly:** Quality metrics, recurrence rate, distribution by team
- **Quarterly:** Process effectiveness, trends, improvement proposals

##### Who Reviews
- **Weekly:** Eng Managers (own team's RPMs)
- **Monthly:** Process Engineering + Eng Managers
- **Quarterly:** Leadership (Ops Review)

##### Escalation
- RPM stuck >30 days in "Under Investigation" → Eng Manager escalation
- Recurrence rate >10% for same root cause → Systemic problem investigation
- Quality audit fails >20% → Process improvement sprint

##### Process Improvement Loop
- Feedback: via Slack (#problem-management?), Jira, or Process Engineering
- Review: Monthly
- Update: Documentation updated within 1 sprint of decision

**Link to M3.1:** This governance model is part of M3.1 Failure Management Governance controlling framework

---

### 🔗 PROCESS INTEGRATION [NEW SECTION — CRITICAL FOR M3.4]

#### 18. **Incident Response → Problem Management** [NEW]
**Content:**

##### Handoff Criteria
- Incident closed (service restored)
- Root cause known or needs deeper investigation
- Recurrence risk assessed (medium/high → create RPM)

##### Process Flow
1. Incident Commander closes RDINC
2. Eng Manager + R&D assignee decide: Create RPM? (Yes if recurrence risk, customer impact, systemic)
3. If Yes: Create RPM, link RDINC ↔ RPM
4. RPM inherits: Description (from incident timeline), initial root cause (if known), customer impact
5. Investigation continues in RPM (deeper root cause, workaround, fix)

##### Data Continuity
- RPM Description should reference RDINC timeline
- Root Cause in RPM should build on incident postmortem
- Avoid duplicate work: don't re-investigate, extend investigation

**Diagram:** Incident lifecycle → RPM lifecycle (visual)

---

#### 19. **Problem Management → Retrospectives** [NEW]
**Content:**

##### When RPM triggers Retrospective
- Current process: Incident → Retrospective (if Sev1/2 or system-wide)
- Gap: RPMs discovered outside incidents may also need Retrospectives

##### Criteria for RPM → Retrospective
- System-wide impact (multiple customers, multiple components)
- High recurrence risk (affects critical path)
- Organizational learning needed (new failure mode, process gap)

**Decision:** Eng Manager + Process Engineering

##### What Retrospective adds beyond RPM
- **RPM:** What happened, root cause, fix
- **Retrospective:** Why did it happen (organizational factors), prevention mechanisms, learning

---

#### 20. **Retrospectives → Systemic Problems (M3.4)** [NEW — BRIDGE TO M3.4]
**Content:**

##### Current State
- Retrospectives focus on individual incidents (learning from one failure)
- RPMs focus on individual issues (fixing one bug)
- **Gap:** No mechanism to detect patterns across multiple retrospectives/RPMs

##### M3.4 Scope: Problem Management (Systemic)
- **Input:** Clusters of retrospectives with same root cause, same Value Stream, or same component
- **Process:** 
  1. Identify pattern (e.g., your 8 system-wide incidents)
  2. Cluster retrospectives by root cause or Value Stream
  3. Elevate to "Systemic Problem" (not just RPM)
  4. Investigation: Why is this pattern recurring? (architecture, process, tooling gap)
  5. Outcome: Systemic change (not just fix, but prevention architecture)

##### Example: Your Q1 Work
- **Pattern:** 8 system-wide incidents (42.1% of total without retrospective)
- **Clustering:** By Value Stream (Mobile ODC: 3, AI LLM gateway: 3, ALM ODC Portal: 3)
- **Systemic Problem:** "Mobile ODC runtime stability" (3 incidents, recurring pattern)
- **Investigation:** Not just "fix this bug" but "why does Mobile ODC have 3x failure rate?"
- **Outcome:** Architecture review, preventive monitoring, capacity planning

##### Pilot
- Use your Q1 retrospective data (19 incidents, 8 system-wide)
- Cluster by Value Stream
- Create 2-3 "Systemic Problem" RPMs as pilot
- Document learnings → inform M3.4 design

**Goal:** This is the foundation for M3.4 Problem Management (strategic capability)

---

#### 21. **Relationship with M3.1 (Failure Management Governance)** [NEW]
**Content:**

##### M3.1 Scope Recap
- **Failure Management Governance:** Controlling framework for failure lifecycle (Incident, RPM, Retrospective)
- **Deliverables:** Dashboards, KPIs, governance model, process documentation

##### How Problem Management Fits
- **Dashboards:** RPM metrics feed into M3.1 dashboards (lead time, quality, recurrence)
- **Governance:** RPM governance model (page 17) is part of M3.1 controlling framework
- **Process:** RPM documentation is part of M3.1 process documentation review

##### Shared KPIs
- **MTTR (Mean Time to Resolution):** Incident MTTR + RPM lead time
- **Recurrence rate:** Incidents → RPMs → Retrospectives (full cycle)
- **Quality:** Root Cause completeness, workaround effectiveness

**Goal:** Problem Management is not standalone — it's part of integrated Failure Management

---

## Migration Plan (Existing → Proposed)

### Phase 1: Quick Wins (Week 1-2)
1. **Rewrite landing page** with navigation structure
2. **Create "Your First Problem Record" walkthrough**
3. **Create Examples Gallery** (1 good RPM, 1 good Release Note, 2 anti-patterns)
4. **Add FAQ page**

**Effort:** 1-2 days  
**Impact:** Immediate improvement in onboarding and navigation

---

### Phase 2: Reorganization (Week 3-4)
1. **Reorganize "Creating Problem Records"** into 5 child pages (Incident, Support, R&D, Retrospective, Security)
2. **Split "What does an ODC RPM look like?"** into:
   - Workflow & States (page 7.1)
   - Jira Fields Guide (page 9)
   - Status & Transitions (page 10)
3. **Extract templates** into dedicated pages (11.1, 11.2, 11.3)
4. **Consolidate Special Scenarios** (page 8)

**Effort:** 2-3 days (mostly cut/paste + light rewrite)  
**Impact:** Better structure, less overwhelming

---

### Phase 3: Strategic Additions (Q2 — Aligned with M3.4)
1. **Problem Management Metrics** (page 14) — link to M3.1 dashboards
2. **RACI matrix** (page 15)
3. **Quality Standards** (page 16)
4. **Governance Model** (page 17)
5. **Process Integration** (pages 18-21):
   - Incident Response → Problem Management
   - Problem Management → Retrospectives
   - Retrospectives → Systemic Problems (M3.4)
   - M3.1 integration

**Effort:** 1-2 weeks (requires alignment with stakeholders, data from dashboards)  
**Impact:** Elevates Problem Management from operational process to strategic capability

---

### Phase 4: Content Enrichment (Ongoing)
1. **Investigation Best Practices** (page 7.2)
2. **Writing Root Cause Analysis** (page 7.3)
3. **More examples** in Examples Gallery
4. **Video walkthroughs** (optional, if high demand)

**Effort:** Incremental  
**Impact:** Quality consistency, self-service

---

## Success Metrics for New Documentation

### Usability
- **Time to first RPM (new user):** <15 min (down from ?)
- **FAQ page views:** High traffic = successful self-service
- **Examples Gallery page views:** High traffic = people learning by example

### Quality
- **% RPMs meeting quality standards:** Target 80% (baseline TBD)
- **Quality audit pass rate:** >80%

### Adoption
- **New pages traffic:** "Your First Problem Record", "Examples Gallery", "Metrics" should be top 5
- **Search terms:** Track what people search for (gaps = content to add)

### Strategic Impact (Q2+)
- **Retrospective-led RPMs created:** Track usage of new scenario (page 6.4)
- **Systemic Problems identified:** Track elevations from clusters (page 8.5, page 20)
- **Governance meetings held:** KPI reviews happening per model (page 17)

---

## Next Steps (For You)

### This Week
1. **Share this proposal** with stakeholders (Vera? Laura? Eng Managers?)
2. **Prioritize:** Phase 1 Quick Wins + Phase 2 Reorganization (can be done now)
3. **V2Mom metrics review:** Use page 14 structure as input for your metrics work

### Q2 (M3.4 Prep)
1. **Get buy-in** for Phase 3 Strategic Additions
2. **Align with M3.1:** Ensure Problem Management metrics feed into M3.1 dashboards
3. **Pilot "Systemic Problems":** Use your 8 system-wide incidents as test case (page 20)

### Socialize
- Present restructure in Ops Review? Staff meeting?
- Get feedback from 2-3 teams (pilot users)
- Iterate based on feedback

---

## Summary

**Current State:**  
7 operational pages, good content, poor structure

**Proposed State:**  
21 pages in 5 sections (Getting Started, Operational, Reference, Metrics & Governance, Integration)

**Key Additions:**
- 📘 Onboarding (Your First RPM, FAQ, Examples)
- 📊 Strategic layer (Metrics, RACI, Governance)
- 🔗 Integration (Incident → RPM → Retrospective → M3.4)

**Effort:**  
- Phase 1-2: 1 week (quick wins + reorganization)
- Phase 3: 1-2 weeks in Q2 (strategic, aligned with M3.4)

**Impact:**  
Transform from operational manual to strategic documentation supporting M3.1, M3.3, M3.4 goals
